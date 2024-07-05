import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:tata/src/utils/tarot.dart';

part 'chat_room_repository.g.dart';

class ChatRoomRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;

  // Get Lobby Chat Room List
  Future<List<ChatRoom>> getLobbyChatRoomList({
    required bool isInitFetch,
    required String category,
  }) async {
    if (isInitFetch) {
      _lastDocument = null;
    }

    Query<Map<String, dynamic>> collection = category == 'All'
        ? _fireStore
            .collection('chat_rooms')
            .where('is_closed', isEqualTo: false)
            .where('type', isEqualTo: ChatRoomType.normal.value)
            .orderBy('create_time', descending: true)
        : _fireStore
            .collection('chat_rooms')
            .where('is_closed', isEqualTo: false)
            .where('type', isEqualTo: ChatRoomType.normal.value)
            .where('category', isEqualTo: category)
            .orderBy('create_time', descending: true);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = isInitFetch
        ? await collection.limit(10).get()
        : await collection.startAfterDocument(_lastDocument!).limit(10).get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    List<ChatRoom> chatRoomList = querySnapshot.docs
        .map((chatRoom) => ChatRoom.fromJson(chatRoom.data()))
        .toList();

    _lastDocument = querySnapshot.docs.last;

    return chatRoomList;
  }

  // Get Realtime Chat Room List
  Future<List<ChatRoom>> getRealtimeChatRoomList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
        .collection('chat_rooms')
        .where('type', isEqualTo: ChatRoomType.realtime.value)
        .get();

    List<ChatRoom> chatRoomList = querySnapshot.docs
        .map((chatRoom) => ChatRoom.fromJson(chatRoom.data()))
        .toList();

    return chatRoomList;
  }

  // Get User Chat Room List
  Stream<List<Either<ChatRoom, TarotNightRoom>>> getUserChatRoomList() {
    final String currentUserId = _firebaseAuth.currentUser?.uid ?? '';

    return _fireStore
        .collectionGroup('members')
        .where('uid', isEqualTo: currentUserId)
        .snapshots()
        .asyncMap((querySnapshot) async {
      var roomIds = querySnapshot.docs
          .map((doc) => doc.reference.parent.parent!.id)
          .toSet();

      if (roomIds.isNotEmpty) {
        List<ChatRoom?> chatRooms = await Future.wait(roomIds
            .map((roomId) => _fireStore
                    .collection('chat_rooms')
                    .doc(roomId)
                    .get()
                    .then((value) {
                  final Map<String, dynamic>? data = value.data();

                  if (data == null) {
                    return null;
                  }

                  return ChatRoom.fromJson(data);
                }))
            .toList());

        List<TarotNightRoom?> tarotNightRooms = await Future.wait(roomIds
            .map((roomId) => _fireStore
                    .collection('tarot_night_rooms')
                    .doc(roomId)
                    .get()
                    .then((value) {
                  final Map<String, dynamic>? data = value.data();
                  if (data == null) {
                    return null;
                  }

                  TarotNightRoom.fromJson(data);
                }))
            .toList());

        List<Either<ChatRoom, TarotNightRoom>> rooms = [];
        for (var chatRoom in chatRooms) {
          if (chatRoom != null) {
            rooms.add(left(chatRoom));
          }
        }
        for (var tarotNightRoom in tarotNightRooms) {
          if (tarotNightRoom != null) {
            rooms.add(right(tarotNightRoom));
          }
        }

        rooms.sort((a, b) {
          final aTimestamp = a.fold(
              (chatRoom) => chatRoom.latestMessage!.timestamp,
              (tarotNightRoom) => tarotNightRoom.latestMessage!.timestamp);
          final bTimestamp = b.fold(
              (chatRoom) => chatRoom.latestMessage!.timestamp,
              (tarotNightRoom) => tarotNightRoom.latestMessage!.timestamp);
          return bTimestamp.compareTo(aTimestamp);
        });

        return rooms;
      } else {
        return <Either<ChatRoom, TarotNightRoom>>[];
      }
    });
  }

  // Send Message
  Future<void> sendMessage(
      AppUserInfo userInfo, String chatRoomId, String message) async {
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: userInfo.uid,
      name: userInfo.name,
      avatar: userInfo.avatar,
      content: message,
      timestamp: timestamp,
      readBy: [userInfo.uid],
    );

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());

    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
      'latest_message': newMessage.toJson(),
    });
  }

  // Get Messages
  Stream<List<Message>> getMessages(String chatRoomId) {
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<Message> messages = querySnapshot.docs
          .map((message) => Message.fromJson(message.data()))
          .toList();

      return messages.isEmpty ? <Message>[] : messages;
    });
  }

  // Mark as read
  Future<void> markAsRead(String chatRoomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .get()
        .then((querySnapshot) {
      for (var message in querySnapshot.docs) {
        message.reference.update({
          'read_by': FieldValue.arrayUnion([currentUserId]),
        });
      }
    });
  }

  // Get Unread Message Count
  Stream<int> getUnreadMessageCount(String chatRoomId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((message) =>
                !(message.get('read_by') as List).contains(currentUserId))
            .length);
  }

  // Create a new chat room
  Future<String> createChatRoom({
    required String title,
    required String description,
    required String category,
    required int limit,
    // TarotCardKey? backgroundImage,
  }) async {
    final DocumentReference newChatRoomDoc =
        _fireStore.collection('chat_rooms').doc();

    late TarotCardKey backgroundImage;

    switch (category) {
      case 'Romance':
        backgroundImage = TarotCardKey.lovers;
        break;
      case 'Work':
        backgroundImage = TarotCardKey.chariot;
        break;
      case 'Interest':
        backgroundImage = TarotCardKey.magician;
        break;
      case 'Sport':
        backgroundImage = TarotCardKey.sun;
        break;
      case 'ChitChat':
        backgroundImage = TarotCardKey.fool;
        break;
      case 'School':
        backgroundImage = TarotCardKey.highPriestess;
        break;
      default:
        backgroundImage = Tarot.getRandomCard();
    }

    final ChatRoom newChatRoom = ChatRoom(
        id: newChatRoomDoc.id,
        type: ChatRoomType.normal,
        title: title,
        description: description,
        category: category,
        backgroundImage: backgroundImage,
        limit: limit,
        hostId: _firebaseAuth.currentUser!.uid,
        memberCount: 1,
        createTime: Timestamp.now(),
        latestMessage: Message(
          senderId: 'system',
          name: 'system',
          avatar: AvatarKey.theFool,
          content: 'Welcome to the chat room!',
          timestamp: Timestamp.now(),
          readBy: [_firebaseAuth.currentUser!.uid],
        ),
        isClosed: false);

    final userInfo = await _fireStore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    await newChatRoomDoc.set(newChatRoom.toJson());
    await _fireStore
        .collection('chat_rooms')
        .doc(newChatRoom.id)
        .collection('members')
        .doc(_firebaseAuth.currentUser!.uid)
        .set({
      ...userInfo.data()!.cast<String, dynamic>(),
      'role': 'host',
    });

    await _fireStore
        .collection('chat_rooms')
        .doc(newChatRoom.id)
        .collection('messages')
        .add(Message(
          senderId: 'system',
          name: 'system',
          avatar: AvatarKey.theFool,
          content: 'Welcome to the chat room!',
          timestamp: Timestamp.now(),
          readBy: [_firebaseAuth.currentUser!.uid],
        ).toJson());

    return newChatRoom.id;
  }

  // Create a new realtime chat room
  Future<String> createRealtimeChatRoom() async {
    final DocumentReference newChatRoomDoc =
        _fireStore.collection('chat_rooms').doc();

    final ChatRoom newChatRoom = ChatRoom(
        id: newChatRoomDoc.id,
        type: ChatRoomType.realtime,
        title: '',
        description: '',
        category: '',
        backgroundImage: TarotCardKey.fool,
        limit: 2,
        memberCount: 1,
        hostId: _firebaseAuth.currentUser!.uid,
        createTime: Timestamp.now(),
        latestMessage: Message(
          senderId: 'system',
          name: 'system',
          avatar: AvatarKey.theFool,
          content: 'Welcome to the chat room!',
          timestamp: Timestamp.now(),
          readBy: [_firebaseAuth.currentUser!.uid],
        ),
        isClosed: false);

    final userInfo = await _fireStore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    await newChatRoomDoc.set(newChatRoom.toJson());
    await _fireStore
        .collection('chat_rooms')
        .doc(newChatRoom.id)
        .collection('members')
        .doc(_firebaseAuth.currentUser!.uid)
        .set({
      ...userInfo.data()!.cast<String, dynamic>(),
      'role': 'host',
    });

    await _fireStore
        .collection('chat_rooms')
        .doc(newChatRoom.id)
        .collection('messages')
        .add(Message(
          senderId: 'system',
          name: 'system',
          avatar: AvatarKey.theFool,
          content: 'Welcome to the chat room!',
          timestamp: Timestamp.now(),
          readBy: [_firebaseAuth.currentUser!.uid],
        ).toJson());

    return newChatRoom.id;
  }

  // Get Room Info
  Future<ChatRoom> getChatRoomInfo(String roomId) async {
    final ChatRoom chatRoom = await _fireStore
        .collection('chat_rooms')
        .doc(roomId)
        .get()
        .then((value) => ChatRoom.fromJson(value.data()!));

    return chatRoom;
  }

  // Edit Room Info
  Future<void> editChatRoomInfo(
      {required String roomId,
      required String title,
      required String description,
      required String category,
      required int limit}) async {
    await _fireStore.collection('chat_rooms').doc(roomId).update({
      'title': title,
      'description': description,
      'category': category,
      'limit': limit,
    });
  }

  // Join a chat room
  Future<void> joinChatRoom(String roomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final ChatRoom chatRoom = await _fireStore
        .collection('chat_rooms')
        .doc(roomId)
        .get()
        .then((value) => ChatRoom.fromJson(value.data()!));
    final List<MemberInfo> members = await _fireStore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('members')
        .get()
        .then((value) => value.docs
            .map((member) => MemberInfo.fromJson(member.data()))
            .toList());

    if (members.any((member) => member.uid == currentUserId)) {
      return;
    }

    if (members.length == chatRoom.limit) {
      throw Exception('Room is full');
    }

    final userInfo = await _fireStore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    await _fireStore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('members')
        .doc(currentUserId)
        .set({...userInfo.data()!.cast<String, dynamic>(), 'role': 'member'});

    await _fireStore.collection('chat_rooms').doc(roomId).update({
      'member_count': FieldValue.increment(1),
    });
  }

  // Leave a chat room
  Future<void> leaveChatRoom(String chatRoomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    await removeMember(chatRoomId: chatRoomId, memberId: currentUserId);
  }

  // Close a chat room
  Future<void> closeChatRoom(String chatRoomId) async {
    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
      'is_closed': true,
    });

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('members')
        .get()
        .then((value) => value.docs.forEach((member) {
              removeMember(chatRoomId: chatRoomId, memberId: member.id);
            }));

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(Message(
          senderId: 'system',
          name: 'system',
          avatar: AvatarKey.theFool,
          content: '聊天室已經關閉',
          timestamp: Timestamp.now(),
          readBy: [_firebaseAuth.currentUser!.uid],
        ).toJson());
  }

  // Get members of a chat room
  Future<List<MemberInfo>> getMembers(String chatRoomId) async {
    final List<MemberInfo> members = await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('members')
        .get()
        .then((value) => value.docs
            .map((member) => MemberInfo.fromJson(member.data()))
            .toList());

    return members;
  }

  // Remove a member from a chat room
  Future<void> removeMember(
      {required String chatRoomId, required String memberId}) async {
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('members')
        .doc(memberId)
        .delete();

    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
      'member_count': FieldValue.increment(-1),
    });
  }

  // Delete a chat room
  Future<void> deleteChatRoom(String chatRoomId) async {
    var chatRoomRef = _fireStore.collection('chat_rooms').doc(chatRoomId);

    // Example subcollections
    List<String> subcollections = ['messages', 'members'];

    // Iterate through each known subcollection
    for (var subcollectionName in subcollections) {
      // Reference to the subcollection
      var subcollectionRef = chatRoomRef.collection(subcollectionName);

      // Get all documents in the subcollection
      var documents = await subcollectionRef.get();

      // Iterate through each document and delete it
      for (var doc in documents.docs) {
        await doc.reference.delete();
      }
    }

    // After all subcollections have been handled, delete the chat room document
    await chatRoomRef.delete();
  }
}

@Riverpod(keepAlive: true)
ChatRoomRepository chatRoomRepository(ChatRoomRepositoryRef ref) =>
    ChatRoomRepository();

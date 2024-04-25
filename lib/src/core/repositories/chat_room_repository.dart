import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/ui/tarot.dart';

part 'chat_room_repository.g.dart';

class ChatRoomRepository {
  static final ChatRoomRepository _instance = ChatRoomRepository._internal();

  factory ChatRoomRepository() {
    return _instance;
  }

  ChatRoomRepository._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;

  // Get Lobby Chat Room List
  Future<List<ChatRoom>> getLobbyChatRoomList(bool isInitFetch) async {
    if (isInitFetch) {
      _lastDocument = null;
    }

    Query<Map<String, dynamic>> collection = _fireStore
        .collection('chat_rooms')
        .where('type', isEqualTo: ChatRoomType.normal.value)
        .orderBy('create_time', descending: true);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = isInitFetch
        ? await collection.limit(10).get()
        : await collection.startAfterDocument(_lastDocument!).limit(10).get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    List<ChatRoom> chatRoomList = querySnapshot.docs
        .map((chatRoom) => ChatRoom.fromMap(chatRoom.data()))
        .toList();

    _lastDocument = querySnapshot.docs.last;

    return chatRoomList;
  }

  // Get User Chat Room List
  Stream<List<ChatRoom>> getUserChatRoomList() {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    return _fireStore
        .collection('chat_rooms')
        .where('members', arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((chatRoom) => ChatRoom.fromMap(chatRoom.data()))
            .toList());
  }

  // Send Message
  Future<void> sendMessage(String chatRoomId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      message: message,
      timestamp: timestamp,
    );

    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
      'messages': FieldValue.arrayUnion([newMessage.toMap()]),
      'latest_message': newMessage.toMap(),
    });
  }

  // Get Messages
  Stream<List<Message>> getMessages(String chatRoomId) {
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .snapshots()
        .map((event) {
      final List<Message> messages = List<Message>.from(
          event.data()?['messages'].map((e) => Message.fromMap(e)));

      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      return messages.reversed.toList();
    });
  }

  // Create a new chat room
  Future<String> createChatRoom({
    required String title,
    required String description,
    required String category,
    required TarotCard backgroundImage,
    required int limit,
  }) async {
    final DocumentReference newChatRoomDoc =
        _fireStore.collection('chat_rooms').doc();

    final ChatRoom newChatRoom = ChatRoom(
        id: newChatRoomDoc.id,
        type: ChatRoomType.normal,
        title: title,
        description: description,
        category: category,
        backgroundImage: backgroundImage,
        limit: limit,
        hostId: _firebaseAuth.currentUser!.uid,
        members: [_firebaseAuth.currentUser!.uid],
        createTime: Timestamp.now());

    // create chat room
    newChatRoomDoc.set(newChatRoom.toMap());

    // return chat room id
    return newChatRoomDoc.id;
  }

  // Join a chat room
  Future<void> joinChatRoom(ChatRoom chatRoomInfo) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    if (chatRoomInfo.members.contains(currentUserId)) {
      print('Already joined the chat room');
      return;
    }

    if (chatRoomInfo.members.length == chatRoomInfo.limit) {
      print('Chat room is full');
      throw Exception('Chat room is full');
    }

    // add current user to chat room members
    await _fireStore.collection('chat_rooms').doc(chatRoomInfo.id).update({
      'members': FieldValue.arrayUnion([currentUserId])
    });

    // navigate to chat room in controller
  }

  // Leave a chat room
  Future<void> leaveChatRoom(String chatRoomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // remove current user from chat room members
    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
      'members': FieldValue.arrayRemove([currentUserId])
    });

    // navigate to chat room list in controller
  }

  // Remove a member from a chat room
  Future<void> removeMember(
      {required String chatRoomId, required String memberId}) async {
    // remove member from chat room members
    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
      'members': FieldValue.arrayRemove([memberId])
    });

    // navigate to chat room list in controller
  }
}

@riverpod
ChatRoomRepository chatRoomRepository(ChatRoomRepositoryRef ref) =>
    ChatRoomRepository();

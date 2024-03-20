import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_chat/src/models/chat_room.dart';
import 'package:eq_chat/src/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get Lobby Chat Room List
  // TODO: pagination
  Stream<QuerySnapshot> getLobbyChatRoomList() {
    return _fireStore.collection('chat_rooms').snapshots();
  }

  // Get User Chat Room List
  // TODO: pagination
  Stream<QuerySnapshot> getUserChatRoomList() {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    return _fireStore
        .collection('chat_rooms')
        .where('members', arrayContains: currentUserId)
        .snapshots();
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
  Future<String> createChatRoom(
    String title,
    String description,
    int limit,
  ) async {
    final DocumentReference newChatRoomDoc =
        _fireStore.collection('chat_rooms').doc();

    final ChatRoom newChatRoom = ChatRoom(
        id: newChatRoomDoc.id,
        type: ChatRoomType.normal,
        title: title,
        description: description,
        limit: limit,
        members: [_firebaseAuth.currentUser!.uid]);

    // create chat room
    newChatRoomDoc.set(newChatRoom.toMap());

    // return chat room id
    return newChatRoomDoc.id;
  }

  // Join a chat room
  Future<void> joinChatRoom(String chatRoomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // add current user to chat room members
    await _fireStore.collection('chat_rooms').doc(chatRoomId).update({
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

  // Realtime Pair
  Future<ChatRoom?> realtimePair() async {
    print("Start pairing");
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // find a realtime chat room with members less than 2
    final QuerySnapshot<Map<String, dynamic>> chatRoomSnapshot =
        await _fireStore
            .collection('chat_rooms')
            .where('type', isEqualTo: ChatRoomType.realtime.toString())
            .get();
    print(chatRoomSnapshot.docs.length);
    for (var element in chatRoomSnapshot.docs) {
      final ChatRoom chatRoom = ChatRoom.fromMap(element.data());
      print(chatRoom.title);
      if (chatRoom.members.length < 2) {
        print("Found a chat room with members less than 2");
        // join the chat room
        await _fireStore.collection('chat_rooms').doc(chatRoom.id).update({
          'members': FieldValue.arrayUnion([currentUserId])
        });

        // navigate to chat room in controller
        return chatRoom;
      }
    }
    print("Not found a chat room with members less than 2");
    return waitForPaired();
  }

  Future<ChatRoom?> waitForPaired() async {
    print("Waiting for paired");
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // create a new realtime chat room and wait for the other user
    final DocumentReference newChatRoomDoc =
        _fireStore.collection('chat_rooms').doc();

    final ChatRoom newChatRoom = ChatRoom(
      id: newChatRoomDoc.id,
      type: ChatRoomType.realtime,
      title: '',
      description: '',
      limit: 2,
      members: [currentUserId],
    );
    print("Create a new chat room: ${newChatRoom.id}");
    newChatRoomDoc.set(newChatRoom.toMap());
    // check every 3 secs for 10 times
    for (var i = 0; i < 10; i++) {
      print("Checking for the $i time");
      await Future.delayed(const Duration(seconds: 3));

      // check if chat room have member > 1
      final QuerySnapshot<Map<String, dynamic>> chatRoomSnapshot =
          await _fireStore
              .collection('chat_rooms')
              .where('id', isEqualTo: newChatRoomDoc.id)
              .get();

      final bool isPaired =
          ChatRoom.fromMap(chatRoomSnapshot.docs[0].data()).members.length > 1;

      if (isPaired) {
        // navigate to chat room in controller
        print("Paired");
        return newChatRoom;
      }
    }
    print("Stop waiting");
    return null;

    // stop waiting and navigate to chat room list in controller
  }
}

// Join A Chat Room: 
// Get Chat Room List (Select Id) 
// -> Join by id 
// -> Get Messages Stream by id
// Send message | Leave chat room

// Create A Chat Room:
// Create a new chat room (Generate Id) 
// -> Join by id 
// -> Get Messages Stream by id
// Send message | Leave chat room

// Realtime Pair:
// Get the chat room list with type: realtime
// Found → Add user to member list & navigate to chat room.
// Not found →  Create a new chat room & waiting 
// Check every 3 secs → 10 times → stop
// Chat room have member > 1 → navigate to chat room
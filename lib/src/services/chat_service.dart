import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_chat/src/models/chat_room.dart';
import 'package:eq_chat/src/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get Chat Room List
  Stream<QuerySnapshot> getChatRoomList() {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    return _fireStore
        .collection('chat_rooms')
        // .where('members', arrayContains: currentUserId)
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
    ChatRoomType type,
    int limit,
  ) async {
    final DocumentReference newChatRoomDoc =
        _fireStore.collection('chat_rooms').doc();

    final ChatRoom newChatRoom = ChatRoom(
        id: newChatRoomDoc.id,
        type: type,
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
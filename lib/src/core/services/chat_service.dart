import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
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
      'messages': FieldValue.arrayUnion([newMessage.toJson()]),
      'latest_message': newMessage.toJson(),
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
          event.data()?['messages'].map((e) => Message.fromJson(e)));

      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      return messages.reversed.toList();
    });
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
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

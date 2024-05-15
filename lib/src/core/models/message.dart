import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      senderId: map['sender_id'] ?? '',
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}

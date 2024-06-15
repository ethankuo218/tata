import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/utils/avatar.dart';

class Message {
  final String senderId;
  final String name;
  final AvatarKey avatar;
  final String content;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.name,
    required this.avatar,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      senderId: map['sender_id'] ?? '',
      name: map['name'] ?? '',
      avatar: AvatarKey.toEnum(map['avatar']),
      content: map['content'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'name': name,
      'avatar': avatar.value,
      'content': content,
      'timestamp': timestamp,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/utils/avatar.dart';

class Message {
  final String senderId;
  final String name;
  final AvatarKey avatar;
  final String content;
  final Timestamp timestamp;
  final List<String> readBy;

  Message({
    required this.senderId,
    required this.name,
    required this.avatar,
    required this.content,
    required this.timestamp,
    required this.readBy,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['sender_id'] ?? '',
      name: json['name'] ?? '',
      avatar: AvatarKey.toEnum(json['avatar']),
      content: json['content'],
      timestamp: json['timestamp'],
      readBy: json['read_by'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'name': name,
      'avatar': avatar.value,
      'content': content,
      'timestamp': timestamp,
      'read_by': readBy,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/utils/avatar.dart';

class TarotNightMessage extends Message {
  final TarotNightMessageType type;
  final String role;

  TarotNightMessage({
    required super.senderId,
    required super.name,
    required super.avatar,
    required super.content,
    required super.timestamp,
    required super.readBy,
    this.type = TarotNightMessageType.normal,
    this.role = '',
  });

  factory TarotNightMessage.fromJson(Map<String, dynamic> json) {
    return TarotNightMessage(
      senderId: json['sender_id'] as String,
      name: json['name'] as String,
      avatar: AvatarKey.toEnum(json['avatar']),
      content: json['content'] as String,
      timestamp: json['timestamp'] as Timestamp,
      type: TarotNightMessageType.toEnum(json['type']),
      role: json['role'] as String,
      readBy: json['read_by'].cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'name': name,
      'avatar': avatar.value,
      'content': content,
      'timestamp': timestamp,
      'type': type.value,
      'role': role,
      'read_by': readBy,
    };
  }
}

enum TarotNightMessageType {
  normal('normal'),
  system('system'),
  testResult('test_result'),
  answer('answer');

  const TarotNightMessageType(this.value);

  factory TarotNightMessageType.toEnum(String x) {
    var filter = values.where((element) => element.value == x);

    if (filter.isEmpty) {
      throw Exception('Invalid input value');
    }

    return filter.first;
  }

  final String value;
}

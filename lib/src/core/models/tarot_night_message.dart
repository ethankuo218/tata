import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/ui/avatar.dart';

class TarotNightMessage extends Message {
  final TarotNightMessageType type;

  TarotNightMessage({
    required super.senderId,
    required super.name,
    required super.avatar,
    required super.message,
    required super.timestamp,
    this.type = TarotNightMessageType.normal,
  });

  factory TarotNightMessage.fromJson(Map<String, dynamic> json) {
    return TarotNightMessage(
      senderId: json['sender_id'] as String,
      name: json['name'] as String,
      avatar: AvatarKey.toEnum(json['avatar']),
      message: json['message'] as String,
      timestamp: json['timestamp'] as Timestamp,
      type: TarotNightMessageType.toEnum(json['type']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'name': name,
      'avatar': avatar.value,
      'message': message,
      'timestamp': timestamp,
      'type': type.value,
    };
  }
}

enum TarotNightMessageType {
  normal('normal'),
  system('system'),
  testResult('test_result');

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

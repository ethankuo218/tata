import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';

class TarotNightMessage extends Message {
  final TarotNightMessageType type;

  TarotNightMessage({
    required super.senderId,
    required super.message,
    required super.timestamp,
    this.type = TarotNightMessageType.normal,
  });

  factory TarotNightMessage.fromJson(Map<String, dynamic> json) {
    return TarotNightMessage(
      senderId: json['sender_id'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as Timestamp,
      type: TarotNightMessageType.toEnum(json['type']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
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

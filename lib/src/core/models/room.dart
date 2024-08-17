import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';

class Room {
  final String id;
  final String title;
  final String description;
  final String hostId;
  late Message? latestMessage;
  late int memberCount;
  late Timestamp createTime;

  Room(
      {required this.id,
      required this.title,
      required this.description,
      this.latestMessage,
      required this.hostId,
      required this.memberCount,
      required this.createTime});

  factory Room.fromJson(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromJson(map['latest_message']),
      hostId: map['host_id'],
      memberCount: map['member_count'],
      createTime: map['create_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latest_message': latestMessage?.toJson(),
      'host_id': hostId,
      'member_count': memberCount,
      'create_time': createTime
    };
  }
}

import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/room.dart';

class RealtimeChatRoom extends Room {
  final String? joinerId;

  RealtimeChatRoom({
    required super.id,
    required super.title,
    required super.description,
    required super.latestMessage,
    required super.memberCount,
    required super.createTime,
    required super.hostId,
    this.joinerId,
  });

  factory RealtimeChatRoom.fromMap(Map<String, dynamic> map) {
    return RealtimeChatRoom(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromMap(map['latest_message']),
      memberCount: map['member_count'],
      createTime: map['create_time'],
      hostId: map['host_id'],
      joinerId: map['joiner_id'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latest_message': latestMessage?.toMap(),
      'member_count': memberCount,
      'create_time': createTime,
      'host_id': hostId,
      'joiner_id': joinerId,
    };
  }
}

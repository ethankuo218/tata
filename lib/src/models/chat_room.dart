import 'package:eq_chat/src/models/message.dart';

class ChatRoom {
  final String id;
  final ChatRoomType type;
  final String title;
  final String description;
  final int limit;
  final String? hostId;
  late List<Message>? messages = [];
  late Message? latestMessage;
  late List<String> members = [];

  ChatRoom({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.limit,
    this.messages,
    this.latestMessage,
    this.hostId,
    required this.members,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      type: ChatRoomType.toEnum(map['type']),
      title: map['title'],
      description: map['description'],
      limit: map['limit'],
      messages:
          List<Message>.from(map['messages'].map((e) => Message.fromMap(e))),
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromMap(map['latest_message']),
      hostId: map['host_id'],
      members: List<String>.from(map['members']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.enumValue,
      'title': title,
      'description': description,
      'limit': limit,
      'messages':
          messages == null ? [] : messages?.map((e) => e.toMap()).toList(),
      'latest_message': latestMessage?.toMap(),
      'host_id': hostId,
      'members': members,
    };
  }
}

enum ChatRoomType {
  normal(1),
  realtime(2);

  const ChatRoomType(this.enumValue);

  /// Convert value to enum type
  ///
  /// When value not found, and [defaultValue] is null will Return first enum value.
  factory ChatRoomType.toEnum(int x, {dynamic defaultValue}) {
    var filter = values.where((element) => element.enumValue == x);
    return filter.isNotEmpty ? filter.first : defaultValue ?? values.first;
  }

  static String toText(int x) {
    switch (x) {
      case 1:
        return 'Normal';
      case 2:
        return 'Realtime';
      default:
        return 'Normal';
    }
  }

  final int enumValue;
}

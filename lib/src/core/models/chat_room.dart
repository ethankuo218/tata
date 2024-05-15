import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/room.dart';
import 'package:tata/src/ui/tarot.dart';

class ChatRoom extends Room {
  final ChatRoomType type;
  final int limit;
  final String category;
  final TarotCardKey? backgroundImage;
  late List<Message>? messages = [];

  ChatRoom(
      {required super.id,
      required this.type,
      required super.title,
      required super.description,
      required this.limit,
      required this.category,
      this.backgroundImage,
      this.messages,
      super.latestMessage,
      required super.hostId,
      required super.createTime,
      required super.memberCount});

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      type: ChatRoomType.toEnum(map['type']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      limit: map['limit'],
      category: map['category'] ?? '',
      backgroundImage: map['background_image'] != null
          ? TarotCardKey.toEnum(map['background_image'])
          : null,
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromJson(map['latest_message']),
      hostId: map['host_id'],
      createTime: map['create_time'],
      memberCount: map['member_count'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'title': title,
      'description': description,
      'limit': limit,
      'category': category,
      'background_image': backgroundImage == null
          ? null
          : TarotCardKey.toValue(backgroundImage!),
      'latest_message': latestMessage?.toJson(),
      'host_id': hostId,
      'member_count': memberCount,
      'create_time': createTime
    };
  }
}

enum ChatRoomType {
  normal(1),
  realtime(2);

  const ChatRoomType(this.value);

  /// Convert value to enum type
  ///
  /// When value not found, and [defaultValue] is null will Return first enum value.
  factory ChatRoomType.toEnum(int x, {dynamic defaultValue}) {
    var filter = values.where((element) => element.value == x);

    if (filter.isEmpty) {
      throw Exception('Invalid input value');
    }

    return filter.first;
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

  final int value;
}

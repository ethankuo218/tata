import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/room.dart';
import 'package:tata/src/utils/tarot.dart';

class ChatRoom extends Room {
  final ChatRoomType type;
  final int limit;
  final ChatRoomCategory category;
  final TarotCardKey? backgroundImage;
  late List<Message>? messages = [];
  final bool isClosed;

  ChatRoom(
      {required super.id,
      required this.type,
      required super.title,
      required super.description,
      required this.limit,
      required this.category,
      this.backgroundImage,
      this.messages,
      required this.isClosed,
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
      category: ChatRoomCategory.toEnum(map['category']),
      backgroundImage: map['background_image'] != null
          ? TarotCardKey.toEnum(map['background_image'])
          : null,
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromJson(map['latest_message']),
      isClosed: map['is_closed'] ?? false,
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
      'category': category.value,
      'background_image': backgroundImage == null
          ? null
          : TarotCardKey.toValue(backgroundImage!),
      'latest_message': latestMessage?.toJson(),
      'is_closed': isClosed,
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

enum ChatRoomCategory {
  all('all'),
  romance('romance'),
  work('work'),
  interest('interest'),
  sport('sport'),
  family('family'),
  friend('friend'),
  chitchat('chitchat'),
  school('school');

  /// Convert value to enum type
  ///
  /// When value not found, and [defaultValue] is null will Return first enum value.
  factory ChatRoomCategory.toEnum(String x, {dynamic defaultValue}) {
    var filter = values.where((element) => element.value == x);

    if (filter.isEmpty) {
      throw Exception('Invalid input value');
    }

    return filter.first;
  }

  static String toText(ChatRoomCategory x) {
    switch (x) {
      case ChatRoomCategory.all:
        return '全部';
      case ChatRoomCategory.romance:
        return '感情';
      case ChatRoomCategory.work:
        return '工作';
      case ChatRoomCategory.interest:
        return '興趣';
      case ChatRoomCategory.sport:
        return '運動';
      case ChatRoomCategory.family:
        return '家庭';
      case ChatRoomCategory.friend:
        return '友情';
      case ChatRoomCategory.chitchat:
        return '閒聊';
      case ChatRoomCategory.school:
        return '學校';
      default:
        return '全部';
    }
  }

  const ChatRoomCategory(this.value);

  final String value;
}

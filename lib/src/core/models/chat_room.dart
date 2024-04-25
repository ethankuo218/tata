import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/ui/tarot.dart';

class ChatRoom {
  final String id;
  final ChatRoomType type;
  final String title;
  final String description;
  final int limit;
  final String category;
  final TarotCard? backgroundImage;
  final String? hostId;
  late List<Message>? messages = [];
  late Message? latestMessage;
  late List<String> members = [];
  late Timestamp createTime;

  ChatRoom(
      {required this.id,
      required this.type,
      required this.title,
      required this.description,
      required this.limit,
      required this.category,
      this.backgroundImage,
      this.messages,
      this.latestMessage,
      this.hostId,
      required this.members,
      required this.createTime});

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      type: ChatRoomType.toEnum(map['type']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      limit: map['limit'],
      category: map['category'] ?? '',
      backgroundImage: map['background_image'] != null
          ? TarotCard.toEnum(map['background_image'])
          : null,
      messages:
          List<Message>.from(map['messages'].map((e) => Message.fromMap(e))),
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromMap(map['latest_message']),
      hostId: map['host_id'],
      members: List<String>.from(map['members']),
      createTime: map['create_time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.value,
      'title': title,
      'description': description,
      'limit': limit,
      'category': category,
      'background_image':
          backgroundImage == null ? null : TarotCard.toValue(backgroundImage!),
      'messages':
          messages == null ? [] : messages?.map((e) => e.toMap()).toList(),
      'latest_message': latestMessage?.toMap(),
      'host_id': hostId,
      'members': members,
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

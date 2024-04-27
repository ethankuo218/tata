import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';

class TarotNightRoom {
  final String id;
  final TarotNightRoomTheme theme;
  final String title;
  final String description;
  final String? hostId;
  late List<Message>? messages = [];
  late Message? latestMessage;
  late List<String> members = [];
  late Timestamp createTime;

  TarotNightRoom(
      {required this.id,
      required this.theme,
      required this.title,
      required this.description,
      this.messages,
      this.latestMessage,
      this.hostId,
      required this.members,
      required this.createTime});

  factory TarotNightRoom.fromMap(Map<String, dynamic> map) {
    return TarotNightRoom(
      id: map['id'],
      theme: TarotNightRoomTheme.toEnum(map['theme']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
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
      'type': theme.value,
      'title': title,
      'description': description,
      'messages':
          messages == null ? [] : messages?.map((e) => e.toMap()).toList(),
      'latest_message': latestMessage?.toMap(),
      'host_id': hostId,
      'members': members,
      'create_time': createTime
    };
  }
}

enum TarotNightRoomTheme {
  work(1),
  relation(2),
  family(3),
  friend(4);

  const TarotNightRoomTheme(this.value);

  /// Convert value to enum type
  ///
  /// When value not found, and [defaultValue] is null will Return first enum value.
  factory TarotNightRoomTheme.toEnum(int x, {dynamic defaultValue}) {
    var filter = values.where((element) => element.value == x);

    if (filter.isEmpty) {
      throw Exception('Invalid input value');
    }

    return filter.first;
  }

  static String toText(int x) {
    switch (x) {
      case 1:
        return 'Work';
      case 2:
        return 'Relation';
      case 3:
        return 'Family';
      case 4:
        return 'Friend';
      default:
        return 'NULL';
    }
  }

  final int value;
}

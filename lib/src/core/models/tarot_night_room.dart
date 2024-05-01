import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/tarot_night_result.dart';

class TarotNightRoom {
  final String id;
  final TarotNightRoomTheme theme;
  final String title;
  final String description;
  final String? hostId;
  late Message? latestMessage;
  late int memberCount;
  late Timestamp createTime;
  late TarotNightResult? result;

  TarotNightRoom(
      {required this.id,
      required this.theme,
      required this.title,
      required this.description,
      this.latestMessage,
      this.hostId,
      required this.memberCount,
      required this.createTime,
      this.result});

  factory TarotNightRoom.fromMap(Map<String, dynamic> map) {
    return TarotNightRoom(
      id: map['id'],
      theme: TarotNightRoomTheme.toEnum(map['theme']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromMap(map['latest_message']),
      hostId: map['host_id'],
      memberCount: map['member_count'],
      createTime: map['create_time'],
      result: map['result'] == null
          ? null
          : TarotNightResult.fromMap(map['result']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theme': theme.value,
      'title': title,
      'description': description,
      'latest_message': latestMessage?.toMap(),
      'host_id': hostId,
      'member_count': memberCount,
      'create_time': createTime,
      'result': result?.toMap(),
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

  static String toText(TarotNightRoomTheme x) {
    switch (x) {
      case TarotNightRoomTheme.work:
        return 'Work';
      case TarotNightRoomTheme.relation:
        return 'Relation';
      case TarotNightRoomTheme.family:
        return 'Family';
      case TarotNightRoomTheme.friend:
        return 'Friend';
      default:
        return 'NULL';
    }
  }

  final int value;
}

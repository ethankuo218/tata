import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/room.dart';
import 'package:tata/src/core/models/tarot_night_result.dart';

class TarotNightRoom extends Room {
  final TarotNightRoomTheme theme;
  late TarotNightResult? result;

  TarotNightRoom({
    required this.theme,
    this.result,
    required super.id,
    required super.title,
    required super.description,
    required super.memberCount,
    required super.createTime,
    required super.hostId,
    super.latestMessage,
  });

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

  @override
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
  myRoom(0),
  all(1),
  work(2),
  relation(3),
  family(4),
  friend(5);

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
      case TarotNightRoomTheme.myRoom:
        return 'My Room';
      case TarotNightRoomTheme.all:
        return 'All';
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

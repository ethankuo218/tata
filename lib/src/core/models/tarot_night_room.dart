import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/room.dart';

class TarotNightRoom extends Room {
  final TarotNightRoomTheme theme;
  late String? card;
  late String? question;
  late List<TarotNightAnswer>? answers;

  TarotNightRoom({
    required super.id,
    required this.theme,
    this.card,
    this.question,
    this.answers,
    required super.title,
    required super.description,
    required super.memberCount,
    required super.createTime,
    required super.hostId,
    super.latestMessage,
  });

  factory TarotNightRoom.fromJson(Map<String, dynamic> map) {
    return TarotNightRoom(
      id: map['id'],
      theme: TarotNightRoomTheme.toEnum(map['theme']),
      card: map['card'],
      question: map['question'],
      answers: map['answers'] == null
          ? null
          : List<TarotNightAnswer>.from(
              map['answers'].map((x) => TarotNightAnswer.fromJson(x))),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      memberCount: map['member_count'],
      createTime: map['create_time'],
      hostId: map['host_id'],
      latestMessage: map['latest_message'] == null
          ? null
          : Message.fromJson(map['latest_message']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'theme': theme.value,
      'card': card,
      'question': question,
      'answers': answers?.map((x) => x.toJson()).toList(),
      'title': title,
      'description': description,
      'member_count': memberCount,
      'create_time': createTime,
      'host_id': hostId,
      'latest_message': latestMessage?.toJson(),
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

class TarotNightAnswer {
  final String uid;
  final String answer;

  TarotNightAnswer({required this.uid, required this.answer});

  factory TarotNightAnswer.fromJson(Map<String, dynamic> map) {
    return TarotNightAnswer(
      uid: map['uid'],
      answer: map['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'answer': answer,
    };
  }
}

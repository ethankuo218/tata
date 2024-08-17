import 'package:flutter/material.dart';
import 'package:tata/src/core/models/room.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarotNightRoom extends Room {
  final TarotNightRoomTheme theme;
  late String? card;
  late String? question;
  late List<TarotNightAnswer>? answers;
  late String? role;
  late bool isMember = false;

  TarotNightRoom({
    required super.id,
    required this.theme,
    this.card,
    this.question,
    this.answers,
    this.role = '',
    this.isMember = false,
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
          : TarotNightMessage.fromJson(map['latest_message']),
      isMember: map['is_member'] ?? false,
      role: map['role'],
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
  all(0),
  work(1),
  relation(2),
  family(3),
  friend(4),
  myRoom(5);

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

  static String toText(BuildContext context, TarotNightRoomTheme x) {
    switch (x) {
      case TarotNightRoomTheme.myRoom:
        return 'My Room';
      case TarotNightRoomTheme.all:
        return '全部';
      case TarotNightRoomTheme.work:
        return AppLocalizations.of(context)!.category_work;
      case TarotNightRoomTheme.relation:
        return AppLocalizations.of(context)!.category_romance;
      case TarotNightRoomTheme.family:
        return AppLocalizations.of(context)!.category_family;
      case TarotNightRoomTheme.friend:
        return AppLocalizations.of(context)!.category_friendship;
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

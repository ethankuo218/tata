import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/utils/avatar.dart';

class MemberInfo extends AppUserInfo {
  final String role;
  final String quest;
  final String answer;

  MemberInfo({
    required super.uid,
    required super.name,
    required super.avatar,
    required super.birthday,
    required super.fcmToken,
    required this.role,
    this.quest = '',
    this.answer = '',
  });

  factory MemberInfo.fromJson(Map<String, dynamic> map) {
    return MemberInfo(
      uid: map['uid'],
      name: map['name'],
      avatar: AvatarKey.toEnum(map['avatar']),
      birthday: map['birthday'],
      fcmToken: map['fcmToken'] ?? '',
      role: map['role'],
      quest: map['quest'] ?? '',
      answer: map['answer'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'birthday': birthday,
      'role': role,
      'quest': quest,
      'answer': answer,
    };
  }
}

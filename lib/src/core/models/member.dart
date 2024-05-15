import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/ui/avatar.dart';

class Member extends AppUserInfo {
  final String role;
  final String quest;

  Member({
    required super.uid,
    required super.name,
    required super.avatar,
    required this.role,
    this.quest = '',
  });

  factory Member.fromJson(Map<String, dynamic> map) {
    return Member(
      uid: map['uid'],
      name: map['name'],
      avatar: AvatarKey.toEnum(map['avatar']),
      role: map['role'],
      quest: map['quest'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'role': role,
      'quest': quest,
    };
  }
}

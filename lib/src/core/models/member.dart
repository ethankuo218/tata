import 'package:tata/src/core/models/app_user_info.dart';

class Member extends AppUserInfo {
  final String role;

  Member({
    required super.uid,
    required super.name,
    required super.avatar,
    required this.role,
  });

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      uid: map['uid'],
      name: map['name'],
      avatar: map['avatar'],
      role: map['role'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'role': role,
    };
  }
}

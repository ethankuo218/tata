import 'package:tata/src/utils/avatar.dart';

class AppUserInfo {
  final String name;
  final String uid;
  final AvatarKey avatar;

  AppUserInfo({
    required this.name,
    required this.uid,
    required this.avatar,
  });

  factory AppUserInfo.fromJson(Map<String, dynamic> map) {
    return AppUserInfo(
      name: map['name'] ?? 'Unknown',
      uid: map['uid'],
      avatar: AvatarKey.toEnum(map['avatar']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'avatar': avatar,
    };
  }
}

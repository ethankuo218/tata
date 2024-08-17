import 'package:tata/src/utils/avatar.dart';

class AppUserInfo {
  final String name;
  final String uid;
  final AvatarKey avatar;
  final String fcmToken;
  final String birthday;

  AppUserInfo({
    required this.name,
    required this.uid,
    required this.avatar,
    required this.birthday,
    this.fcmToken = '',
  });

  factory AppUserInfo.fromJson(Map<String, dynamic> map) {
    return AppUserInfo(
      name: map['name'],
      uid: map['uid'],
      avatar: AvatarKey.toEnum(map['avatar']),
      birthday: map['birthday'],
      fcmToken: map['fcmToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'avatar': avatar,
      'birthday': birthday,
      'fcmToken': fcmToken,
    };
  }
}

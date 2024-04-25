class AppUserInfo {
  final String name;
  final String uid;
  final String avatar;

  AppUserInfo({
    required this.name,
    required this.uid,
    required this.avatar,
  });

  factory AppUserInfo.fromMap(Map<String, dynamic> map) {
    return AppUserInfo(
      name: map['name'] ?? 'Unknown',
      uid: map['uid'],
      avatar: map['avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'avatar': avatar,
    };
  }
}

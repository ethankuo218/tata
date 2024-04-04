class AppUserInfo {
  final String name;
  final String uid;

  AppUserInfo({
    required this.name,
    required this.uid,
  });

  factory AppUserInfo.fromMap(Map<String, dynamic> map) {
    return AppUserInfo(
      name: map['name'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
    };
  }
}

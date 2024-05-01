class TarotNightMember {
  final String uid;
  final String name;
  final String role;

  TarotNightMember({
    required this.uid,
    required this.name,
    required this.role,
  });

  factory TarotNightMember.fromMap(Map<String, dynamic> map) {
    return TarotNightMember(
      uid: map['uid'],
      name: map['name'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'role': role,
    };
  }
}

class Role {
  final String id;
  final String name;
  final List<String> tags;
  final String description;
  final String image;

  Role(
      {required this.id,
      required this.name,
      required this.tags,
      required this.description,
      required this.image});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      tags: json['tags'],
      description: json['description'],
      image: json['image'],
    );
  }
}

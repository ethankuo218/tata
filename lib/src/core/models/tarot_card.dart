class TarotCard {
  final String id;
  final String name;
  final String image;
  final String description;
  final String workDescription;
  final String relationDescription;
  final String friendDescription;
  final String familyDescription;

  TarotCard({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.workDescription,
    required this.relationDescription,
    required this.friendDescription,
    required this.familyDescription,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      workDescription: json['work_description'],
      relationDescription: json['relation_description'],
      friendDescription: json['friend_description'],
      familyDescription: json['family_description'],
    );
  }
}

class TarotCard {
  final String name;
  final String image;
  final String description;
  final String workDescription;
  final String relationDescription;
  final String friendDescription;
  final String familyDescription;

  TarotCard({
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
      name: json['name'],
      image: json['image'],
      description: json['description'],
      workDescription: json['workDescription'],
      relationDescription: json['relationDescription'],
      friendDescription: json['friendDescription'],
      familyDescription: json['familyDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'workDescription': workDescription,
      'relationDescription': relationDescription,
      'friendDescription': friendDescription,
      'familyDescription': familyDescription,
    };
  }
}

class TarotCard {
  final String id;
  final String title;
  final String image;
  final String descriptionTitle;
  final String description;
  final String work;
  final String romance;
  final String friend;
  final String family;

  TarotCard({
    required this.id,
    required this.title,
    required this.image,
    required this.descriptionTitle,
    required this.description,
    required this.work,
    required this.romance,
    required this.friend,
    required this.family,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      descriptionTitle: json['description_title'],
      description: json['description'],
      work: json['work'],
      romance: json['romance'],
      friend: json['friend'],
      family: json['family'],
    );
  }
}

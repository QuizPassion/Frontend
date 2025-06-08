class Quiz {
  final int id;
  final String title;
  final String description;
  final String theme;
  final int creatorId;
  final QuizImage? image;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.theme,
    required this.creatorId,
    this.image,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['ID'],
      title: json['Title'],
      description: json['Description'],
      theme: json['Theme'],
      creatorId: json['CreatorID'],
      image: json['Image'] != null && json['Image']['url'] != null
          ? QuizImage.fromJson(json['Image'])
          : null,
    );
  }
}

class QuizImage {
  final int id;
  final String title;
  final String url;

  QuizImage({
    required this.id,
    required this.title,
    required this.url,
  });

  factory QuizImage.fromJson(Map<String, dynamic> json) {
    return QuizImage(
      id: json['ID'],
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

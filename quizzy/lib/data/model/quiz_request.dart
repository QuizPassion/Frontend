class Quiz {
  final int id;
  final String title;
  final String description;
  final String theme;
  final QuizImage? image;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.theme,
    this.image,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['ID'],
      title: json['Title'],
      description: json['Description'],
      theme: json['Theme'],
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

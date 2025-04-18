class Quiz {
  final int id;
  final String title;
  final String description;
  final String theme;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.theme,
  });

  // Factory constructor pour convertir le JSON en un objet Quiz
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['ID'], 
      title: json['Title'], 
      description: json['Description'], 
      theme: json['Theme'],
    );
  }
}

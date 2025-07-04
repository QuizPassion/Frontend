class Answer {
  final int id;
  final String text;

  Answer({required this.id, required this.text});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      text: json['text'],
    );
  }
}
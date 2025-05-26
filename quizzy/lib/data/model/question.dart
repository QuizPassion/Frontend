import 'package:quizzy/data/model/answer.dart';

class Question {
  final int id;
  final String text;
  final List<Answer> choices;

  Question({required this.id, required this.text, required this.choices});

  factory Question.fromJson(Map<String, dynamic> json) {
    var choicesJson = json['choices'] as List;
    List<Answer> parsedChoices = choicesJson.map((c) => Answer.fromJson(c)).toList();

    return Question(
      id: json['id'],
      text: json['text'],
      choices: parsedChoices,
    );
  }
}

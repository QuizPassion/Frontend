import 'package:flutter/material.dart';
import 'package:quizzy/data/model/quiz_request.dart';

class QuizProvider extends ChangeNotifier {
  Quiz? _quiz;

  String? _quizTitle;

  Quiz? get quiz => _quiz;

  void setQuiz(Quiz quiz) {
    _quiz = quiz;
    _quizTitle = quiz.title;
    notifyListeners();
  }
  
  void clearQuiz() {
    _quiz = null;
    _quizTitle = null;
    notifyListeners();
  }

  void updateQuiz(Quiz newQuiz) {
    if (_quiz != null) {
      _quiz = newQuiz;
      _quizTitle = newQuiz.title;
      notifyListeners();
    }
  }
}

class allQuizProvider with ChangeNotifier {
  List<Quiz> _allQuizzes = [];
  List<Quiz> _filteredQuizzes = [];

  List<Quiz> get quizzes => _filteredQuizzes;

  void setAllQuizzes(List<Quiz> quizzes) {
    _allQuizzes = quizzes;
    _filteredQuizzes = quizzes;
    notifyListeners();
  }

  void filterQuizzes(String query) {
    if (query.isEmpty) {
      _filteredQuizzes = _allQuizzes;
    } else {
      _filteredQuizzes = _allQuizzes
          .where((quiz) => quiz.title.toLowerCase().contains(query))
          .toList();
    }
    notifyListeners();
  }

  void resetFilter() {
    _filteredQuizzes = _allQuizzes;
    notifyListeners();
  }

}

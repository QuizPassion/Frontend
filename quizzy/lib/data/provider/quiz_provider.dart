import 'package:flutter/material.dart';
import 'package:quizzy/data/network/api_service.dart';
import 'dart:io';

class QuizProvider extends ChangeNotifier {
  final TextEditingController _quizNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedTheme;
  File? _imageFile;
  bool _isLoading = false;

  // Getters
  bool get isLoading => _isLoading;
  TextEditingController get quizNameController => _quizNameController;
  TextEditingController get descriptionController => _descriptionController;
  String? get selectedTheme => _selectedTheme;
  File? get imageFile => _imageFile;

  // Setters
  void setTheme(String? theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  void setImage(File? image) {
    _imageFile = image;
    notifyListeners();
  }

  Future<void> submitQuiz(BuildContext context) async {
    final name = _quizNameController.text.trim();
    final desc = _descriptionController.text.trim();
    final theme = _selectedTheme;

    print('Name: $name, Description: $desc, Theme: $theme');

    if (name.isEmpty || desc.isEmpty || theme == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().createQuiz(
        name: name,
        description: desc,
        theme: theme,
        avatarFile: _imageFile,
      );

      print('Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final quizIdString = response.data['quiz_id'];
        final quizId = int.tryParse(quizIdString.toString());

        print('Quiz ID: $quizId');

        if (quizId != null) {
          Navigator.pushNamed(
            context,
            '/createQuizQuestions',
            arguments: quizId,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid quiz ID format')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create quiz: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while creating the quiz')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _quizNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

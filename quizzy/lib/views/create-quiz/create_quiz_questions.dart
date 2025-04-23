// ignore_for_file: implementation_imports

import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/data/network/api_service.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/save_button.dart';
import 'widgets/create_question_card.dart';

class CreateQuizQuestionsPage extends StatefulWidget {
  const CreateQuizQuestionsPage({super.key, required this.quizId});
  final int quizId;

  @override
  State<CreateQuizQuestionsPage> createState() => _CreateQuizQuestionsPageState();
}

class _CreateQuizQuestionsPageState extends State<CreateQuizQuestionsPage> {
  final List<QuestionData> _questions = [
    QuestionData(titleController: TextEditingController(), options: [])
  ];

  void _addQuestion({QuestionData? copyFrom}) {
    setState(() {
      if (copyFrom != null) {
        _questions.add(QuestionData.clone(copyFrom));
      } else {
        _questions.add(QuestionData(titleController: TextEditingController(), options: []));
      }
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  // Fonction pour envoyer les questions à l'API
  Future<void> submitQuiz() async {
    final int quizId = widget.quizId;  // Récupère l'ID du quiz à partir de widget.quizId

    for (var question in _questions) {
      List<Map<String, dynamic>> options = [];
      for (var i = 0; i < question.options.length; i++) {
        options.add({
          'text': question.options[i].textController.text.trim(),
          'isCorrect': question.options[i].isCorrect,
        });
      }

      // Envoi de la question et des options à l'API
      try {
        final response = await ApiService().createQuestion(
          quizId: quizId.toString(),  // Envoie quizId comme string si l'API l'attend sous forme de chaîne
          question: question.titleController.text.trim(),
          options: options,
        );

        // Log le statusCode et body pour avoir plus de détails
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Question ajoutée');
        } else {
          debugPrint('❌ Erreur lors de l\'ajout de la question. Response: ${response.body}');
        }
      } catch (e) {
        debugPrint('❌ Erreur lors de l\'ajout de la question : $e');
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Add questions',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ..._questions.asMap().entries.map((entry) {
                final index = entry.key;
                final data = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CreateQuestionCard(
                    data: data,
                    onCopy: () => _addQuestion(copyFrom: data),
                    onDelete: () => _removeQuestion(index),
                  ),
                );
              }).toList(),
              const SizedBox(height: 24),
              SizedBox(
                width: 350,
                height: 42,
                child: ElevatedButton.icon(
                  onPressed: _addQuestion,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.lightGrey,
                    size: 26,
                  ),
                  label: const Text(
                    'Add a question',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.lato,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.royalPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 0,
                    minimumSize: const Size(350, 42),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SaveButton(
                  onPressed: () async {
                    await submitQuiz();
                    Navigator.pushNamed(context, '/allQuiz');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}

extension on Response {
  get body => null;
}

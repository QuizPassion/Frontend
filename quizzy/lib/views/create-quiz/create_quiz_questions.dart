import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/save_button.dart';
import 'widgets/create_question_card.dart';

class CreateQuizQuestionsPage extends StatefulWidget {
  const CreateQuizQuestionsPage({super.key});

  @override
  State<CreateQuizQuestionsPage> createState() =>
      _CreateQuizQuestionsPageState();
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
        _questions.add(QuestionData(
            titleController: TextEditingController(), options: []));
      }
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
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
                  onPressed: () {
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

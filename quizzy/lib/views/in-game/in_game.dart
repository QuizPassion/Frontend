import 'package:flutter/material.dart';
import 'package:quizzy/data/model/question.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/confirm_exit.dart';
import '../../core/widgets/quizzy_scaffold.dart';
import 'widgets/answer_question_card.dart';
import 'widgets/answered_question_card.dart';

class InGame extends StatefulWidget {
  const InGame({super.key});

  @override
  State<InGame> createState() => _InGameState();
}

class _InGameState extends State<InGame> {
  bool _hasAnswered = false;
  bool _loaded = false;

  void _onConfirmAnswer() {
    setState(() {
      _hasAnswered = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        final question = Question.fromJson(args);
        print('Question : ${question.text}');
      }

      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (_) {
      },
      disabled: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quiz sur les jedi dans Star Wars',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Question 1/15',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1/20 joueurs ont répondu',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 14,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 20),

                // Dynamic card
                _hasAnswered
                    ? const AnsweredQuestionCard()
                    : AnswerQuestionCard(onConfirm: _onConfirmAnswer),

                const Spacer(),

                ElevatedButton(
                  onPressed: () {
                      Navigator.pushNamed(context, '/endGame');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dynamicOrange,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'temporary',
                  ),
                ),
                // Quit Game Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showConfirmExitDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalPurple,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Quit Game',
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontFamily: AppFonts.lato,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

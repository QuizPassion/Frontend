import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import 'widgets/created_quizz_card.dart';

class AllQuizPage extends StatelessWidget {
  const AllQuizPage({super.key});

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
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'My quiz',
                      style: TextStyle(
                        fontFamily: AppFonts.montserrat,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: AppColors.lightGrey),
                    onPressed: () {
                      Navigator.pushNamed(context, '/createQuiz');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const CreatedQuizzCard(),
              const SizedBox(height: 16),
              const CreatedQuizzCard(),
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

import 'package:flutter/material.dart';
import 'package:quizzy/data/model/quiz_request.dart';
import 'package:quizzy/data/network/api_service.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_scaffold.dart';
import 'widgets/created_quizz_card.dart';

class AllQuizPage extends StatelessWidget {
  const AllQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 1,
      onTap: (index) {
      },
      disabled: false,
      body: SingleChildScrollView(
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
            FutureBuilder<List<Quiz>>(
              future: ApiService().fetchMyQuizzes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erreur : ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Aucun quiz trouvé.');
                }

                final quizzes = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = quizzes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CreatedQuizzCard(
                        quizName: quiz.title,
                        quizDescription: quiz.description,
                        quizImageUrl: quiz.image?.url,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

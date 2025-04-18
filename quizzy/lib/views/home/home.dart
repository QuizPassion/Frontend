import 'package:flutter/material.dart';
import 'package:quizzy/data/model/quiz_request.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import 'widgets/quiz_card.dart';
import 'widgets/quiz_card_group.dart';
import '../../data/network/api_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Multiplayer',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 8),

                // Join game search bar
                SearchWithQrRow(
                  hintText: 'Search and join a game',
                  onQrTap: () {
                    Navigator.pushNamed(context, '/joinedGameLobby');
                  },
                ),

                const SizedBox(height: 8),
                const Text(
                  'ou',
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 18,
                    fontFamily: AppFonts.lato,
                  ),
                ),
                const SizedBox(height: 8),

                // Create game button
                SizedBox(
                  width: 350,
                  height: 42,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createdGameLobby');
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.lightGrey,
                      size: 26,
                    ),
                    label: const Text(
                      'Create your own game',
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

                const SizedBox(height: 16),

                const Text(
                  'Solo',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 8),
                // Search quiz search bar
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  prefixIcon: Icons.search,
                  height: 42,
                ),

                const SizedBox(height: 24),
                FutureBuilder<List<Quiz>>(
                  future: ApiService().fetchCommunityQuizzes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur : ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Aucun quiz trouvé.');
                    }

                    final quizzes = snapshot.data!;

                    return QuizCardGroup(
                      title: 'Quiz from the community',
                      cards: quizzes
                          .map((quiz) => QuizCardSmall(label: quiz.title))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

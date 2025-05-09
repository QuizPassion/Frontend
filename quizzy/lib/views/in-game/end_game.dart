import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/app_images.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import 'widgets/player_in_game_card.dart';
import 'widgets/start_game_btn.dart';

class EndGame extends StatelessWidget {
  const EndGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Stack(
        children: [
          const BackgroundDecoration(child: SizedBox.shrink()),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Partie terminée',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Votre score',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontFamily: AppFonts.montserrat,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Score box
                  Container(
                  width: 350,
                  height: 105,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.deepLavender),
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.anthraciteBlack,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Quiz on the jedi in Star Wars',
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontFamily: AppFonts.lato,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.quizImage,
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '3925 pts',
                            style: TextStyle(
                              color: AppColors.lightGrey,
                              fontFamily: AppFonts.montserrat,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                  const SizedBox(height: 16),

                  const Text(
                    'The podium',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontFamily: AppFonts.montserrat,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Podium layout 
                  Column(
                    children: [
                      const PlayerInGameCard(playerName: 'Player 2'),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          PlayerInGameCard(playerName: 'Fan2StarWars'),
                          PlayerInGameCard(playerName: 'Player 3'),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  StartGameButton(
                    text: 'Go to home page',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }
}

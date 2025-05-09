import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_scaffold.dart';
import 'widgets/start_game_btn.dart';

class GameLoading extends StatelessWidget {
  const GameLoading({super.key});

  @override
  Widget build(BuildContext context) {

    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (index) {
      },
      disabled: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quiz on the jedi in star wars',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                Text(
                  'LOADING',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),

                StartGameButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/inGame');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

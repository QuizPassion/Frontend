import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import 'widgets/start_game_btn.dart';

class GameLoading extends StatelessWidget {
  const GameLoading({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Stack(
        children: [
          const BackgroundDecoration(child: SizedBox.shrink()),
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
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }
}

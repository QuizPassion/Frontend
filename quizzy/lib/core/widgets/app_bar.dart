import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_fonts.dart';
import '../app_images.dart';

class QuizzyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizzyAppBar({super.key});

  static const double appBarHeight = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        boxShadow: [
          AppColors.purpleBoxShadow,
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: appBarHeight,          
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 16,
                child: Image.asset(
                  AppImages.logoSimple,
                  height: 50,
                ),
              ),

              const Text(
                'Quizzy',
                style: TextStyle(
                  fontFamily: AppFonts.montserrat,
                  color: AppColors.lightGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

/*
  return Scaffold(
        appBar: const QuizzyAppBar(),
        body: BackgroundDecoration(
*/
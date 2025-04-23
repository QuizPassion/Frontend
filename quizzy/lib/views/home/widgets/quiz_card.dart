import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/core/app_images.dart';
import '/core/app_fonts.dart';

class QuizCardSmall extends StatelessWidget {
  final String label;

  const QuizCardSmall({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        gradient: AppColors.gradientTop2Btm,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.quizImage,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.lightGrey,
              fontFamily: AppFonts.lato,
            ),
          ),
        ],
      ),
    );
  }
}

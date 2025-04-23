import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/core/app_fonts.dart';
import 'quiz_card.dart';

class QuizCardGroup extends StatelessWidget {
  final String title;
  final List<QuizCardSmall> cards;

  const QuizCardGroup({
    super.key,
    required this.title,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: AppFonts.lato,
            fontSize: 18,
            color: AppColors.lightGrey,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 18,
          children: cards,
        ),
      ],
    );
  }
}

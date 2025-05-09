import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_fonts.dart';

class AnsweredQuestionCard extends StatelessWidget {
  const AnsweredQuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.deepLavender,
          width: 1,
        ),
      ),
      child: const Center(
        child: Text(
          'You have answered',
          style: TextStyle(
            color: AppColors.lightGrey,
            fontFamily: AppFonts.lato,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

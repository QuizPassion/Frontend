import 'package:flutter/material.dart';
import '/core/app_fonts.dart';
import '/core/app_colors.dart';
import '/core/app_images.dart';

class CreatedQuizzCard extends StatelessWidget {
  final String quizName;
  final String quizDescription;
  final String? quizImageUrl;

  const CreatedQuizzCard({
    super.key,
    required this.quizName,
    required this.quizDescription,
    this.quizImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        border: Border.all(
          color: AppColors.deepLavender,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: quizImageUrl != null && quizImageUrl!.isNotEmpty
                ? Image.network(
                    quizImageUrl!,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppImages.quizImage,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quizName,
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  quizDescription,
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 13,
                    color: AppColors.lightGrey.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

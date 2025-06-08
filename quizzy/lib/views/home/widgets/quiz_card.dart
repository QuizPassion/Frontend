import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/core/app_fonts.dart';

class QuizCardSmall extends StatelessWidget {
  final String label;
  final String? imageUrl;

  const QuizCardSmall({
    super.key,
    required this.label,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // check if imageUrl is null or empty, and use a default image if it is
    final imageToDisplay = imageUrl?.isNotEmpty == true
        ? imageUrl // if the imageUrl is valid, use it
        : 'https://res.cloudinary.com/dxk9t394b/image/upload/v1745005273/quiz_images/etienne/profil/1590dd94-83dc-43eb-b94a-f1be2eeea65b.png'; // Image par défaut

    return Container(
      width: 95,
      height: 95,
      decoration: BoxDecoration(
        gradient: AppColors.gradientTop2Btm,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageToDisplay!,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // if error occurs while loading the image, display a default image
              return Image.asset(
                'assets/images/default_image.png', // replace with your default image path
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              );
            },
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16, 
                color: AppColors.lightGrey,
                fontFamily: AppFonts.lato,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

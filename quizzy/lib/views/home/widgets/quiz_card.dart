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
    // Vérifie si l'URL de l'image est non vide et valide
    final imageToDisplay = imageUrl?.isNotEmpty == true
        ? imageUrl // Si l'URL n'est pas vide, utiliser l'URL donnée
        : 'https://res.cloudinary.com/dxk9t394b/image/upload/v1745005273/quiz_images/etienne/profil/1590dd94-83dc-43eb-b94a-f1be2eeea65b.png'; // Image par défaut

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
          Image.network(
            imageToDisplay!,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // En cas d'erreur, afficher une image par défaut
              return Image.asset(
                'assets/images/default_image.png', // Remplace par ton image par défaut
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              );
            },
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

import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_fonts.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/background_decoration.dart';
import '../core/widgets/nav_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // Si tu utilises des icônes SVG

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ==== MULTIJOUEUR ====
                const Text(
                  'Multijoueurs',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Barre recherche de partie avec QR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.deepLavender),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Rechercher une partie',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.lato,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.deepLavender),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.qr_code, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'ou',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.lato,
                  ),
                ),
                const SizedBox(height: 16),

                // Bouton créer une partie
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                    label: const Text(
                      'Crée ta propre partie',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.lato,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalPurple,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ==== SOLO ====
                const Text(
                  'Solo',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Barre recherche quiz
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.deepLavender),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Rechercher un quiz',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.lato,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle nav tap
        },
      ),
    );
  }
}

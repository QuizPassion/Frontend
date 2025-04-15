import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_fonts.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/background_decoration.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/quizzy_text_field.dart';

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
                const Text(
                  'Multiplayer',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 16),

                // join game search bar
                SizedBox(
                  width: 350,
                  child: Row(
                    children: [
                      Expanded(
                        child: QuizzyTextField(
                          hintText: 'Search and join a game',
                          height: 42,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.deepLavender),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.qr_code, color: AppColors.lightGrey),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 16),
                const Text(
                  'ou',
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 18,
                    fontFamily: AppFonts.lato,
                  ),
                ),
                const SizedBox(height: 16),

                // create game btn
                SizedBox(
                  width: 350,
                  height: 42,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.lightGrey,
                      size: 26, 
                    ),
                    label: const Text(
                      'Create your own game',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.lato,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 0,
                      minimumSize: const Size(350, 42),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  'Solo',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 16),

                // search quizz search bar
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  prefixIcon: Icons.search,
                  // width: 350,
                  height: 42,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 0,
        onTap: (index) {
        },
      ),
    );
  }
}

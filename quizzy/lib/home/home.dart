import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_images.dart';
import '../core/app_fonts.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/background_decoration.dart';
import '../core/widgets/nav_bar.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration (
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title Text
              Column(
                children: const [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.lightGrey,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Quizzy",
                    style: TextStyle(
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.lightGrey,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Logo
              Image.asset(
                AppImages.logoWhole,
                width: 200,
              ),

              const SizedBox(height: 40),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Container(
                      width: 270,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientLTR,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: 270,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientRTL,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

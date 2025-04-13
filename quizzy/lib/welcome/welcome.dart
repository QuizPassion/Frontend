import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_images.dart';
import '../core/app_fonts.dart';
import '../core/widgets/background_decoration.dart';
import '../core/widgets/login_signup_btn.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              LoginSignUpButtons(
                onSignUp: () {
                  Navigator.pushNamed(context, '/signup');
                },
                onLogin: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

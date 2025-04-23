import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/profile_icon.dart';
import 'widgets/parameter_card.dart';
import '../../core/app_images.dart';

class ParametersPage extends StatelessWidget {
  const ParametersPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // profile row
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: Row(
                      children: [
                        const ProfileIcon(),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Fan2StarWars',
                                style: TextStyle(
                                  fontFamily: AppFonts.montserrat,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'fan2SW@gmail.com',
                                style: TextStyle(
                                  fontFamily: AppFonts.montserrat,
                                  fontSize: 16,
                                  color: AppColors.lightGrey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Cards
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ParameterCard(
                        icon: Icons.person,
                        text: 'Profil',
                        onTap: () {},
                      ),
                      SizedBox(height: 28),
                      ParameterCard(
                        icon: Icons.sports_esports,
                        text: 'Dernières parties',
                        onTap: () {},
                      ),
                      SizedBox(height: 28),
                      ParameterCard(
                        icon: Icons.notifications,
                        text: 'Notifications',
                        onTap: () {},
                      ),
                      SizedBox(height: 28),
                      ParameterCard(
                        icon: Icons.privacy_tip,
                        text: 'Politique de confidentialité',
                        onTap: () {},
                      ),
                      SizedBox(height: 28),
                      ParameterCard(
                        icon: Icons.mail_outline,
                        text: 'Nous contacter',
                        onTap: () {},
                      ),
                      SizedBox(height: 28),
                      ParameterCard(
                        icon: Icons.logout,
                        text: 'Déconnexion',
                        onTap: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Center(
                  child: Image.asset(
                    AppImages.logoWhole,
                    width: 140,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }
}

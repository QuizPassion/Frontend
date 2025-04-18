import 'package:flutter/material.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/core/app_colors.dart';
import 'package:quizzy/core/app_fonts.dart';
import 'package:quizzy/core/widgets/app_bar.dart';
import 'package:quizzy/core/widgets/background_decoration.dart';
import 'package:quizzy/core/widgets/nav_bar.dart';
import 'package:quizzy/views/parameters/widgets/parameter_card.dart';
import 'package:quizzy/core/app_images.dart';
import 'package:provider/provider.dart';

class ParametersPage extends StatefulWidget {
  const ParametersPage({super.key});

  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  @override
  void initState() {
    super.initState();
    // Charger les données de l'utilisateur seulement si elles ne sont pas déjà chargées
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user == null) {
      userProvider.fetchUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                // Si les données sont toujours nulles, afficher un loader
                if (userProvider.user == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // profile row
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: Row(
                          children: [
                            // Image de profil
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.deepLavender,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: ClipOval(
                                  child: Image.network(
                                    userProvider.user!.image.url.isNotEmpty
                                        ? userProvider.user!.image.url
                                        : AppImages.profilePicture,
                                    width: 68,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Nom d'utilisateur
                                  Text(
                                    userProvider.user!.userPseudo,
                                    style: TextStyle(
                                      fontFamily: AppFonts.montserrat,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Email de l'utilisateur
                                  Text(
                                    userProvider.user!.email,
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

                    // Cards de paramètres
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ParameterCard(
                            icon: Icons.person,
                            text: 'Profil',
                            onTap: () {},
                          ),
                          const SizedBox(height: 28),
                          ParameterCard(
                            icon: Icons.sports_esports,
                            text: 'Dernières parties',
                            onTap: () {},
                          ),
                          const SizedBox(height: 28),
                          ParameterCard(
                            icon: Icons.notifications,
                            text: 'Notifications',
                            onTap: () {},
                          ),
                          const SizedBox(height: 28),
                          ParameterCard(
                            icon: Icons.privacy_tip,
                            text: 'Politique de confidentialité',
                            onTap: () {},
                          ),
                          const SizedBox(height: 28),
                          ParameterCard(
                            icon: Icons.mail_outline,
                            text: 'Nous contacter',
                            onTap: () {},
                          ),
                          const SizedBox(height: 28),
                          ParameterCard(
                            icon: Icons.logout,
                            text: 'Déconnexion',
                            onTap: () {
                              // Déconnexion et redirection vers la page de bienvenue
                              Navigator.pushNamed(context, '/welcome');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Logo en bas
                    Center(
                      child: Image.asset(
                        AppImages.logoWhole,
                        width: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                );
              },
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

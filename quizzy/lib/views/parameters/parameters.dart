import 'package:flutter/material.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/core/app_colors.dart';
import 'package:quizzy/core/app_fonts.dart';
import 'package:quizzy/views/parameters/widgets/parameter_card.dart';
import 'package:quizzy/core/app_images.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/quizzy_scaffold.dart';

class ParametersPage extends StatefulWidget {
  const ParametersPage({super.key});

  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // Charger le profil de l'utilisateur uniquement s'il n'est pas déjà chargé
    if (userProvider.user == null) {
      userProvider.fetchUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 3,
      onTap: (index) {
      },
      disabled: false,
      body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                // Si les données de l'utilisateur sont en cours de chargement, afficher un loader
                if (userProvider.user == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Si les données sont chargées, afficher les informations de l'utilisateur
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Affichage du profil de l'utilisateur
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

                    // Liste des cartes de paramètres
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import 'widgets/quiz_card_group.dart';
import 'widgets/quiz_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Récupération des quizzes dès le chargement de la page
    Future.microtask(() {
      Provider.of<QuizProvider>(context, listen: false).fetchCommunityQuizzes(context);
    });

    // Écoute les changements de texte pour faire le filtrage en temps réel
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    print('Quizzes: ${quizProvider.quizzes}');

    // Filtrage des quizzes en fonction du texte tapé
    final filteredQuizzes = quizProvider.quizzes.where((quiz) {
      final query = _searchController.text.toLowerCase();
      return quiz.title.toLowerCase().contains(query);
    }).toList();

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
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 8),

                // Composant pour scanner un QR ou rechercher un jeu
                SearchWithQrRow(
                  hintText: 'Search and join a game',
                  onQrTap: () {
                    Navigator.pushNamed(context, '/joinedGameLobby');
                  },
                ),

                const SizedBox(height: 8),
                const Text(
                  'ou',
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 18,
                    fontFamily: AppFonts.lato,
                  ),
                ),
                const SizedBox(height: 8),

                // Bouton pour créer un jeu
                SizedBox(
                  width: 350,
                  height: 42,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createdGameLobby');
                    },
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

                const SizedBox(height: 16),

                const Text(
                  'Solo',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 8),

                // Champ de recherche pour rechercher un quiz
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  prefixIcon: Icons.search,
                  height: 42,
                  controller: _searchController,
                ),

                const SizedBox(height: 24),

                // Affichage de l'indicateur de chargement ou des quizzes filtrés
                quizProvider.isLoading
                    ? const CircularProgressIndicator()
                    : filteredQuizzes.isEmpty
                        ? const Text(
                            'Aucun quiz trouvé.',
                            style: TextStyle(color: AppColors.lightGrey),
                          )
                        : QuizCardGroup(
                            title: 'Quiz from the community',
                            cards: filteredQuizzes
                                .map((quiz) => QuizCardSmall(
                                      label: quiz.title,
                                      imageUrl: quiz.image?.url,
                                    ))
                                .toList(),
                          ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

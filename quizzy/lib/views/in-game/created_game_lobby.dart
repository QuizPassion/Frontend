import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/views/in-game/widgets/start_game_btn.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import '../../data/provider/quiz_provider.dart';
import 'widgets/player_in_game_card.dart';

class CreatedGameLobbyPage extends StatelessWidget {
  const CreatedGameLobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Stack(
        children: [
          const BackgroundDecoration(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Quiz on the jedi in star wars',
                        style: TextStyle(
                          fontFamily: AppFonts.montserrat,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppColors.lightGrey, size: 32),
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Search
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  controller: quizProvider.quizNameController,
                  prefixIcon: Icons.search,
                  height: 42,
                ),

                const SizedBox(height: 24),

                // Invite Text
                const Text(
                  'Invite your friends using this code',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: AppColors.lightGrey,
                  ),
                ),

                const SizedBox(height: 8),

                // QR Row
                QrRow(
                  codeText: '78A5B94K9P',
                  onQrTap: () {
                    Navigator.pushNamed(context, '');
                  },
                ),

                const SizedBox(height: 16),

                const Text(
                  'Players 1/20',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: AppColors.lightGrey,
                  ),
                ),

                const SizedBox(height: 16),

                // Scrollable Grid
                Expanded(
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                    children: const [
                      PlayerInGameCard(playerName: 'Player 1'),
                      PlayerInGameCard(playerName: 'Player 2'),
                      PlayerInGameCard(playerName: 'Player 3'),
                      PlayerInGameCard(playerName: 'Player 4'),
                      PlayerInGameCard(playerName: 'Player 5'),
                      PlayerInGameCard(playerName: 'Player 6'),
                      PlayerInGameCard(playerName: 'Player 7'),
                      PlayerInGameCard(playerName: 'Player 8'),
                      PlayerInGameCard(playerName: 'Player 9'),
                    ],
                  ),
                ),

                // Bottom Fixed Area
                Center (
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        const Text(
                          'Launch the game as soon as you are ready',
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16,
                            color: AppColors.lightGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        StartGameButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, '/gameLoading');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }
}

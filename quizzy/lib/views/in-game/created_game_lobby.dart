import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import 'widgets/player_in_game_card.dart';

class CreatedGameLobbyPage extends StatelessWidget {
  const CreatedGameLobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Stack(
        children: [
          const BackgroundDecoration(
            child: SizedBox.shrink(),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row with Title and Exit Icon
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
                      icon: const Icon(Icons.logout,
                          color: AppColors.lightGrey, size: 32),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  prefixIcon: Icons.search,
                  // width: 350,
                  height: 42,
                ),

                const SizedBox(height: 24),

                // Invite label
                const Text(
                  'Invite your friends using this code',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: AppColors.lightGrey,
                  ),
                ),

                const SizedBox(height: 8),

                // Code container
                QrRow(
                  codeText: '78A5B94K9P',
                  onQrTap: () {
                    Navigator.pushNamed(context, '');
                  },
                ),

                const SizedBox(height: 16),

                const PlayerInGameCard(playerName: 'Player 1'),
                const SizedBox(height: 4),
                const PlayerInGameCard(playerName: 'Player 2'),


              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}

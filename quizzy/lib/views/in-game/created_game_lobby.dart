import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/views/in-game/widgets/start_game_btn.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/confirm_exit.dart';
import '../../core/widgets/quizzy_scaffold.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import '../../data/provider/quiz_provider.dart';
import 'widgets/player_in_game_card.dart';
import 'dart:math';
import 'qr_code_display_page.dart';

class CreatedGameLobbyPage extends StatefulWidget {
  const CreatedGameLobbyPage({super.key});

  @override
  State<CreatedGameLobbyPage> createState() => _CreatedGameLobbyPageState();
}

class _CreatedGameLobbyPageState extends State<CreatedGameLobbyPage> {
  late final String code;

  @override
  void initState() {
    super.initState();
    code = _generateCode();
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(10, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (_) {
      },
      disabled: true,
      body: Stack(
        children: [
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
                      onPressed: () => showConfirmExitDialog(context),
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
                  codeText: code,
                  onQrTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QrCodeDisplayPage(code: code),
                      ),
                    );
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
                    physics: const BouncingScrollPhysics(),
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
                Center(
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
                            Navigator.pushNamed(context, '/inGame');
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
    );
  }
}

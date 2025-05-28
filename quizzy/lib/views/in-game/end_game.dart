import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/model/quiz_request.dart';
import 'package:quizzy/data/model/score.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/app_images.dart';
import '../../core/widgets/quizzy_scaffold.dart';
import 'widgets/player_in_game_card.dart';
import 'widgets/start_game_btn.dart';

class EndGame extends StatefulWidget {
  const EndGame({super.key});

  @override
  State<EndGame> createState() => _EndGamestate();
}

class _EndGamestate extends State<EndGame> {
  bool _loaded = false;
  List<Score> scoreList = [];
  Quiz? _quiz;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is List<dynamic>) {
        scoreList = args.map((e) => Score.fromJson(e as Map<String, dynamic>)).toList();
      }
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _quiz = Provider.of<QuizProvider>(context, listen: false).quiz;
    if (_quiz == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (index) {},
      disabled: false,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Partie terminée',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Votre score',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontFamily: AppFonts.montserrat,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Score box
                  Container(
                    width: 350,
                    height: 105,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.deepLavender),
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.anthraciteBlack,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _quiz!.title,
                          style: const TextStyle(
                            color: AppColors.lightGrey,
                            fontFamily: AppFonts.lato,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.quizImage,
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${scoreList.isNotEmpty ? scoreList[0].score : 0} pts',
                              style: const TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: AppFonts.montserrat,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'The podium',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontFamily: AppFonts.montserrat,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  buildPodium(scoreList),

                  const SizedBox(height: 24),

                  StartGameButton(
                    text: 'Go to home page',
                    onPressed: () {
                      Navigator.pushNamed(context, '/createdGameLobby');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPodium(List<Score> scoreList) {
    if (scoreList.length <= 1) {
      return const Text('Bel entraînement solo !',
          style: TextStyle(
            color: AppColors.lightGrey,
            fontFamily: AppFonts.montserrat,
            fontSize: 16,
          ),
        );
    }

    final podium = scoreList.sublist(1); // Retire le joueur principal

    if (podium.length == 1) {
      return PlayerInGameCard(
        playerName: podium[0].playerName,
        playerAvatar: podium[0].avatarUrl,
      );
    }

    if (podium.length == 2) {
      return Column(
        children: [
          PlayerInGameCard(
            playerName: podium[0].playerName,
            playerAvatar: podium[0].avatarUrl,
          ),
          const SizedBox(height: 16),
          PlayerInGameCard(
            playerName: podium[1].playerName,
            playerAvatar: podium[1].avatarUrl,
          ),
        ],
      );
    }

    // 3 joueurs ou plus
    return Column(
      children: [
        PlayerInGameCard(
          playerName: podium[0].playerName,
          playerAvatar: podium[0].avatarUrl,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (podium.length > 1)
              PlayerInGameCard(
                playerName: podium[1].playerName,
                playerAvatar: podium[1].avatarUrl,
              ),
            if (podium.length > 2)
              PlayerInGameCard(
                playerName: podium[2].playerName,
                playerAvatar: podium[2].avatarUrl,
              ),
          ],
        ),
      ],
    );
  }
}

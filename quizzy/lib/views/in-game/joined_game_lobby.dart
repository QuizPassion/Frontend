import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';

import '../../core/widgets/quizzy_scaffold.dart';
import '../../core/widgets/search_with_qr.dart';

class JoinedGameLobbyPage extends StatelessWidget {
  const JoinedGameLobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (index) {
      },
      disabled: false,
      body: Stack(
        children: [
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

                // Host label
                const Center(
                  child: Text(
                    'Host :',
                    style: TextStyle(
                      fontFamily: AppFonts.lato,
                      fontSize: 18,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Fan2StarWars',
                    style: TextStyle(
                      fontFamily: AppFonts.montserrat,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightGrey,
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

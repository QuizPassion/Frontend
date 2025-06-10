import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_scaffold.dart';
class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  static const List<Map<String, dynamic>> bestScores = [
    {'name': 'Minecraft Quiz', 'score': 9055},
    {'name': 'The Flags', 'score': 8664},
    {'name': 'Car brands', 'score': 8322},
    {'name': 'The US states', 'score': 6564},
    {'name': 'Music artists', 'score': 6246},
  ];

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 2,
      onTap: (index) {},
      disabled: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Your best scores',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.montserrat,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 24),
              ...bestScores.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [AppColors.purpleBoxShadow],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        entry['name'],
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.anthraciteBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${entry['score']} pts',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

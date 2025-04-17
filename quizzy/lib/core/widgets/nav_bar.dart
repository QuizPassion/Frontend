import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_fonts.dart';

class QuizzyNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const QuizzyNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const double navBarHeight = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: navBarHeight,
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        boxShadow: [
          AppColors.purpleBoxShadow.copyWith(offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            icon: Icons.home,
            label: 'Home',
            index: 0,
            currentIndex: currentIndex,
            onTap: (i) {
              if (i != currentIndex) {
                Navigator.pushReplacementNamed(context, '/home');
                onTap(i);
              }
            },
          ),
          _NavBarItem(
            icon: Icons.add_circle_outline,
            label: 'Create Quizz',
            index: 1,
            currentIndex: currentIndex,
            onTap: (i) {
              if (i != currentIndex) {
                Navigator.pushReplacementNamed(context, '/allQuiz');
                onTap(i);
              }
            },
          ),
          _NavBarItem(
            icon: Icons.emoji_events,
            label: 'Score',
            index: 2,
            currentIndex: currentIndex,
            onTap: (i) {
              if (i != currentIndex) {
                Navigator.pushReplacementNamed(context, '/score');
                onTap(i);
              }
            },
          ),
          _NavBarItem(
            icon: Icons.settings,
            label: 'Parameters',
            index: 3,
            currentIndex: currentIndex,
            onTap: (i) {
              if (i != currentIndex) {
                Navigator.pushReplacementNamed(context, '/parameters');
                onTap(i);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;
    final color = isSelected ? AppColors.deepLavender : AppColors.lightGrey;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: isSelected ? 32 : 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 15,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

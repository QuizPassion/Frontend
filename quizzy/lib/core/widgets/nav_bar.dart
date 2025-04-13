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
          AppColors.purpleBoxShadow.copyWith(
            offset: const Offset(0, -2),
          ),
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
            onTap: onTap,
          ),
          _NavBarItem(
            icon: Icons.add_circle_outline,
            label: 'Create quizz',
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavBarItem(
            icon: Icons.emoji_events,
            label: 'Score',
            index: 2,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavBarItem(
            icon: Icons.settings,
            label: 'Parameters',
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
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
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.lightGrey,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 15,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}

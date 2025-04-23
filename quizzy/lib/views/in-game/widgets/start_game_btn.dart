import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_fonts.dart';

class StartGameButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartGameButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 226,
      height: 42,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.gradientLTR,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.zero,
          ),
          child: const Text(
            'Start the game',
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.lightGrey,
            ),
          ),
        ),
      ),
    );
  }
}

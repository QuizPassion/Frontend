import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_fonts.dart';
class StartGameButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const StartGameButton({
    super.key,
    required this.onPressed,
    this.text = 'Start the game',
  });

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
          child: Text(
            text,
            style: const TextStyle(
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

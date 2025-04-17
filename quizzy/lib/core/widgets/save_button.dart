import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_fonts.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      height: 42,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.gradientLTR, // add the gradient
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
            'Save',
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.lightGrey,
            ),
          ),
        ),
      ),
    );
  }
}

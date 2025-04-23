import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_fonts.dart';

class QuizzyTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final double width;
  final double height;
  final int? maxLines;
  final int? minLines;
  final TextEditingController controller;  // Ajoute le controller ici

  const QuizzyTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.width = double.infinity,
    this.height = 42,
    this.maxLines = 1,
    this.minLines,
    required this.controller,  // Assure-toi que ce paramètre est requis
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,  // Assure-toi de lier le controller ici
        maxLines: maxLines,
        minLines: minLines,
        style: const TextStyle(
          fontFamily: AppFonts.lato,
          fontSize: 18,
          color: AppColors.lightGrey,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.lightGrey,
            fontSize: 18,
            fontFamily: AppFonts.lato,
          ),
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.lightGrey)
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.deepLavender),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.royalPurple, width: 2),
          ),
        ),
      ),
    );
  }
}

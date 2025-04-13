import 'package:flutter/material.dart';

class AppColors {
  static const anthraciteBlack= Color(0xFF1E1E1E);
  static const royalPurple = Color(0xFF5B19A0);
  static const deepLavender  = Color(0xFF7B61FF);
  static const dynamicOrange= Color(0xFFFA8900);
  static const lightGrey = Color(0xFFEAEAEA);

  // Linear gradient from left to right
  static LinearGradient get gradientLTR => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.0, 0.61],
    colors: [
      Color(0xFFFA8900),
      Color(0xFF5B19A0),
    ],
  );

  // Linear gradient from right to left
  static LinearGradient get gradientRTL => const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    stops: [0.0, 0.61],
    colors: [
      Color(0xFFFA8900),
      Color(0xFF5B19A0),
    ],
  );
}
// Simple colors
/*
  import 'package:your_app/core/constants/app_colors.dart';

  Container(
    color: AppColors.primary,
  );
*/

// Gradient
/* 
  import 'package:your_app/core/constants/app_colors.dart';
  
  Container(
    decoration: BoxDecoration(
      gradient: AppColors.orangeToPurpleLTR,
    ),
  );
*/
import 'package:flutter/material.dart';

class AppColors {
  static const anthraciteBlack = Color(0xFF1E1E1E);
  static const royalPurple = Color(0xFF5B19A0);
  static const deepLavender = Color(0xFF7B61FF);
  static const dynamicOrange = Color(0xFFFA8900);
  static const lightGrey = Color(0xFFEAEAEA);

  static const purpleWithOpacity = Color(0x8E5B19A0);

  // Linear gradient left to right
  static LinearGradient get gradientLTR => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.0, 0.61],
        colors: [
          Color(0xFFFA8900),
          Color(0xFF5B19A0),
        ],
      );

  // Linear gradient right to left
  static LinearGradient get gradientRTL => const LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        stops: [0.0, 0.61],
        colors: [
          Color(0xFFFA8900),
          Color(0xFF5B19A0),
        ],
      );

  static LinearGradient get gradientTop2Btm => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0],
        colors: [
          Color(0xFF7B61FF),
          Color(0xFF5B19A0),
        ],
      );

  // Box shadow
  static final BoxShadow purpleBoxShadow = BoxShadow(
    color: purpleWithOpacity,
    offset: const Offset(0, 2),
    blurRadius: 4,
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

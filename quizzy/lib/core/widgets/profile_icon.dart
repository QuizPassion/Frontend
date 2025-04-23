import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
// import '../../core/app_fonts.dart';
import '../../core/app_images.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.deepLavender,
          width: 1,
        ),
      ),
      child: Center(
        child: Image.asset(
          AppImages.profilePicture,
          width: 68,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

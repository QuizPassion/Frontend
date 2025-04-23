import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/core/app_fonts.dart';

class ParameterCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ParameterCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 42,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.deepLavender, width: 1),
            bottom: BorderSide(color: AppColors.deepLavender, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.lightGrey,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.lightGrey,
                fontFamily: AppFonts.lato,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

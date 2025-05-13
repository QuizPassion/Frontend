import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'quizzy_text_field.dart';
import '../../core/app_fonts.dart';

class SearchWithQrRow extends StatelessWidget {
  final String hintText;
  final VoidCallback onQrTap;

  const SearchWithQrRow({
    super.key,
    required this.hintText,
    required this.onQrTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Row(
        children: [
          Expanded(
            child: QuizzyTextField(
              hintText: hintText,
              height: 42, 
              controller: TextEditingController(),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onQrTap,
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.anthraciteBlack,
                border: Border.all(color: AppColors.deepLavender),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.qr_code,
                color: AppColors.lightGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QrRow extends StatelessWidget {
  final String codeText;
  final VoidCallback onQrTap;

  const QrRow({
    super.key,
    required this.codeText,
    required this.onQrTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Row(
        children: [
          // The code display box
          Expanded(
            child: Container(
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.deepLavender),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                codeText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGrey,
                ),
              ),
            ),
          ),

          const SizedBox(width: 4),

          // The QR button
          GestureDetector(
            onTap: onQrTap,
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.anthraciteBlack,
                border: Border.all(color: AppColors.deepLavender),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.qr_code,
                color: AppColors.lightGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

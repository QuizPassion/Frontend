import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_scaffold.dart';

class QrCodeDisplayPage extends StatelessWidget {
  final String code;

  const QrCodeDisplayPage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (_) {
      },
      disabled: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Centered Go Back Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_back, color: AppColors.lightGrey, size: 32),
                      SizedBox(width: 8),
                      Text(
                        'Go back to previous page',
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 20,
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Dynamic centering
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Scan to join game',
                          style: TextStyle(
                            fontFamily: AppFonts.montserrat,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightGrey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        QrImageView(
                          data: code,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Code: $code',
                          style: const TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 18,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/nav_bar.dart';

class QrCodeDisplayPage extends StatelessWidget {
  final String code;

  const QrCodeDisplayPage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scan to join game',
              style: const TextStyle(
                fontFamily: AppFonts.montserrat,
                fontSize: 18,
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
                fontSize: 16,
                color: AppColors.lightGrey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 8,
        onTap: (index) {},
      ),
    );
  }
}

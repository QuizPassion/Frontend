import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/nav_bar.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,      
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              Navigator.pop(context, code);
              break;
            }
          }
        },
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 8,
        onTap: (index) {},
      ),
    );
  }
}

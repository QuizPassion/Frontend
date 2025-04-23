import 'package:flutter/material.dart';
import '../app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;

  const BackgroundDecoration({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure it takes the full width
      height: double.infinity, // Ensure it takes the full height
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _DecorationPainter(),
            ),
          ),
          // Page content
          child,
        ],
      ),
    );
  }
}

class _DecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final starPaint = Paint()..color = AppColors.royalPurple.withOpacity(0.5);
    final dotPaint = Paint()..color = const Color(0xFFCC4D82);

    final starPositions = [
      Offset(20, 50),
      Offset(size.width - 30, 100),
      Offset(60, size.height / 3),
      Offset(size.width - 50, size.height / 2),
      Offset(40, size.height - 100),
      Offset(size.width / 2, size.height - 50),
    ];

    final dotPositions = [
      Offset(30, 20),
      Offset(size.width - 60, 80),
      Offset(80, size.height / 4),
      Offset(size.width - 40, size.height / 1.8),
      Offset(20, size.height - 60),
      Offset(size.width / 2 + 30, size.height - 30),
    ];

    for (final offset in starPositions) {
      canvas.drawCircle(offset, 4, starPaint);
    }

    for (final offset in dotPositions) {
      canvas.drawCircle(offset, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

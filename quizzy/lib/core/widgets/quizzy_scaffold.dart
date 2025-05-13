import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'app_bar.dart';
import 'background_decoration.dart';
import 'nav_bar.dart';

class QuizzyScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final void Function(int)? onTap;
  final bool disabled;

  const QuizzyScaffold({
    super.key,
    required this.body,
    this.currentIndex = 0,
    this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Stack(
        children: [
          const BackgroundDecoration(child: SizedBox.shrink()),
          body,
        ],
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: currentIndex,
        onTap: onTap ?? (index) {},
        disabled: disabled,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration (
        child: Center(
          
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 0,
        onTap: (index) {
        },
      ),
    );
  }
}

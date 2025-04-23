import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/widgets/profile_icon.dart';

class PlayerInGameCard extends StatelessWidget {
  final String playerName;

  const PlayerInGameCard({
    super.key,
    required this.playerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        border: Border.all(
          color: AppColors.deepLavender,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ProfileIcon(),
          const SizedBox(height: 8),
          Text(
            playerName,
            style: const TextStyle(
              color: AppColors.lightGrey,
              fontFamily: 'Lato',
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

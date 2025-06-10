import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String imageUrl;

  const ProfileIcon({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 80, color: Colors.red);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

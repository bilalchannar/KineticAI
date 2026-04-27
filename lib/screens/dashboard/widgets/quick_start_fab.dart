import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class QuickStartFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const QuickStartFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
      label: const Text(
        'QUICK START',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }
}
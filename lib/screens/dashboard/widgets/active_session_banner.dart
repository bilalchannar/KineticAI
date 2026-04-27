import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class ActiveSessionBanner extends StatelessWidget {
  final String duration;
  final VoidCallback onTap;

  const ActiveSessionBanner({
    super.key,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.accent.withOpacity(0.3), blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.timer, color: Colors.black, size: 20),
            const SizedBox(width: 12),
            const Text(
              'ACTIVE SESSION',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const Spacer(),
            Text(
              duration,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class BreathingGuideWidget extends StatelessWidget {
  const BreathingGuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: const Row(
        children: [
          Icon(Icons.air_rounded, color: AppColors.accent),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Breathing Sync', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('Optimize recovery with acoustic analysis.', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
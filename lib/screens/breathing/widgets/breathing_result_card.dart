import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class BreathingResultCard extends StatelessWidget {
  final int bpm;
  final double consistency;

  const BreathingResultCard({
    super.key,
    required this.bpm,
    required this.consistency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'SESSION COMPLETE',
            style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('AVG BPM', bpm.toString()),
              Container(width: 1, height: 40, color: Colors.white10),
              _buildMetric('STABILITY', '${(consistency * 100).round()}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
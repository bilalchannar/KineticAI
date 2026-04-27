import 'package:flutter/material.dart';
import 'package:kinetic_ai/data/models/coaching_model.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class CoachFeedTile extends StatelessWidget {
  final CoachingModel tip;

  const CoachFeedTile({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getPriorityColor(tip.priority).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: _getPriorityColor(tip.priority), size: 16),
              const SizedBox(width: 8),
              Text(
                tip.category.toUpperCase(),
                style: TextStyle(color: _getPriorityColor(tip.priority), fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            tip.message,
            style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(CoachingPriority priority) {
    switch (priority) {
      case CoachingPriority.urgent: return Colors.redAccent;
      case CoachingPriority.high: return Colors.orangeAccent;
      case CoachingPriority.medium: return AppColors.accent;
      case CoachingPriority.low: return Colors.white38;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:kinetic_ai/data/models/activity_type.dart';
import 'package:kinetic_ai/shared/widgets/gradient_card.dart';

class ActivityCard extends StatelessWidget {
  final ActivityType type;
  final VoidCallback onTap;

  const ActivityCard({super.key, required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GradientCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getIcon(), color: Colors.white, size: 40),
            const SizedBox(height: 16),
            Text(
              type.displayName.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case ActivityType.walking: return Icons.directions_walk;
      case ActivityType.running: return Icons.directions_run;
      case ActivityType.hiking: return Icons.terrain;
      default: return Icons.accessibility_new;
    }
  }
}
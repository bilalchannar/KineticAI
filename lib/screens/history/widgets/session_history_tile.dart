import 'package:flutter/material.dart';
import 'package:kinetic_ai/data/models/session_model.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class SessionHistoryTile extends StatelessWidget {
  final SessionModel session;
  final VoidCallback onTap;

  const SessionHistoryTile({
    super.key,
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.fitness_center_rounded, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.activityType.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '${session.startTime.day}/${session.startTime.month} • ${session.duration.inMinutes} mins',
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${session.distance.toStringAsFixed(1)}km',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Text('TOTAL', style: TextStyle(color: Colors.white38, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
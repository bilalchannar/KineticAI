import 'package:flutter/material.dart';
import 'package:kinetic_ai/data/models/session_model.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class RecentSessionsList extends StatelessWidget {
  final List<SessionModel> sessions;

  const RecentSessionsList({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('No recent sessions', style: TextStyle(color: Colors.white24)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final session = sessions[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.history_rounded, color: Colors.white70, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.activityType.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${session.distance.toStringAsFixed(1)} km • ${session.duration.inMinutes} mins',
                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                '${session.averageSymmetry.round()}%',
                style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
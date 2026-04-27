import 'package:flutter/material.dart';
import 'package:kinetic_ai/data/models/session_model.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class SessionDetailSheet extends StatelessWidget {
  final SessionModel session;

  const SessionDetailSheet({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                session.activityType.name.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const Icon(Icons.share_rounded, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('DISTANCE', '${session.distance.toStringAsFixed(2)} km'),
              _buildMetric('PACE', '${session.averageSpeed.toStringAsFixed(1)} m/s'),
              _buildMetric('STEPS', session.steps.toString()),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white10),
          const SizedBox(height: 24),
          const Text('BIOMECHANICS ANALYSIS', style: TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 16),
          _buildAnalysisRow('Gait Symmetry', '${session.averageSymmetry.round()}%'),
          _buildAnalysisRow('Form Stability', 'Optimal'),
          _buildAnalysisRow('Impact Force', 'Low'),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }

  Widget _buildAnalysisRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
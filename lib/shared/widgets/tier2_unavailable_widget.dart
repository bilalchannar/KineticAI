import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class Tier2UnavailableWidget extends StatelessWidget {
  final String featureName;
  final String reason;

  const Tier2UnavailableWidget({
    super.key,
    required this.featureName,
    this.reason = 'Sensor not detected on this device',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sensors_off_rounded, size: 48, color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            '$featureName Unavailable',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reason,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
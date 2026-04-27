import 'package:flutter/material.dart';

class NoiseLevelIndicator extends StatelessWidget {
  final double db;

  const NoiseLevelIndicator({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.graphic_eq, color: Colors.white24, size: 16),
        const SizedBox(width: 8),
        Text(
          '${db.round()} dB',
          style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
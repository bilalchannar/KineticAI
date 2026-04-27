import 'package:flutter/material.dart';

class SpeedCadenceBar extends StatelessWidget {
  final double speed;
  final int cadence;

  const SpeedCadenceBar({super.key, required this.speed, required this.cadence});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMetric('PACE', '${speed.toStringAsFixed(1)} m/s'),
        Container(width: 1, height: 24, color: Colors.white10),
        _buildMetric('CADENCE', '$cadence SPM'),
      ],
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
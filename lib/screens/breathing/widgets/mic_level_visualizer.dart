import 'package:flutter/material.dart';
import 'dart:math' as math;

class MicLevelVisualizer extends StatelessWidget {
  final double dbLevel;

  const MicLevelVisualizer({super.key, required this.dbLevel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(20, (index) {
        // Simple procedural wave based on decibel level
        double height = math.max(4.0, (dbLevel - 30) * math.Random().nextDouble() * 2);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 4,
          height: height.clamp(4, 60),
          decoration: BoxDecoration(
            color: Colors.cyanAccent.withOpacity(0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
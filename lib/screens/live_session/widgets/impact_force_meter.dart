import 'package:flutter/material.dart';

class ImpactForceMeter extends StatelessWidget {
  final double force; // In Gs

  const ImpactForceMeter({super.key, required this.force});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('IMPACT', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          height: 100,
          width: 8,
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              FractionallySizedBox(
                heightFactor: (force / 5.0).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyanAccent, Colors.cyanAccent.withOpacity(0.1)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${force.toStringAsFixed(1)}G',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
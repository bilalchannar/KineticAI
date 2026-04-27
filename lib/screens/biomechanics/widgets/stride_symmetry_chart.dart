import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class StrideSymmetryChart extends StatelessWidget {
  final double symmetry;

  const StrideSymmetryChart({super.key, required this.symmetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('LEFT', style: TextStyle(color: Colors.white38, fontSize: 10)),
            Text('${symmetry.round()}% SYMMETRY', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const Text('RIGHT', style: TextStyle(color: Colors.white38, fontSize: 10)),
          ],
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 2,
                  color: Colors.white24,
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment(lerpDouble(-1, 1, symmetry / 100) ?? 0, 0),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  double? lerpDouble(num a, num b, double t) => a + (b - a) * t;
}
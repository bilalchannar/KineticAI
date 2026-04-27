import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class CheckpointMarker extends StatelessWidget {
  final int order;
  final String label;

  const CheckpointMarker({
    super.key,
    required this.order,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.accent.withOpacity(0.4), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: Text(
              order.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
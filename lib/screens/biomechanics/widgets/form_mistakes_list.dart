import 'package:flutter/material.dart';

class FormMistakesList extends StatelessWidget {
  final List<String> mistakes;

  const FormMistakesList({super.key, required this.mistakes});

  @override
  Widget build(BuildContext context) {
    if (mistakes.isEmpty) {
      return const Center(
        child: Text('Form is looking perfect!', style: TextStyle(color: Colors.white38)),
      );
    }

    return Column(
      children: mistakes.map((mistake) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 16),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                mistake,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}
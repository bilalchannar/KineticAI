import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDark;
  final Function(bool) onChanged;

  const ThemeToggle({super.key, required this.isDark, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isDark,
      onChanged: onChanged,
      activeColor: AppColors.accent,
      title: const Text('Dark Mode', style: TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: const Text('Optimized for high-performance viewing', style: TextStyle(color: Colors.white38, fontSize: 11)),
    );
  }
}
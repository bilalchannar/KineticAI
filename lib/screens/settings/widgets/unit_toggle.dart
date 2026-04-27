import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class UnitToggle extends StatefulWidget {
  const UnitToggle({super.key});

  @override
  State<UnitToggle> createState() => _UnitToggleState();
}

class _UnitToggleState extends State<UnitToggle> {
  bool _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Measurement Units', style: TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: Text(_isMetric ? 'Metric (km, kg)' : 'Imperial (mi, lbs)', style: const TextStyle(color: Colors.white38, fontSize: 11)),
      trailing: Switch(
        value: _isMetric,
        activeColor: AppColors.accent,
        onChanged: (val) => setState(() => _isMetric = val),
      ),
    );
  }
}
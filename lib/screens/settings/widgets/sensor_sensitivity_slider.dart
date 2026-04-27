import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class SensorSensitivitySlider extends StatefulWidget {
  final String label;
  final double initialValue;

  const SensorSensitivitySlider({
    super.key,
    required this.label,
    required this.initialValue,
  });

  @override
  State<SensorSensitivitySlider> createState() => _SensorSensitivitySliderState();
}

class _SensorSensitivitySliderState extends State<SensorSensitivitySlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label, style: const TextStyle(color: Colors.white, fontSize: 14)),
            Text('${(_currentValue * 100).round()}%', style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: _currentValue,
          activeColor: AppColors.accent,
          inactiveColor: Colors.white10,
          onChanged: (val) => setState(() => _currentValue = val),
        ),
      ],
    );
  }
}
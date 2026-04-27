import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrideSymmetryDetector {
  final List<double> _leftRotations = [];
  final List<double> _rightRotations = [];
  bool _isNextStepLeft = true;
  double _currentStepMaxRotation = 0.0;

  double process(double gyroMagnitude, bool isStep) {
    _currentStepMaxRotation = max(_currentStepMaxRotation, gyroMagnitude);

    if (isStep) {
      if (_isNextStepLeft) {
        _leftRotations.add(_currentStepMaxRotation);
      } else {
        _rightRotations.add(_currentStepMaxRotation);
      }

      if (_leftRotations.length > 10) _leftRotations.removeAt(0);
      if (_rightRotations.length > 10) _rightRotations.removeAt(0);

      _isNextStepLeft = !_isNextStepLeft;
      _currentStepMaxRotation = 0.0;
    }

    return calculateSymmetry();
  }

  double calculateSymmetry() {
    if (_leftRotations.isEmpty || _rightRotations.isEmpty) return 100.0;

    double avgLeft = _leftRotations.reduce((a, b) => a + b) / _leftRotations.length;
    double avgRight = _rightRotations.reduce((a, b) => a + b) / _rightRotations.length;

    if (avgLeft + avgRight == 0) return 100.0;

    double diff = (avgLeft - avgRight).abs();
    double total = avgLeft + avgRight;
    
    double symmetry = (1.0 - (diff / total)) * 100;
    return symmetry.clamp(0.0, 100.0);
  }
}

final strideSymmetryDetectorProvider = Provider<StrideSymmetryDetector>((ref) {
  return StrideSymmetryDetector();
});
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceScorer {
  final List<double> _wobbleWindow = [];
  static const int _windowSize = 100; // ~2 seconds of data
  static const double _maxWobble = 2.0; // Rad/s threshold for "very unstable"

  double process(double gyroMagnitude) {
    _wobbleWindow.add(gyroMagnitude);
    if (_wobbleWindow.length > _windowSize) {
      _wobbleWindow.removeAt(0);
    }

    if (_wobbleWindow.isEmpty) return 100.0;

    double avgWobble = _wobbleWindow.reduce((a, b) => a + b) / _wobbleWindow.length;
    
    // Scale: 0 wobble = 100 score, _maxWobble = 0 score
    double score = (1.0 - (avgWobble / _maxWobble)) * 100;
    return score.clamp(0.0, 100.0);
  }
}

final balanceScorerProvider = Provider<BalanceScorer>((ref) {
  return BalanceScorer();
});
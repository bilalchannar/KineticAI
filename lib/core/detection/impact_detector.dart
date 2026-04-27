import 'dart:math';

class ImpactDetector {
  double _peakG = 0.0;
  final List<double> _impactHistory = [];

  /// Processes accelerometer magnitude and returns the peak G of the current impact
  double process(double magnitude) {
    // Convert m/s^2 to G-force
    double gForce = magnitude / 9.80665;
    
    _peakG = max(_peakG, gForce);

    // If we detect a "valley" after a peak, record the impact
    if (gForce < 1.5 && _peakG > 2.0) {
      _impactHistory.add(_peakG);
      if (_impactHistory.length > 20) _impactHistory.removeAt(0);
      double lastPeak = _peakG;
      _peakG = 0.0;
      return lastPeak;
    }

    return 0.0;
  }

  double getAverageImpact() {
    if (_impactHistory.isEmpty) return 0.0;
    return _impactHistory.reduce((a, b) => a + b) / _impactHistory.length;
  }
}
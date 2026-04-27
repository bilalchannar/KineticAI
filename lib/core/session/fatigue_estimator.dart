import 'package:flutter_riverpod/flutter_riverpod.dart';

class FatigueEstimator {
  double _lastCadence = 0.0;
  double _lastImpact = 0.0;
  int _driftCount = 0;

  /// Feature 11: Fatigue estimation
  /// Returns a fatigue score from 0-100%
  double estimateFatigue(double currentCadence, double currentImpact, double speed) {
    if (speed < 0.5) return 0.0;

    // Logic: If impact increases while speed stays constant, user is likely landing heavier due to fatigue.
    // If cadence variability increases, coordination is dropping.
    
    if (currentImpact > _lastImpact * 1.2 && _lastImpact > 0) {
      _driftCount++;
    }

    _lastCadence = currentCadence;
    _lastImpact = currentImpact;

    return (_driftCount * 5.0).clamp(0.0, 100.0);
  }
}

final fatigueEstimatorProvider = Provider<FatigueEstimator>((ref) {
  return FatigueEstimator();
});
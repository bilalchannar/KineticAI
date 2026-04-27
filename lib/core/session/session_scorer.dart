import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionScorer {
  /// Calculates an overall session score based on multiple factors
  double calculateScore({
    required double symmetry,
    required double stability,
    required double distance,
    required double fatigue,
  }) {
    // Weighted formula for performance vs technique
    double techniqueScore = (symmetry + stability) / 2;
    double effortScore = (distance * 10).clamp(0, 100);
    double penalty = fatigue * 0.5;

    return ((techniqueScore * 0.6) + (effortScore * 0.4) - penalty).clamp(0, 100);
  }
}

final sessionScorerProvider = Provider<SessionScorer>((ref) {
  return SessionScorer();
});
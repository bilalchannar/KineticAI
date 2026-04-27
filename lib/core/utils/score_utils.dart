class ScoreUtils {
  /// Calculates a unified biomechanics score from 0-100
  static double calculateOverallScore({
    required double symmetry,
    required double stability,
    required double posture,
    required double fatigue,
  }) {
    // Weightings for different components
    const symmetryWeight = 0.35;
    const stabilityWeight = 0.25;
    const postureWeight = 0.30;
    const fatigueWeight = 0.10;

    double score = (symmetry * symmetryWeight) +
                  (stability * stabilityWeight) +
                  (posture * postureWeight) +
                  ((100 - (fatigue * 10)) * fatigueWeight);

    return score.clamp(0.0, 100.0);
  }

  static String getRiskLabel(double riskScore) {
    if (riskScore < 0.3) return 'LOW';
    if (riskScore < 0.7) return 'MODERATE';
    return 'HIGH';
  }
}
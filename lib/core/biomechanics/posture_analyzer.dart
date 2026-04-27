import 'dart:math';

class PostureAnalyzer {
  /// Analyzes posture based on skeleton keypoints (e.g., from TFLite)
  /// Returns a score from 0-100 where 100 is perfect vertical alignment
  double analyzeSpineAlignment({
    required double earY,
    required double shoulderY,
    required double hipY,
  }) {
    // Check vertical drift between major torso joints
    double alignmentScore = 100.0;
    
    // Simple verticality check
    double torsoHeight = (hipY - shoulderY).abs();
    if (torsoHeight < 0.1) return 0.0; // Invalid posture/detection

    // Head tilt check (dummy logic for demonstration)
    double headTilt = (earY - shoulderY).abs();
    if (headTilt > (torsoHeight * 0.3)) {
      alignmentScore -= 20; // Points off for "text neck"
    }

    return alignmentScore.clamp(0.0, 100.0);
  }
}
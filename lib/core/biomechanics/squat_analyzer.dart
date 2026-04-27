import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoseKeypoint {
  final double x;
  final double y;
  final double score;

  PoseKeypoint(this.y, this.x, this.score);
}

class SquatAnalyzer {
  static const int _leftHip = 11;
  static const int _rightHip = 12;
  static const int _leftKnee = 13;
  static const int _rightKnee = 14;
  static const int _leftAnkle = 15;
  static const int _rightAnkle = 16;

  String analyze(List<PoseKeypoint> keypoints) {
    if (keypoints.length < 17) return 'Position yourself in view';

    // Get relevant keypoints for the left side (or right, or both)
    final hip = keypoints[_leftHip];
    final knee = keypoints[_leftKnee];
    final ankle = keypoints[_leftAnkle];

    if (hip.score < 0.4 || knee.score < 0.4 || ankle.score < 0.4) {
      return 'Adjust camera to see full body';
    }

    double angle = _calculateAngle(hip, knee, ankle);

    if (angle > 160) {
      return 'Standing - Start Squat';
    } else if (angle > 100) {
      return 'Descending...';
    } else if (angle > 70) {
      return 'Great Depth!';
    } else {
      return 'Deep Squat';
    }
  }

  double getKneeAngle(List<PoseKeypoint> keypoints) {
    if (keypoints.length < 17) return 180.0;
    return _calculateAngle(keypoints[_leftHip], keypoints[_leftKnee], keypoints[_leftAnkle]);
  }

  double _calculateAngle(PoseKeypoint a, PoseKeypoint b, PoseKeypoint c) {
    double ang = (atan2(c.y - b.y, c.x - b.x) - atan2(a.y - b.y, a.x - b.x)) * (180 / pi);
    if (ang < 0) ang += 360;
    if (ang > 180) ang = 360 - ang;
    return ang;
  }
}

final squatAnalyzerProvider = Provider<SquatAnalyzer>((ref) {
  return SquatAnalyzer();
});
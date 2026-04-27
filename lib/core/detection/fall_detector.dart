import 'dart:math';

class FallDetector {
  static const double _fallThreshold = 0.5; // Near zero-G (freefall)
  static const double _impactThreshold = 30.0; // Sharp impact after fall

  bool _inFreefall = false;

  /// Detects falls using accelerometer magnitude
  bool process(double magnitude) {
    // Detect potential freefall
    if (magnitude < _fallThreshold) {
      _inFreefall = true;
    }

    // Detect high-impact landing after freefall
    if (_inFreefall && magnitude > _impactThreshold) {
      _inFreefall = false;
      return true; // Fall detected
    }

    // Reset if normal motion continues
    if (magnitude > 5.0 && magnitude < 15.0) {
      _inFreefall = false;
    }

    return false;
  }
}
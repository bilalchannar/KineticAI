import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/sensors/accelerometer_service.dart';
import 'package:kinetic_ai/data/models/activity_type.dart';

class ActivityDetector {
  static const int _windowSize = 50; // Approx 1-2 seconds of data
  final List<double> _magnitudeWindow = [];

  ActivityType detect(double magnitude) {
    _magnitudeWindow.add(magnitude);
    if (_magnitudeWindow.length > _windowSize) {
      _magnitudeWindow.removeAt(0);
    }

    if (_magnitudeWindow.length < _windowSize) {
      return ActivityType.unknown;
    }

    double mean = _magnitudeWindow.reduce((a, b) => a + b) / _magnitudeWindow.length;
    double variance = _magnitudeWindow.map((m) => pow(m - mean, 2)).reduce((a, b) => a + b) / _magnitudeWindow.length;

    if (variance < 0.5) {
      return ActivityType.stationary;
    } else if (variance < 5.0) {
      return ActivityType.walking;
    } else if (variance < 15.0) {
      return ActivityType.hiking;
    } else {
      return ActivityType.running;
    }
  }

  /// Feature 15: Hiking terrain difficulty
  /// Returns a difficulty score from 0-10 based on terrain roughness
  double calculateTerrainDifficulty(double variance) {
    // Higher variance at lower speeds usually indicates rougher terrain
    return (variance / 2.0).clamp(0.0, 10.0);
  }
}

final activityDetectorProvider = Provider<ActivityDetector>((ref) {
  return ActivityDetector();
});

final detectedActivityProvider = StreamProvider<ActivityType>((ref) {
  final accelerometerStream = ref.watch(accelerometerServiceProvider).magnitudeStream;
  final detector = ref.watch(activityDetectorProvider);

  return accelerometerStream.map((magnitude) => detector.detect(magnitude)).distinct();
});
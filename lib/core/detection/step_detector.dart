import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/sensors/accelerometer_service.dart';

class StepDetector {
  static const double _stepThreshold = 12.0; // Magnitude threshold for a step
  static const int _minStepIntervalMs = 300; // Debounce
  
  int _stepCount = 0;
  DateTime? _lastStepTime;
  
  bool isStep(double magnitude) {
    final now = DateTime.now();
    if (magnitude > _stepThreshold) {
      if (_lastStepTime == null || 
          now.difference(_lastStepTime!).inMilliseconds > _minStepIntervalMs) {
        _lastStepTime = now;
        _stepCount++;
        return true;
      }
    }
    return false;
  }

  int get stepCount => _stepCount;
}

final stepDetectorProvider = Provider<StepDetector>((ref) {
  return StepDetector();
});

// Provides the count of steps in the last minute
final cadenceProvider = StateProvider<double>((ref) {
  final accelerometerStream = ref.watch(accelerometerServiceProvider).magnitudeStream;
  final detector = ref.watch(stepDetectorProvider);
  
  // We'll use a timer to calculate cadence every 5 seconds
  double cadence = 0.0;
  List<DateTime> stepTimes = [];

  accelerometerStream.listen((magnitude) {
    if (detector.isStep(magnitude)) {
      stepTimes.add(DateTime.now());
    }
  });

  Timer.periodic(const Duration(seconds: 5), (timer) {
    final now = DateTime.now();
    stepTimes.removeWhere((t) => now.difference(t).inSeconds > 60);
    cadence = stepTimes.length.toDouble();
    ref.controller.state = cadence;
  });

  return cadence;
});
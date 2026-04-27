import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/detection/step_detector.dart';
import 'package:kinetic_ai/core/location/gps_service.dart';

class PerformanceMetrics {
  final double pace; // min/km
  final double cadence; // steps/min
  final double strideLength; // meters
  final double speed; // m/s

  PerformanceMetrics({
    required this.pace,
    required this.cadence,
    required this.strideLength,
    required this.speed,
  });
}

final performanceMetricsProvider = Provider<PerformanceMetrics>((ref) {
  final speed = ref.watch(speedProvider);
  final cadence = ref.watch(cadenceProvider);

  // Calculate Pace (min/km)
  // speed is in m/s. 1 m/s = 3.6 km/h. 
  // km/h = speed * 3.6
  // min/km = 60 / (speed * 3.6)
  double pace = 0.0;
  if (speed > 0.5) { // Minimum speed to calculate pace
    pace = 60 / (speed * 3.6);
  }

  // Calculate Stride Length (meters)
  // stride = distance / steps
  // stride = (speed * time) / (cadence * time / 60)
  // stride = (speed * 60) / cadence
  double strideLength = 0.0;
  if (cadence > 0) {
    strideLength = (speed * 60) / cadence;
  }

  return PerformanceMetrics(
    pace: pace,
    cadence: cadence,
    strideLength: strideLength,
    speed: speed,
  );
});

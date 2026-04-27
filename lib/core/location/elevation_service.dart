import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/location/gps_service.dart';

class ElevationMetrics {
  final double currentAltitude;
  final double gain;
  final double loss;

  ElevationMetrics({
    required this.currentAltitude,
    required this.gain,
    required this.loss,
  });
}

class ElevationService {
  double _lastAltitude = 0.0;
  double _totalGain = 0.0;
  double _totalLoss = 0.0;
  bool _isFirstPoint = true;

  ElevationMetrics processElevation(Position position) {
    final altitude = position.altitude;

    if (_isFirstPoint) {
      _lastAltitude = altitude;
      _isFirstPoint = false;
      return ElevationMetrics(currentAltitude: altitude, gain: 0, loss: 0);
    }

    double diff = altitude - _lastAltitude;
    if (diff > 0.5) { // Threshold to avoid noise
      _totalGain += diff;
    } else if (diff < -0.5) {
      _totalLoss += diff.abs();
    }

    _lastAltitude = altitude;

    return ElevationMetrics(
      currentAltitude: altitude,
      gain: _totalGain,
      loss: _totalLoss,
    );
  }
}

final elevationServiceProvider = Provider<ElevationService>((ref) {
  return ElevationService();
});

final elevationMetricsProvider = StateProvider<ElevationMetrics>((ref) {
  final positionStream = ref.watch(positionStreamProvider).value;
  final service = ref.watch(elevationServiceProvider);

  if (positionStream == null) {
    return ElevationMetrics(currentAltitude: 0, gain: 0, loss: 0);
  }

  return service.processElevation(positionStream);
});
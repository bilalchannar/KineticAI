import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarometerService {
  final _sensors = EnvironmentSensors();

  Stream<double> get pressureStream => _sensors.pressure;

  /// Estimates altitude change based on pressure change
  /// Standard barometric formula approximation
  double estimateAltitudeChange(double initialPressure, double currentPressure) {
    return 44330 * (1 - (currentPressure / initialPressure));
  }
}

final barometerServiceProvider = Provider<BarometerService>((ref) {
  return BarometerService();
});

final pressureStreamProvider = StreamProvider<double>((ref) {
  return ref.watch(barometerServiceProvider).pressureStream;
});
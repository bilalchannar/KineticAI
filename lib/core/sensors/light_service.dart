import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LightService {
  final _sensors = EnvironmentSensors();

  Stream<double> get lightStream => _sensors.light;
}

final lightServiceProvider = Provider<LightService>((ref) {
  return LightService();
});
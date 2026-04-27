import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SensorAvailability {
  final _sensors = EnvironmentSensors();

  Future<Map<SensorType, bool>> checkAvailability() async {
    final Map<SensorType, bool> availability = {};
    for (var type in SensorType.values) {
      availability[type] = await _sensors.getSensorAvailable(type);
    }
    return availability;
  }
}

final sensorAvailabilityProvider = Provider<SensorAvailability>((ref) {
  return SensorAvailability();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:environment_sensors/environment_sensors.dart';
import 'package:kinetic_ai/core/sensors/sensor_availability.dart';

class SensorStatusState {
  final Map<SensorType, bool> availability;
  final bool isCalibrating;

  SensorStatusState({this.availability = const {}, this.isCalibrating = false});
}

class SensorNotifier extends StateNotifier<SensorStatusState> {
  final Ref _ref;

  SensorNotifier(this._ref) : super(SensorStatusState());

  Future<void> checkSensors() async {
    final checker = _ref.read(sensorAvailabilityProvider);
    final results = await checker.checkAvailability();
    state = SensorStatusState(availability: results, isCalibrating: false);
  }
}

final sensorStatusProvider = StateNotifierProvider<SensorNotifier, SensorStatusState>((ref) {
  return SensorNotifier(ref);
});
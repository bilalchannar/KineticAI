import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccelerometerService {
  Stream<UserAccelerometerEvent> get userAccelerometerStream =>
      userAccelerometerEvents;

  /// Returns a stream of magnitudes (resultant acceleration)
  Stream<double> get magnitudeStream => userAccelerometerEvents.map((event) {
        return (event.x * event.x + event.y * event.y + event.z * event.z).toDouble();
      });
}

final accelerometerServiceProvider = Provider<AccelerometerService>((ref) {
  return AccelerometerService();
});

final userAccelerometerStreamProvider = StreamProvider<UserAccelerometerEvent>((ref) {
  return ref.watch(accelerometerServiceProvider).userAccelerometerStream;
});
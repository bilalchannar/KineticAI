import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GyroscopeService {
  Stream<GyroscopeEvent> get gyroscopeStream => gyroscopeEvents;
}

final gyroscopeServiceProvider = Provider<GyroscopeService>((ref) {
  return GyroscopeService();
});

final gyroscopeStreamProvider = StreamProvider<GyroscopeEvent>((ref) {
  return ref.watch(gyroscopeServiceProvider).gyroscopeStream;
});
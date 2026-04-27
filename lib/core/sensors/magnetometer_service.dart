import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MagnetometerService {
  Stream<MagnetometerEvent> get magnetometerStream => magnetometerEventStream();
}

final magnetometerServiceProvider = Provider<MagnetometerService>((ref) {
  return MagnetometerService();
});
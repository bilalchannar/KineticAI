import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProximityService {
  Stream<int> get proximityStream => ProximitySensor.events;
}

final proximityServiceProvider = Provider<ProximityService>((ref) {
  return ProximityService();
});
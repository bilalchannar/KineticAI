import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GpsService {
  Stream<Position> get positionStream => Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      );

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }
}

final gpsServiceProvider = Provider<GpsService>((ref) {
  return GpsService();
});

final positionStreamProvider = StreamProvider<Position>((ref) {
  return ref.watch(gpsServiceProvider).positionStream;
});

final speedProvider = Provider<double>((ref) {
  final position = ref.watch(positionStreamProvider).value;
  return position?.speed ?? 0.0;
});
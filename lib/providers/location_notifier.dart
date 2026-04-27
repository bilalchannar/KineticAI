import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationState {
  final Position? position;
  final List<Position> path;

  LocationState({this.position, this.path = const []});
}

class LocationNotifier extends StateNotifier<LocationState> {
  StreamSubscription? _sub;

  LocationNotifier() : super(LocationState());

  void startTracking() {
    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((position) {
      state = LocationState(
        position: position,
        path: [...state.path, position],
      );
    });
  }

  void stopTracking() {
    _sub?.cancel();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});
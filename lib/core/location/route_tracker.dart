import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/location/gps_service.dart';

class RouteTracker {
  final List<LatLng> _points = [];

  void addPoint(LatLng point) {
    if (_points.isEmpty) {
      _points.add(point);
      return;
    }

    // Optional: Only add if distance is significant to avoid jitter
    _points.add(point);
  }

  List<LatLng> get points => List.unmodifiable(_points);
  
  void clear() => _points.clear();
}

final routeTrackerProvider = Provider<RouteTracker>((ref) {
  return RouteTracker();
});

final routePointsProvider = StateProvider<List<LatLng>>((ref) {
  final position = ref.watch(positionStreamProvider).value;
  final tracker = ref.watch(routeTrackerProvider);

  if (position != null) {
    final newPoint = LatLng(position.latitude, position.longitude);
    tracker.addPoint(newPoint);
  }

  return tracker.points;
});
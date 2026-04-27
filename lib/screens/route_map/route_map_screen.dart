import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kinetic_ai/core/location/gps_service.dart';
import 'package:kinetic_ai/core/location/route_tracker.dart';
import 'package:kinetic_ai/providers/performance_notifier.dart';

class RouteMapScreen extends ConsumerStatefulWidget {
  const RouteMapScreen({super.key});

  @override
  ConsumerState<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends ConsumerState<RouteMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  bool _isAutoCenter = true;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    final points = ref.watch(routePointsProvider);
    final metrics = ref.watch(performanceMetricsProvider);
    final position = ref.watch(positionStreamProvider).value;

    // Update camera to follow user
    if (_isAutoCenter && position != null) {
      _controller.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: Stack(
        children: [
          _buildMap(points, position),
          _buildTopOverlay(metrics),
          _buildBottomControls(),
          _buildAutoCenterToggle(),
        ],
      ),
    );
  }

  Widget _buildMap(List<LatLng> points, dynamic position) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        _setMapStyle(controller);
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId('route'),
          points: points,
          color: const Color(0xFF6C63FF),
          width: 6,
          jointType: JointType.round,
          endCap: Cap.roundCap,
          startCap: Cap.roundCap,
        ),
      },
      markers: position != null
          ? {
              Marker(
                markerId: const MarkerId('current_pos'),
                position: LatLng(position.latitude, position.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet),
              ),
            }
          : {},
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
    );
  }

  void _setMapStyle(GoogleMapController controller) {
    // Premium dark map style (JSON)
    const String darkMapStyle = '''
    [
      {
        "elementType": "geometry",
        "stylers": [{"color": "#212121"}]
      },
      {
        "elementType": "labels.icon",
        "stylers": [{"visibility": "off"}]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [{"color": "#757575"}]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [{"color": "#212121"}]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [{"color": "#757575"}]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [{"color": "#181818"}]
      },
      {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [{"color": "#2c2c2c"}]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [{"color": "#000000"}]
      }
    ]
    ''';
    controller.setMapStyle(darkMapStyle);
  }

  Widget _buildTopOverlay(PerformanceMetrics metrics) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E).withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOverlayMetric(
                  'SPEED', (metrics.speed * 3.6).toStringAsFixed(1), 'km/h'),
              _buildDivider(),
              _buildOverlayMetric(
                  'PACE', metrics.pace.toStringAsFixed(2), 'min/km'),
              _buildDivider(),
              _buildOverlayMetric('TIME', '00:00', 'min'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayMetric(String label, String value, String unit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 10,
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          unit,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white10,
    );
  }

  Widget _buildBottomControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildControlButton(Icons.stop_rounded, Colors.redAccent, () {}),
            const SizedBox(width: 24),
            _buildControlButton(Icons.pause_rounded, Colors.orangeAccent, () {},
                isLarge: true),
            const SizedBox(width: 24),
            _buildControlButton(
                Icons.camera_alt_rounded, Colors.blueAccent, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color color, VoidCallback onTap,
      {bool isLarge = false}) {
    return Container(
      width: isLarge ? 80 : 60,
      height: isLarge ? 80 : 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: isLarge ? 32 : 24),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildAutoCenterToggle() {
    return Positioned(
      right: 20,
      bottom: 140,
      child: FloatingActionButton(
        mini: true,
        backgroundColor:
            _isAutoCenter ? const Color(0xFF6C63FF) : const Color(0xFF1E1E2E),
        onPressed: () => setState(() => _isAutoCenter = !_isAutoCenter),
        child: Icon(
          _isAutoCenter ? Icons.gps_fixed : Icons.gps_not_fixed,
          color: Colors.white,
        ),
      ),
    );
  }
}

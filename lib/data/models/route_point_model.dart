class RoutePointModel {
  final double latitude;
  final double longitude;
  final double altitude;
  final double speed;
  final double terrainDifficulty;
  final DateTime timestamp;

  RoutePointModel({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.speed,
    required this.terrainDifficulty,
    required this.timestamp,
  });
}
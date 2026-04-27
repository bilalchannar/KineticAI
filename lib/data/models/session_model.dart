import 'package:hive/hive.dart';
import 'package:kinetic_ai/data/models/activity_type.dart';

part 'session_model.g.dart';

@HiveType(typeId: 0)
class SessionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime endTime;

  @HiveField(3)
  final ActivityType activityType;

  @HiveField(4)
  final double averageSpeed;

  @HiveField(5)
  final double distance;

  @HiveField(6)
  final int steps;

  @HiveField(7)
  final double calories;

  @HiveField(8)
  final double averageSymmetry;

  @HiveField(9)
  final double elevationGain;

  SessionModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.activityType,
    required this.averageSpeed,
    required this.distance,
    required this.steps,
    required this.calories,
    required this.averageSymmetry,
    required this.elevationGain,
  });

  Duration get duration => endTime.difference(startTime);
}
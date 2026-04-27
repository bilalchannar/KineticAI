class CoachingModel {
  final String message;
  final CoachingPriority priority;
  final String category;
  final DateTime timestamp;

  CoachingModel({
    required this.message,
    required this.priority,
    required this.category,
    required this.timestamp,
  });
}

enum CoachingPriority {
  low,
  medium,
  high,
  urgent
}
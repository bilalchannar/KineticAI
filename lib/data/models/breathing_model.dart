class BreathingModel {
  final int breathsPerMinute;
  final double consistency;
  final List<double> rrIntervals;
  final DateTime timestamp;

  BreathingModel({
    required this.breathsPerMinute,
    required this.consistency,
    required this.rrIntervals,
    required this.timestamp,
  });
}
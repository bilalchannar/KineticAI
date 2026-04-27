class BiomechanicsModel {
  final double symmetry;
  final double impactForce;
  final double stabilityScore;
  final double postureScore;
  final DateTime timestamp;

  BiomechanicsModel({
    required this.symmetry,
    required this.impactForce,
    required this.stabilityScore,
    required this.postureScore,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'symmetry': symmetry,
    'impactForce': impactForce,
    'stabilityScore': stabilityScore,
    'postureScore': postureScore,
    'timestamp': timestamp.toIso8601String(),
  };
}
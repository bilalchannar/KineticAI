class InjuryRiskModel {
  final double riskScore; // 0.0 to 1.0
  final List<String> contributingFactors;
  final String recommendation;
  final DateTime timestamp;

  InjuryRiskModel({
    required this.riskScore,
    required this.contributingFactors,
    required this.recommendation,
    required this.timestamp,
  });
}
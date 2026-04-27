import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/ml/injury_predictor.dart';
import 'package:kinetic_ai/data/models/injury_risk_model.dart';
import 'package:kinetic_ai/providers/biomechanics_notifier.dart';

class InjuryNotifier extends StateNotifier<InjuryRiskModel?> {
  final Ref _ref;

  InjuryNotifier(this._ref) : super(null);

  void updateRisk() {
    final biomechanics = _ref.read(biomechanicsProvider);
    final predictor = _ref.read(injuryPredictorProvider);

    final risk = predictor.predictRisk([
      biomechanics.symmetry / 100,
      biomechanics.impactForce / 20, // Normalized
      biomechanics.stabilityScore / 100,
      0.5, // Placeholder for Fatigue
      0.5, // Placeholder for Cadence
    ]);

    state = InjuryRiskModel(
      riskScore: risk,
      contributingFactors: risk > 0.6 ? ['High Impact Force', 'Symmetry Variance'] : [],
      recommendation: risk > 0.6 ? 'Slow down and focus on posture.' : 'Risk levels are normal.',
      timestamp: DateTime.now(),
    );
  }
}

final injuryProvider = StateNotifierProvider<InjuryNotifier, InjuryRiskModel?>((ref) {
  return InjuryNotifier(ref);
});
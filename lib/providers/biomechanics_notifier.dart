import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/sensors/accelerometer_service.dart';
import 'package:kinetic_ai/core/sensors/gyroscope_service.dart';
import 'package:kinetic_ai/core/detection/step_detector.dart';
import 'package:kinetic_ai/core/biomechanics/stride_symmetry.dart';
import 'package:kinetic_ai/core/biomechanics/balance_scorer.dart';

class BiomechanicsState {
  final double symmetry;
  final double impactForce;
  final double stabilityScore;

  BiomechanicsState({
    required this.symmetry,
    required this.impactForce,
    required this.stabilityScore,
  });

  factory BiomechanicsState.initial() => BiomechanicsState(
        symmetry: 100.0,
        impactForce: 0.0,
        stabilityScore: 100.0,
      );
}

class BiomechanicsNotifier extends StateNotifier<BiomechanicsState> {
  final Ref _ref;
  StreamSubscription? _accelSub;
  StreamSubscription? _gyroSub;

  BiomechanicsNotifier(this._ref) : super(BiomechanicsState.initial()) {
    _init();
  }

  void _init() {
    final accelStream = _ref.read(accelerometerServiceProvider).magnitudeStream;
    final gyroStream = _ref.read(gyroscopeServiceProvider).gyroscopeStream;
    final stepDetector = _ref.read(stepDetectorProvider);
    final symmetryDetector = _ref.read(strideSymmetryDetectorProvider);
    final balanceScorer = _ref.read(balanceScorerProvider);

    double currentMaxAccel = 0.0;
    double currentMaxGyro = 0.0;

    _accelSub = accelStream.listen((magnitude) {
      currentMaxAccel = max(currentMaxAccel, magnitude);

      bool isStep = stepDetector.isStep(magnitude);
      
      // Feature 7: Impact Force
      if (isStep) {
        state = BiomechanicsState(
          symmetry: state.symmetry,
          impactForce: currentMaxAccel,
          stabilityScore: state.stabilityScore,
        );
        currentMaxAccel = 0.0;
      }

      // Feature 6: Symmetry Sync
      double symmetry = symmetryDetector.process(currentMaxGyro, isStep);
      if (isStep) {
        state = BiomechanicsState(
          symmetry: symmetry,
          impactForce: state.impactForce,
          stabilityScore: state.stabilityScore,
        );
        currentMaxGyro = 0.0;
      }
    });

    _gyroSub = gyroStream.listen((event) {
      double magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      currentMaxGyro = max(currentMaxGyro, magnitude);

      // Feature 9: Balance Stability
      double score = balanceScorer.process(magnitude);
      state = BiomechanicsState(
        symmetry: state.symmetry,
        impactForce: state.impactForce,
        stabilityScore: score,
      );
    });
  }

  @override
  void dispose() {
    _accelSub?.cancel();
    _gyroSub?.cancel();
    super.dispose();
  }
}

final biomechanicsProvider = StateNotifierProvider<BiomechanicsNotifier, BiomechanicsState>((ref) {
  return BiomechanicsNotifier(ref);
});
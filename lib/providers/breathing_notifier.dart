import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/sensors/noise_service.dart';
import 'package:kinetic_ai/core/biomechanics/breathing_analyzer.dart';
import 'package:kinetic_ai/data/models/breathing_model.dart';

class BreathingNotifier extends StateNotifier<BreathingModel?> {
  final Ref _ref;
  StreamSubscription? _sub;

  BreathingNotifier(this._ref) : super(null);

  void startMonitoring() {
    final noiseStream = _ref.read(noiseServiceProvider).noiseStream;
    final analyzer = BreathingAnalyzer();

    _sub = noiseStream.listen((reading) {
      final breathData = analyzer.process(reading.maxDecibel);
      if (breathData != null) {
        state = BreathingModel(
          breathsPerMinute: breathData.bpm,
          consistency: breathData.consistency,
          rrIntervals: breathData.intervals,
          timestamp: DateTime.now(),
        );
      }
    });
  }

  void stopMonitoring() {
    _sub?.cancel();
    state = null;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final breathingProvider = StateNotifierProvider<BreathingNotifier, BreathingModel?>((ref) {
  return BreathingNotifier(ref);
});
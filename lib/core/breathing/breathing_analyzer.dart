import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BreathingAnalyzer {
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  final List<double> _readings = [];

  void startAnalysis() {
    _noiseMeter ??= NoiseMeter();
    _noiseSubscription = _noiseMeter!.noise.listen((reading) {
      _readings.add(reading.meanDecibel);
      if (_readings.length > 100) _readings.removeAt(0);
    });
  }

  /// Feature 20: Breathing analysis
  /// Returns breaths per minute (BPM) based on decibel peaks
  double calculateBPM() {
    if (_readings.length < 20) return 0.0;
    
    int peaks = 0;
    for (int i = 1; i < _readings.length - 1; i++) {
      if (_readings[i] > _readings[i - 1] && _readings[i] > _readings[i + 1] && _readings[i] > 50) {
        peaks++;
      }
    }
    
    // Simplistic BPM estimate for demonstration
    return (peaks * 6.0).clamp(12.0, 40.0);
  }

  void stopAnalysis() {
    _noiseSubscription?.cancel();
  }
}

final breathingAnalyzerProvider = Provider<BreathingAnalyzer>((ref) {
  final analyzer = BreathingAnalyzer();
  ref.onDispose(() => analyzer.stopAnalysis());
  return analyzer;
});

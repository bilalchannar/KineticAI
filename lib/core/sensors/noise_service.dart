import 'package:noise_meter/noise_meter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoiseService {
  final NoiseMeter _noiseMeter = NoiseMeter();

  Stream<NoiseReading> get noiseStream => _noiseMeter.noise;
}

final noiseServiceProvider = Provider<NoiseService>((ref) {
  return NoiseService();
});
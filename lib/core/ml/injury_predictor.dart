import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InjuryPredictor {
  Interpreter? _interpreter;
  bool _isLoaded = false;

  Future<void> loadModel() async {
    if (_isLoaded) return;
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/injury_risk.tflite');
      _isLoaded = true;
    } catch (e) {
      print('Error loading injury risk model: $e');
    }
  }

  /// Predicts injury risk based on a sequence of metrics
  /// Input: [Symmetry, Impact, Cadence, StrideLength, Fatigue]
  double predictRisk(List<double> metrics) {
    if (_interpreter == null) return 0.0;

    var input = [metrics];
    var output = List.filled(1, 0.0).reshape([1, 1]);
    
    _interpreter!.run(input, output);
    return output[0][0]; // Returns risk score 0.0 to 1.0
  }

  void close() {
    _interpreter?.close();
  }
}

final injuryPredictorProvider = Provider<InjuryPredictor>((ref) {
  final predictor = InjuryPredictor();
  ref.onDispose(() => predictor.close());
  return predictor;
});
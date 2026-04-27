import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoseEstimator {
  Interpreter? _interpreter;
  bool _isLoaded = false;

  Future<void> loadModel() async {
    if (_isLoaded) return;
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/models/pose_estimation.tflite');
      _isLoaded = true;
    } catch (e) {
      print('Error loading TFLite model: $e');
    }
  }

  /// Runs inference on the input image data
  /// Input: [1, 192, 192, 3] float32
  /// Output: [1, 1, 17, 3] float32 (keypoints)
  List<dynamic>? predict(List<dynamic> input) {
    if (_interpreter == null) return null;

    var output = List.filled(1 * 1 * 17 * 3, 0.0).reshape([1, 1, 17, 3]);
    _interpreter!.run(input, output);
    return output;
  }

  void close() {
    _interpreter?.close();
  }
}

final poseEstimatorProvider = Provider<PoseEstimator>((ref) {
  final estimator = PoseEstimator();
  ref.onDispose(() => estimator.close());
  return estimator;
});

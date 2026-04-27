import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  Interpreter? _interpreter;

  Future<void> loadModel(String modelPath) async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
    } catch (e) {
      print('Error loading TFLite model: $e');
    }
  }

  Interpreter? get interpreter => _interpreter;

  void dispose() {
    _interpreter?.close();
  }
}
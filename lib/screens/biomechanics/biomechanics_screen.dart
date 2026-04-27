import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/ml/pose_estimator.dart';
import 'package:kinetic_ai/core/biomechanics/squat_analyzer.dart';

class BiomechanicsScreen extends ConsumerStatefulWidget {
  const BiomechanicsScreen({super.key});

  @override
  ConsumerState<BiomechanicsScreen> createState() => _BiomechanicsScreenState();
}

class _BiomechanicsScreenState extends ConsumerState<BiomechanicsScreen> {
  CameraController? _cameraController;
  bool _isProcessing = false;
  List<PoseKeypoint> _currentKeypoints = [];
  String _feedback = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => cameras.first),
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await ref.read(poseEstimatorProvider).loadModel();

    if (mounted) {
      setState(() {});
      _cameraController!.startImageStream(_processCameraImage);
    }
  }

  void _processCameraImage(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      // In a real app, we'd convert CameraImage to the format required by the model
      // For this implementation, we simulate the processing pipeline
      // final input = _convertImage(image);
      // final output = ref.read(poseEstimatorProvider).predict(input);
      
      // Simulation of keypoint detection for UI demonstration
      // In production, this would be replaced by actual TFLite output
      _mockInference();

      final analyzer = ref.read(squatAnalyzerProvider);
      _feedback = analyzer.analyze(_currentKeypoints);

      if (mounted) setState(() {});
    } finally {
      _isProcessing = false;
    }
  }

  void _mockInference() {
    // Creating some random keypoints to simulate detection
    // This allows the UI to be verified before actual model tuning
    _currentKeypoints = List.generate(17, (index) => PoseKeypoint(0.5, 0.5, 0.9));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Transform.scale(
            scale: 1.0,
            child: Center(child: CameraPreview(_cameraController!)),
          ),
          _buildPoseOverlay(),
          _buildFeedbackOverlay(),
          _buildTopBar(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Text(
              'SQUAT ANALYSIS',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const Icon(Icons.help_outline, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildPoseOverlay() {
    return CustomPaint(
      size: Size.infinite,
      painter: PosePainter(_currentKeypoints),
    );
  }

  Widget _buildFeedbackOverlay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.cyanAccent.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.cyanAccent.withOpacity(0.2), blurRadius: 20, spreadRadius: 5),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _feedback.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Keep your back straight and heels down',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class PosePainter extends CustomPainter {
  final List<PoseKeypoint> keypoints;
  PosePainter(this.keypoints);

  @override
  void paint(Canvas canvas, Size size) {
    if (keypoints.isEmpty) return;

    final paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Draw keypoints
    for (var kp in keypoints) {
      if (kp.score > 0.4) {
        canvas.drawCircle(Offset(kp.x * size.width, kp.y * size.height), 6, paint);
      }
    }
  }

  @override
  bool shouldRepaint(PosePainter oldDelegate) => true;
}
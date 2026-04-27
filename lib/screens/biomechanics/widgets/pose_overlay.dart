import 'package:flutter/material.dart';

class PoseOverlay extends StatelessWidget {
  final List<dynamic> keypoints;
  final Size imageSize;

  const PoseOverlay({
    super.key,
    required this.keypoints,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PosePainter(keypoints: keypoints, imageSize: imageSize),
      size: Size.infinite,
    );
  }
}

class PosePainter extends CustomPainter {
  final List<dynamic> keypoints;
  final Size imageSize;

  PosePainter({required this.keypoints, required this.imageSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final skeletonPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 2.0;

    for (var kp in keypoints) {
      final x = kp['x'] * size.width;
      final y = kp['y'] * size.height;
      
      if (kp['score'] > 0.5) {
        canvas.drawCircle(Offset(x, y), 6, paint);
      }
    }
    
    // Simple line connections could be added here for a full skeleton
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class ElevationGraph extends StatelessWidget {
  final List<double> data;

  const ElevationGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomPaint(
        painter: ElevationPainter(data: data),
      ),
    );
  }
}

class ElevationPainter extends CustomPainter {
  final List<double> data;

  ElevationPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final path = Path();
    final paint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [AppColors.accent.withOpacity(0.2), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    double dx = size.width / (data.length - 1);
    double maxElev = data.reduce((a, b) => a > b ? a : b);
    double minElev = data.reduce((a, b) => a < b ? a : b);
    double range = maxElev - minElev;

    path.moveTo(0, size.height - ((data[0] - minElev) / range * size.height));
    for (int i = 1; i < data.length; i++) {
      path.lineTo(i * dx, size.height - ((data[i] - minElev) / range * size.height));
    }

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
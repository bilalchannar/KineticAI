import 'package:flutter/material.dart';

class SessionTimer extends StatelessWidget {
  final Duration duration;

  const SessionTimer({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';

    return Text(
      '$hours$minutes:$seconds',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 64,
        fontWeight: FontWeight.w900,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }
}
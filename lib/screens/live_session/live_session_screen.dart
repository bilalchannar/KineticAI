import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/detection/activity_detector.dart';
import 'package:kinetic_ai/core/location/elevation_service.dart';
import 'package:kinetic_ai/providers/performance_notifier.dart';
import 'package:kinetic_ai/providers/biomechanics_notifier.dart';
import 'package:lottie/lottie.dart';

class LiveSessionScreen extends ConsumerWidget {
  const LiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(detectedActivityProvider);
    final metrics = ref.watch(performanceMetricsProvider);
    final elevation = ref.watch(elevationMetricsProvider);
    final bio = ref.watch(biomechanicsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: Stack(
        children: [
          _buildLiveBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildSessionHeader(context, activityAsync),
                  const Spacer(),
                  _buildPrimaryMetric(metrics),
                  const Spacer(),
                  _buildSecondaryMetrics(metrics, elevation),
                  const SizedBox(height: 24),
                  _buildCoachingCue(),
                  const SizedBox(height: 24),
                  _buildBiomechanicsPanel(bio),
                  const SizedBox(height: 40),
                  _buildActionControls(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiomechanicsPanel(BiomechanicsState bio) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.2)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildBioItem('SYMMETRY', '${bio.symmetry.toInt()}%', Icons.balance, Colors.indigoAccent),
            _buildVerticalBioDivider(),
            _buildBioItem('IMPACT', '${bio.impactForce.toStringAsFixed(1)}g', Icons.downhill_skiing, Colors.redAccent),
            _buildVerticalBioDivider(),
            _buildBioItem('STABILITY', '${bio.stabilityScore.toInt()}', Icons.bolt, Colors.amberAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildCoachingCue() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.psychology, color: Colors.amber),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'COACH: "Shorten your stride slightly to reduce knee impact."',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBioDivider() {
    return Container(width: 1, height: 20, color: Colors.white10, margin: const EdgeInsets.symmetric(horizontal: 12));
  }

  Widget _buildBioItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, -0.2),
          radius: 1.2,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF0A0A12),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionHeader(BuildContext context, AsyncValue activityAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        activityAsync.when(
          data: (activity) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                const Icon(Icons.flash_on, color: Colors.amber, size: 16),
                const SizedBox(width: 8),
                Text(
                  activity.displayName.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          loading: () => const SizedBox(),
          error: (_, __) => const SizedBox(),
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white54),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPrimaryMetric(PerformanceMetrics metrics) {
    return Column(
      children: [
        Text(
          'CURRENT SPEED',
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              (metrics.speed * 3.6).toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'km/h',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryMetrics(PerformanceMetrics metrics, ElevationMetrics elevation) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem('PACE', metrics.pace.toStringAsFixed(2), 'min/km'),
              _buildVerticalDivider(),
              _buildMetricItem('CADENCE', metrics.cadence.toInt().toString(), 'spm'),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.white10, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem('STRIDE', metrics.strideLength.toStringAsFixed(2), 'm'),
              _buildVerticalDivider(),
              _buildMetricItem('GAIN', elevation.gain.toInt().toString(), 'm'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Text(
              unit,
              style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 40, width: 1, color: Colors.white10);
  }

  Widget _buildActionControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircularButton(Icons.stop_rounded, Colors.redAccent, 70),
        const SizedBox(width: 32),
        _buildCircularButton(Icons.pause_rounded, Colors.orangeAccent, 90, isFilled: true),
        const SizedBox(width: 32),
        _buildCircularButton(Icons.lock_rounded, Colors.blueAccent, 70),
      ],
    );
  }

  Widget _buildCircularButton(IconData icon, Color color, double size, {bool isFilled = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isFilled ? color : color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.5), width: 2),
        boxShadow: isFilled
            ? [
                BoxShadow(color: color.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
              ]
            : [],
      ),
      child: Center(
        child: Icon(icon, color: isFilled ? Colors.white : color, size: size * 0.4),
      ),
    );
  }
}
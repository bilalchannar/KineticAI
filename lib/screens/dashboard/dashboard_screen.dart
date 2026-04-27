import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/detection/activity_detector.dart';
import 'package:kinetic_ai/core/location/elevation_service.dart';
import 'package:kinetic_ai/data/models/activity_type.dart';
import 'package:kinetic_ai/providers/performance_notifier.dart';
import 'package:kinetic_ai/screens/live_session/live_session_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(detectedActivityProvider);
    final metrics = ref.watch(performanceMetricsProvider);
    final elevation = ref.watch(elevationMetricsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LiveSessionScreen()),
          );
        },
        backgroundColor: const Color(0xFF6C63FF),
        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
        label: const Text('START WORKOUT',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          _buildBackgroundGlow(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildTopBar(),
                    const SizedBox(height: 30),
                    _buildMainActivityCard(activityAsync),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Performance Analytics'),
                    const SizedBox(height: 16),
                    _buildMetricsGrid(metrics, elevation),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Weekly Progress'),
                    const SizedBox(height: 16),
                    _buildWeeklyChart(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Recent Sessions'),
                    const SizedBox(height: 16),
                    _buildRecentSessions(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlow() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6C63FF).withOpacity(0.15),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -50,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00D2FF).withOpacity(0.1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Evening,',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
            const Text(
              'Kinetic User',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white12),
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF1E1E2E),
            child: Icon(Icons.person, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildMainActivityCard(AsyncValue<ActivityType> activityAsync) {
    return activityAsync.when(
      data: (activity) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getActivityGradient(activity),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: _getActivityGradient(activity)[0].withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'LIVE TRACKING',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'ACTIVE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Icon(
              _getActivityIconData(activity),
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              activity.displayName.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sensors analyzing movement pattern...',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMetricsGrid(
      PerformanceMetrics metrics, ElevationMetrics elevation) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.4,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMetricTile('Pace', metrics.pace.toStringAsFixed(2), 'min/km',
            Icons.speed, Colors.cyanAccent),
        _buildMetricTile('Cadence', metrics.cadence.toInt().toString(), 'spm',
            Icons.timer, Colors.orangeAccent),
        _buildMetricTile('Stride', metrics.strideLength.toStringAsFixed(2),
            'meters', Icons.straighten, Colors.blueAccent),
        _buildMetricTile('Gain', elevation.gain.toInt().toString(), 'meters',
            Icons.trending_up, Colors.greenAccent),
      ],
    );
  }

  Widget _buildMetricTile(
      String label, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Text(unit, style: TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(24),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 2),
                const FlSpot(2, 5),
                const FlSpot(3, 3.1),
                const FlSpot(4, 4),
                const FlSpot(5, 3),
                const FlSpot(6, 4),
              ],
              isCurved: true,
              color: const Color(0xFF6C63FF),
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6C63FF).withOpacity(0.2),
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSessions() {
    return Column(
      children: [
        _buildSessionItem('Morning Run', '5.2 km • 28m', Icons.directions_run,
            Colors.orangeAccent),
        _buildSessionItem(
            'Hill Hike', '3.1 km • 45m', Icons.terrain, Colors.brown),
        _buildSessionItem('Evening Walk', '2.4 km • 20m', Icons.directions_walk,
            Colors.greenAccent),
      ],
    );
  }

  Widget _buildSessionItem(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4), fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }

  List<Color> _getActivityGradient(ActivityType type) {
    switch (type) {
      case ActivityType.stationary:
        return [const Color(0xFF3E3E5E), const Color(0xFF2E2E4E)];
      case ActivityType.walking:
        return [const Color(0xFF00B09B), const Color(0xFF96C93D)];
      case ActivityType.running:
        return [const Color(0xFFFF5F6D), const Color(0xFFFFC371)];
      case ActivityType.hiking:
        return [const Color(0xFF834D9B), const Color(0xFFD04ED6)];
      case ActivityType.unknown:
      default:
        return [const Color(0xFF1E1E2E), const Color(0xFF0F0F1A)];
    }
  }

  IconData _getActivityIconData(ActivityType type) {
    switch (type) {
      case ActivityType.stationary:
        return Icons.accessibility_new;
      case ActivityType.walking:
        return Icons.directions_walk;
      case ActivityType.running:
        return Icons.directions_run;
      case ActivityType.hiking:
        return Icons.terrain;
      case ActivityType.unknown:
      default:
        return Icons.help_outline;
    }
  }
}

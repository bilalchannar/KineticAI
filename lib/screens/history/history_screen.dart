import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/providers/stats_notifier.dart';
import 'package:kinetic_ai/data/models/session_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ACTIVITY TRENDS',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildTrendsChart(stats),
              const SizedBox(height: 32),
              _buildMetricHighlights(stats),
              const SizedBox(height: 32),
              const Text(
                'RECENT SESSIONS',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildSessionList(stats.sessions),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendsChart(StatsState stats) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(24),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                  return Text(days[value.toInt() % 7], style: const TextStyle(color: Colors.white38, fontSize: 10));
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(7, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: (index + 3).toDouble(),
                  color: index == 6 ? const Color(0xFF6C63FF) : Colors.white12,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMetricHighlights(StatsState stats) {
    return Row(
      children: [
        _buildHighlightCard('Total Distance', '42.5', 'km', Icons.map, Colors.blueAccent),
        const SizedBox(width: 16),
        _buildHighlightCard('Avg Symmetry', '98', '%', Icons.balance, Colors.greenAccent),
      ],
    );
  }

  Widget _buildHighlightCard(String label, String value, String unit, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Text(unit, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
              ],
            ),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList(List<SessionModel> sessions) {
    if (sessions.isEmpty) {
      return const Center(child: Text('No sessions recorded yet', style: TextStyle(color: Colors.white38)));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[sessions.length - 1 - index];
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
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.directions_run, color: Colors.white.withOpacity(0.7)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(session.startTime),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${session.distance.toStringAsFixed(1)} km • ${session.duration.inMinutes}m',
                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '${session.steps} steps',
                style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
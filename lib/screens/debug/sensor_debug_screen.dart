import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/sensors/accelerometer_service.dart';
import 'package:kinetic_ai/core/sensors/gyroscope_service.dart';

class SensorDebugScreen extends ConsumerWidget {
  const SensorDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accel = ref.watch(userAccelerometerStreamProvider);
    final gyro = ref.watch(gyroscopeStreamProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('PRO SENSOR DEBUG', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildDebugCard('ACCELEROMETER', accel),
            const SizedBox(height: 20),
            _buildDebugCard('GYROSCOPE', gyro),
            const SizedBox(height: 40),
            _buildRealtimeGraph(),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugCard(String title, AsyncValue<dynamic> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 12),
          data.when(
            data: (val) => Text(
              val.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'monospace'),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildRealtimeGraph() {
    return const Text('Oscilloscope Graph coming soon...', style: TextStyle(color: Colors.white38));
  }
}

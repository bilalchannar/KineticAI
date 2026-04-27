import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'SETTINGS',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildSettingTile('Voice Coaching', Icons.record_voice_over, true),
            _buildSettingTile('Auto-Detect Activity', Icons.auto_mode, true),
            _buildSettingTile('Cloud Sync', Icons.cloud_done, false),
            const SizedBox(height: 32),
            const Text('DEVICE', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
            _buildSettingTile('Sensor Calibration', Icons.settings_input_component, null),
            _buildSettingTile('Pro Debug Mode', Icons.bug_report, null),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(String title, IconData icon, bool? value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white))),
          if (value != null)
            Switch(
              value: value,
              onChanged: (v) {},
              activeColor: const Color(0xFF6C63FF),
            )
          else
            const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }
}
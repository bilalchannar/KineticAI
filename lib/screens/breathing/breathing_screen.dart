import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/breathing/breathing_analyzer.dart';

class BreathingScreen extends ConsumerStatefulWidget {
  const BreathingScreen({super.key});

  @override
  ConsumerState<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends ConsumerState<BreathingScreen> {
  bool _isAnalyzing = false;
  double _bpm = 0.0;

  void _toggleAnalysis() {
    final analyzer = ref.read(breathingAnalyzerProvider);
    if (_isAnalyzing) {
      setState(() {
        _bpm = analyzer.calculateBPM();
        _isAnalyzing = false;
      });
      analyzer.stopAnalysis();
    } else {
      setState(() {
        _isAnalyzing = true;
        _bpm = 0.0;
      });
      analyzer.startAnalysis();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(title: const Text('BREATHING ANALYSIS'), backgroundColor: Colors.transparent),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildVisualizer(),
            const SizedBox(height: 60),
            Text(
              _isAnalyzing ? 'LISTENING...' : 'ANALYSIS COMPLETE',
              style: TextStyle(color: Colors.white.withOpacity(0.5), letterSpacing: 2),
            ),
            const SizedBox(height: 16),
            Text(
              '${_bpm.toInt()} BPM',
              style: const TextStyle(color: Colors.cyanAccent, fontSize: 48, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _toggleAnalysis,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isAnalyzing ? Colors.redAccent : Colors.cyanAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                _isAnalyzing ? 'STOP SESSION' : 'START BREATH ANALYSIS',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualizer() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.2), width: 2),
      ),
      child: Center(
        child: Icon(Icons.mic, color: Colors.cyanAccent, size: 60),
      ),
    );
  }
}
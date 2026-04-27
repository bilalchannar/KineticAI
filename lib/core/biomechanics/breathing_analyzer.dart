import 'dart:math';

class BreathingAnalyzer {
  final List<double> _peakHistory = [];
  DateTime? _lastPeakTime;
  final List<double> _intervals = [];

  /// Processes decibel readings to detect breathing peaks
  /// Returns a snapshot if a significant pattern is detected
  BreathingSnapshot? process(double decibels) {
    // Detect breath (simple peak thresholding for demonstration)
    if (decibels > 60.0) {
      final now = DateTime.now();
      if (_lastPeakTime != null) {
        final interval = now.difference(_lastPeakTime!).inMilliseconds.toDouble();
        
        // Filter for realistic breathing intervals (1.5s to 6s)
        if (interval > 1500 && interval < 6000) {
          _intervals.add(interval);
          if (_intervals.length > 10) _intervals.removeAt(0);
        }
      }
      _lastPeakTime = now;
    }

    if (_intervals.length >= 3) {
      double avgInterval = _intervals.reduce((a, b) => a + b) / _intervals.length;
      int bpm = (60000 / avgInterval).round();
      
      return BreathingSnapshot(
        bpm: bpm,
        consistency: 0.85, // Placeholder
        intervals: List.from(_intervals),
      );
    }

    return null;
  }
}

class BreathingSnapshot {
  final int bpm;
  final double consistency;
  final List<double> intervals;

  BreathingSnapshot({
    required this.bpm,
    required this.consistency,
    required this.intervals,
  });
}

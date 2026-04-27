import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/detection/activity_detector.dart';
import 'package:kinetic_ai/data/models/activity_type.dart';
import 'package:kinetic_ai/data/models/session_model.dart';
import 'package:kinetic_ai/providers/stats_notifier.dart';
import 'package:uuid/uuid.dart';

class SessionService {
  final Ref _ref;

  SessionService(this._ref);

  Future<void> completeSession({
    required DateTime startTime,
    required double speed,
    required double distance,
    required int steps,
    required double symmetry,
  }) async {
    final session = SessionModel(
      id: const Uuid().v4(),
      startTime: startTime,
      endTime: DateTime.now(),
      activityType: _ref.read(detectedActivityProvider).value ?? ActivityType.unknown,
      averageSpeed: speed,
      distance: distance,
      steps: steps,
      calories: distance * 60, // Simple estimation
      averageSymmetry: symmetry,
      elevationGain: 0, // Placeholder
    );

    await _ref.read(statsProvider.notifier).addSession(session);
  }
}

final sessionServiceProvider = Provider<SessionService>((ref) {
  return SessionService(ref);
});
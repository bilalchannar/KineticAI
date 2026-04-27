import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kinetic_ai/data/models/session_model.dart';

class StatsState {
  final List<SessionModel> sessions;
  final bool isLoading;

  StatsState({required this.sessions, this.isLoading = false});
}

class StatsNotifier extends StateNotifier<StatsState> {
  static const String _boxName = 'sessions_box';

  StatsNotifier() : super(StatsState(sessions: [], isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    final box = await Hive.openBox<SessionModel>(_boxName);
    state = StatsState(sessions: box.values.toList(), isLoading: false);
  }

  Future<void> addSession(SessionModel session) async {
    final box = Hive.box<SessionModel>(_boxName);
    await box.add(session);
    state = StatsState(sessions: box.values.toList());
  }

  double getWeeklyDistance() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return state.sessions
        .where((s) => s.startTime.isAfter(weekAgo))
        .fold(0.0, (sum, s) => sum + s.distance);
  }

  Map<DateTime, double> getDailyStepsForWeek() {
    final Map<DateTime, double> data = {};
    final now = DateTime.now();
    
    for (int i = 0; i < 7; i++) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final daySteps = state.sessions
          .where((s) => s.startTime.year == date.year && s.startTime.month == date.month && s.startTime.day == date.day)
          .fold(0.0, (sum, s) => sum + s.steps);
      data[date] = daySteps;
    }
    return data;
  }
}

final statsProvider = StateNotifierProvider<StatsNotifier, StatsState>((ref) {
  return StatsNotifier();
});
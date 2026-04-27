import 'package:kinetic_ai/data/firebase/firebase_stats_source.dart';

class StatsRepository {
  final FirebaseStatsSource _remoteSource;

  StatsRepository(this._remoteSource);

  Future<void> syncWeeklyStats({
    required double distance,
    required int steps,
    required double symmetry,
  }) async {
    await _remoteSource.updateWeeklyStats(
      totalDistance: distance,
      totalSteps: steps,
      avgSymmetry: symmetry,
    );
  }
}
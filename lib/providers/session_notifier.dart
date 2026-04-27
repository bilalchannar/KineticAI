import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionState {
  final bool isActive;
  final DateTime? startTime;
  final Duration elapsed;

  SessionState({
    this.isActive = false,
    this.startTime,
    this.elapsed = Duration.zero,
  });
}

class SessionNotifier extends StateNotifier<SessionState> {
  Timer? _timer;

  SessionNotifier() : super(SessionState());

  void startSession() {
    state = SessionState(isActive: true, startTime: DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = SessionState(
        isActive: true,
        startTime: state.startTime,
        elapsed: DateTime.now().difference(state.startTime!),
      );
    });
  }

  void stopSession() {
    _timer?.cancel();
    state = SessionState(isActive: false, startTime: state.startTime, elapsed: state.elapsed);
  }

  void reset() {
    _timer?.cancel();
    state = SessionState();
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier();
});
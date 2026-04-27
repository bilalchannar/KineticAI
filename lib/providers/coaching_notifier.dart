import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/core/coaching/gemini_coach.dart';

class CoachingState {
  final String advice;
  final bool isGenerating;

  CoachingState({this.advice = 'Keep your form steady!', this.isGenerating = false});
}

class CoachingNotifier extends StateNotifier<CoachingState> {
  final Ref _ref;

  CoachingNotifier(this._ref) : super(CoachingState());

  Future<void> updateAdvice(double symmetry, double impact, String activity) async {
    state = CoachingState(advice: state.advice, isGenerating: true);
    final coach = _ref.read(geminiCoachProvider);
    final advice = await coach.getCoachingAdvice(symmetry, impact, activity);
    state = CoachingState(advice: advice, isGenerating: false);
  }
}

final coachingNotifierProvider = StateNotifierProvider<CoachingNotifier, CoachingState>((ref) {
  return CoachingNotifier(ref);
});
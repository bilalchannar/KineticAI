import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeminiCoach {
  final GenerativeModel _model;

  GeminiCoach(String apiKey) 
    : _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

  Future<String> getCoachingAdvice(double symmetry, double impact, String activity) async {
    final prompt = '''
    You are an AI Biomechanics Coach. The user is currently $activity.
    Current Data:
    - Stride Symmetry: ${symmetry.toStringAsFixed(1)}%
    - Ground Impact: ${impact.toStringAsFixed(1)}g
    
    Provide a 1-sentence tactical coaching cue to improve their form. 
    Be encouraging but professional. Focus on injury prevention.
    ''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Maintain your form and keep moving!';
    } catch (e) {
      return 'Stay balanced and listen to your body.';
    }
  }
}

final geminiCoachProvider = Provider<GeminiCoach>((ref) {
  // In a real app, this key should be in a secure config/env
  return GeminiCoach('YOUR_API_KEY_HERE');
});
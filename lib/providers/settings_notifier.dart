import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final bool voiceCoaching;
  final bool autoDetect;
  final bool metricUnits;

  SettingsState({
    this.voiceCoaching = true,
    this.autoDetect = true,
    this.metricUnits = true,
  });
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  void toggleVoice(bool value) => state = SettingsState(voiceCoaching: value, autoDetect: state.autoDetect, metricUnits: state.metricUnits);
  void toggleAutoDetect(bool value) => state = SettingsState(voiceCoaching: state.voiceCoaching, autoDetect: value, metricUnits: state.metricUnits);
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
import 'package:kinetic_ai/data/models/coaching_model.dart';

class CoachingRepository {
  final List<CoachingModel> _cache = [];

  void addTip(CoachingModel tip) {
    _cache.add(tip);
    if (_cache.length > 50) _cache.removeAt(0);
  }

  List<CoachingModel> getLatestTips() => _cache.reversed.toList();
  
  CoachingModel? getMostUrgentTip() {
    if (_cache.isEmpty) return null;
    return _cache.reduce((curr, next) => 
      curr.priority.index > next.priority.index ? curr : next);
  }
}
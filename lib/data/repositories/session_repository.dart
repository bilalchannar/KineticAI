import 'package:kinetic_ai/data/models/session_model.dart';
import 'package:kinetic_ai/data/firebase/firebase_session_source.dart';

class SessionRepository {
  final FirebaseSessionSource _firebaseSource;

  SessionRepository(this._firebaseSource);

  Future<void> saveSession(SessionModel session) async {
    // Save to cloud, local is handled by Hive directly in StatsNotifier for now
    await _firebaseSource.uploadSession(session);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kinetic_ai/data/models/session_model.dart';

class FirebaseSessionSource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> uploadSession(SessionModel session) async {
    final user = _auth.currentUser;
    if (user != null) {
      // For brevity, we ignore the HiveObject specific fields
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .doc(session.id)
          .set({
            'startTime': session.startTime,
            'endTime': session.endTime,
            'activityType': session.activityType.index,
            'distance': session.distance,
            'steps': session.steps,
            'averageSymmetry': session.averageSymmetry,
          });
    }
  }
}
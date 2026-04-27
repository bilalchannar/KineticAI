import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStatsSource {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<void> updateWeeklyStats({
    required double totalDistance,
    required int totalSteps,
    required double avgSymmetry,
  }) async {
    if (_uid == null) return;

    await _db.collection('users').doc(_uid).collection('stats').doc('weekly').set({
      'totalDistance': totalDistance,
      'totalSteps': totalSteps,
      'avgSymmetry': avgSymmetry,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> watchWeeklyStats() {
    if (_uid == null) return const Stream.empty();
    return _db.collection('users').doc(_uid).collection('stats').doc('weekly').snapshots();
  }
}
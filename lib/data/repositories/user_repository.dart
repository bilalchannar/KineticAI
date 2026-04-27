import 'package:kinetic_ai/data/models/user_profile_model.dart';
import 'package:kinetic_ai/data/firebase/firebase_user_source.dart';

class UserRepository {
  final FirebaseUserSource _remoteSource;
  UserProfileModel _currentProfile = UserProfileModel.initial();

  UserRepository(this._remoteSource);

  UserProfileModel get profile => _currentProfile;

  Future<void> updateProfile(UserProfileModel profile) async {
    _currentProfile = profile;
    await _remoteSource.updateUserData({
      'name': profile.name,
      'weight': profile.weight,
      'height': profile.height,
      'targetGoal': profile.targetGoal,
    });
  }
}
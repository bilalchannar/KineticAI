class UserProfileModel {
  final String id;
  final String name;
  final double weight; // kg
  final double height; // cm
  final String targetGoal;
  final int weeklyStepGoal;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.targetGoal,
    required this.weeklyStepGoal,
  });

  factory UserProfileModel.initial() => UserProfileModel(
        id: 'user_01',
        name: 'Kinetic User',
        weight: 75.0,
        height: 175.0,
        targetGoal: 'Endurance',
        weeklyStepGoal: 50000,
      );
}
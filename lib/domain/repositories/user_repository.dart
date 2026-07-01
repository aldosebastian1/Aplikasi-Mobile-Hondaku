import '../models/user_profile.dart';

abstract class UserRepository {
  /// Fetches the user profile from the database based on the [uid].
  Future<UserProfile?> getUserProfile(String uid);

  /// Saves or updates the user profile in the database.
  Future<void> saveUserProfile(String uid, UserProfile profile);
}

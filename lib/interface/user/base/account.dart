import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/user/base_model/base_user_module.dart';


/// An abstract class that defines the authentication actions for users.
///
/// This class provides methods to create an account, log in, and log out.
/// The type parameter `UsersBaseModel` represents the type of user data model.
abstract class IBaseAuthentication {
  /// Creates a new user account.
  ///
  /// \param body An optional map containing the user details.
  /// \returns A `Future` that completes with a `UsersBaseModel` representing the created user.
  Future<UsersBaseModel> createAccount({Map<String, dynamic>? body});

  /// Logs in a user.
  ///
  /// \returns A `Future` that completes with a `UsersBaseModel` representing the logged-in user.
  Future<UsersBaseModel> logIn();

  /// Logs out the current user.
  ///
  /// \returns A `Future` that completes when the user is logged out.
  Future<void> logOut();

  /// Changes the password for the user.
  /// /// \param email The email address of the user whose password is being changed.
  /// \param oldPassword The current password of the user (required for re-authentication).
  /// \param newPassword The new password to set for the user account.
  /// /// \returns A `Future` that completes when the password is changed successfully.
  /// Throws a [FirebaseAuthException] if the old password is incorrect or other Firebase errors occur.
  Future<UsersBaseModel> changePassword(String email, String oldPassword, String newPassword);
  

}
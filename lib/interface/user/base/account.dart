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
}
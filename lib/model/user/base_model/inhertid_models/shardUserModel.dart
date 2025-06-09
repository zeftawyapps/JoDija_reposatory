
import '../base_user_module.dart';

/// A model class that extends `UsersBaseModel` to include additional user information.
class ShardUserModel extends UsersBaseModel {
  /// The key for the password field.
  static const String passKey = "pass";

  /// The user's password.
  String? pass;

  /// Constructs a `ShardUserModel` with optional parameters for password, uid, name, email, and token.
  ShardUserModel({
    this.pass,
    String? uid,
    String? name,
    String? email,
    String? token,
  }) : super(email: email, uid: uid, name: name, token: token);
}
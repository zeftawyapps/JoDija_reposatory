
 import 'package:firebase_auth/firebase_auth.dart';

/// A class that handles Firebase authentication operations.
class FirebaseAccount {

  /// Logs in a user with the provided email and password.
  ///
  /// [email] - The email of the user.
  /// [pass] - The password of the user.
  /// Returns a [Future] that completes with the [UserCredential] of the logged-in user.
  Future<UserCredential> logIn(String email, String pass) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  /// Logs out the currently logged-in user.
  ///
  /// Returns a [Future] that completes when the user is logged out.
  Future<void> logOut() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.signOut();
  }

  /// Creates a new user account with the provided email and password.
  ///
  /// [email] - The email of the new user.
  /// [pass] - The password of the new user.
  /// Returns a [Future] that completes with the [UserCredential] of the newly created user.
  Future<UserCredential> createNewAccount(String email, String pass) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.createUserWithEmailAndPassword(email: email, password: pass);
  }
}
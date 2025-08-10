
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

  /// Changes the password for a user account.
  ///
  /// This method re-authenticates the user with their current credentials
  /// and then updates their password to the new one provided.
  ///
  /// [email] - The email address of the user whose password is being changed.
  /// [oldPassword] - The current password of the user (required for re-authentication).
  /// [newPassword] - The new password to set for the user account.
  ///
  /// Throws:
  /// - [FirebaseAuthException] if the old password is incorrect or other Firebase errors occur.
  /// - [Exception] for any other unexpected errors during the process.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await firebaseAccount.changePassword(
  ///     'user@example.com',
  ///     'oldPassword123',
  ///     'newSecurePassword456'
  ///   );
  ///   print('Password changed successfully');
  /// } catch (e) {
  ///   print('Failed to change password: $e');
  /// }
  /// ```
  Future<void> changePassword(String email ,   String oldPassword, String newPassword) async {
    try {
      // First, log in the user to verify their current credentials
      final user = await this.logIn(email, oldPassword);
      
      // Re-authenticate the user with their old password for additional security
      final cred = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );
      await user.user?.reauthenticateWithCredential(cred);

      // If re-authentication is successful, update the password
      await user.user?.updatePassword(newPassword);

      print('Password updated successfully!');
      // Show a success message to the user.

    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('The old password you entered is incorrect.');
        // Handle incorrect password error.
      } else if (e.code == 'user-not-found') {
        print('No user found with this email address.');
        // Handle user not found error.
      } else if (e.code == 'weak-password') {
        print('The new password is too weak.');
        // Handle weak password error.
      } else {
        print('An error occurred: ${e.message}');
        // Handle other Firebase errors.
      }
      rethrow; // Re-throw the exception so calling code can handle it
    } catch (e) {
      print('An unexpected error occurred: $e');
      rethrow; // Re-throw the exception so calling code can handle it
    }
  }


}
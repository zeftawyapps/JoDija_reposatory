import 'package:JoDija_reposatory/https/http_urls.dart';
import 'package:JoDija_reposatory/source/user/accountLoginLogout/firebase/proflle_actions.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/user/base/account.dart';
import '../../interface/user/base/actions.dart';
import '../../interface/user/http_acc.dart';
import '../../model/user/base_model/base_user_module.dart';
import '../../utilis/firebase/fireBase_exception_consts.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';

/// A repository class for handling authentication-related operations.
///
/// This class provides methods for logging in, creating accounts, and managing
/// user profiles. It supports both HTTP and Firebase authentication mechanisms.
class BaseAuthRepo {
  late IBaseAccountActions _accountActions;
  late IBaseAuthentication _account;

  /// Constructs a `BaseAuthRepo` instance.
  ///
  /// \param account The authentication account.
  /// \param accountActions Optional account actions. If not provided, defaults to `ProfileActions`.
  BaseAuthRepo(IBaseAuthentication account,
      {IBaseAccountActions? accountActions}) {
    _account = account;
    _accountActions = accountActions ?? ProfileActions();
  }

  /// Logs in the user.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> logIn() async {
    try {
      if (_account is IHttpAuthentication) {
        return _logInHttp();
      } else {
        return _logInFirebase();
      }
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Creates a new account.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> createAccount() async {
    try {
      if (_account is IHttpAuthentication) {
        return _createAccountHttp();
      } else {
        return _createAccountFirebase();
      }
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Creates a new account and profile.
  ///
  /// \param usersModel The user model containing profile data.
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> createAccountAndProfile(
      UsersBaseModel usersModel) async {
    try {
      if (_account is IHttpAuthentication) {
        return _createAccountAndProfileHttp(usersModel);
      } else {
        return _createAccountAndProfileFirebase(usersModel);
      }
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Logs out the user.
  Future lagOut() async {
    _account.logOut();
  }

  /// Logs in the user using Firebase authentication.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> _logInFirebase() async {
    try {
      var user = await _account.logIn();
      var data = await _accountActions!.getDataByDoc(user.uid!);
      UsersBaseModel usersModel = UsersBaseModel.formJson(data);
      HttpHeader().setAuthHeader(user.token ?? "");
      usersModel.token = user.token;
      usersModel.uid = user.uid;
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Logs in the user using HTTP authentication.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> _logInHttp() async {
    try {
      var user = await _account.logIn();
      return Result.data(user);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Creates a new account using HTTP authentication.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> _createAccountHttp() async {
    try {
      var user = await _account.createAccount();
      return Result.data(user);
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Creates a new account using Firebase authentication.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>>
      _createAccountFirebase() async {
    try {
      var user = await _account.createAccount();
      var profileMapData = await _accountActions!.getDataByDoc(user.uid!);
      if (profileMapData.isEmpty || profileMapData.length == 0) {
        await _accountActions!
            .createProfileData(id: user.uid!, data: user.toJson());
        HttpHeader().setAuthHeader(user.token ?? "");
      } else {
        user = UsersBaseModel.formJson(profileMapData);
      }
      String token = user!.token!;
      HttpHeader().setAuthHeader(user.token! ?? "");
      return Result.data(user);
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Creates a new account and profile using Firebase authentication.
  ///
  /// \param usersModel The user model containing profile data.
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>>
      _createAccountAndProfileFirebase(UsersBaseModel usersModel) async {
    try {
      var user = await _account.createAccount();
      String userNameFromEmail = user.email!.split("@").first;
      String name = usersModel.name ?? user.name ?? "$userNameFromEmail";
      UsersBaseModel busersModel =
          UsersBaseModel(uid: user.uid, email: user.email, name: name);
      usersModel.uid = busersModel.uid;
      usersModel.email = busersModel.email;
      usersModel.name = busersModel.name;
      usersModel.token = user.token;
      await _accountActions!
          .createProfileData(id: usersModel.uid!, data: usersModel.toJson());
      HttpHeader().setAuthHeader(user.token ?? "");
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Creates a new account and profile using HTTP authentication.
  ///
  /// \param usersModel The user model containing profile data.
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> _createAccountAndProfileHttp(
      UsersBaseModel usersModel) async {
    try {
      var user = await _account.createAccount(body: usersModel.toJson());
      String userNameFromEmail = user.email!.split("@").first;
      String name = usersModel.name ?? user.name ?? "$userNameFromEmail";
      UsersBaseModel busersModel =
          UsersBaseModel(uid: user.uid, email: user.email, name: name);
      HttpHeader().setAuthHeader(user.token ?? "");
      return Result.data(busersModel);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Changes the password for a user account.
  ///
  /// This method handles password changes for both HTTP and Firebase authentication
  /// mechanisms. It validates the current password and updates it to the new one.
  ///
  /// [email] - The email address of the user whose password is being changed.
  /// [oldPassword] - The current password of the user (required for verification).
  /// [newPassword] - The new password to set for the user account.
  ///
  /// Returns:
  /// - A `Result<RemoteBaseModel, String>` where:
  ///   - Success: Contains "done" string indicating password was changed successfully
  ///   - Error: Contains `RemoteBaseModel` with error details and status
  ///
  /// Throws:
  /// - [FirebaseException] for Firebase-specific authentication errors
  /// - [Exception] for general errors during HTTP authentication
  ///
  /// Example:
  /// ```dart
  /// final result = await authRepo.changePassword(
  ///   'user@example.com',
  ///   'currentPassword123',
  ///   'newSecurePassword456'
  /// );
  /// 
  /// result.when(
  ///   data: (message) => print('Password changed: $message'),
  ///   error: (error) => print('Failed: ${error.message}'),
  /// );
  /// ```
  Future<Result<RemoteBaseModel, UsersBaseModel  >> changePassword(
    String email ,   String oldPassword, String newPassword) async {
    try {
      if (_account is IHttpAuthentication) {
         throw Exception("change password not supported in http authentication");
      } else    {
        return  await  _changePasswordFirebase( email ,  oldPassword, newPassword);     
      }  
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Changes password using HTTP authentication.
  ///
  /// [email] - The email address of the user.
  /// [oldPassword] - The current password for verification.
  /// [newPassword] - The new password to set.
  /// 
  /// Returns a `Result` with success message or error details.
  Future<Result<RemoteBaseModel, String >> _changePasswordHttp(
   String email ,    String oldPassword, String newPassword) async {
    try {
      await _account.changePassword( email ,  oldPassword, newPassword);
      return Result.data("done");
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  } 

  /// Changes password using Firebase authentication.
  ///
  /// [email] - The email address of the user.
  /// [oldPassword] - The current password for verification.
  /// [newPassword] - The new password to set.
  /// 
  /// Returns a `Result` with success message or error details.
  Future<Result<RemoteBaseModel, UsersBaseModel>> _changePasswordFirebase(
    String email ,   String oldPassword, String newPassword) async {
    try {
     final user =   await _account.changePassword( email ,  oldPassword, newPassword);
      return Result.data(user);
    } on FirebaseException catch (e) {
      return Result.error(RemoteBaseModel(
          message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }


}

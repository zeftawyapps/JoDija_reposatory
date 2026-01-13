
import '../../model/user/base_model/inhertid_models/user_model.dart';
import '../../source/user/accountLoginLogout/firebase/users_sourse.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';

/// A repository class for managing user data.
///
/// This class provides methods to retrieve user data using the provided
/// user actions sources.
class BaseUsersRepo {
  final UserModule _usersApi;

  /// Constructs a `BaseUsersRepo` instance.
  ///
  /// \param usersApi The user module for API interactions.
  BaseUsersRepo(this._usersApi);

  /// Retrieves a list of users from Firebase.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` or a list of `UserModule`.
  Future<Result<RemoteBaseModel, List<UserModule>>> getUsersUserFirebase() async {
    BaseUsersActionsSources usersSources = BaseUsersActionsSources();
    var data = await usersSources.getUsers();
    return Result(data: data, error: null);
  }
}
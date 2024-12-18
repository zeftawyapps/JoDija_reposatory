
import '../../model/user/base_model/inhertid_models/user_model.dart';
import '../../source/user/users_sourse.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';


class BaseUsersRepo {
  final UserModule _usersApi;

  BaseUsersRepo(this._usersApi);

  Future<  Result< RemoteBaseModel, List<UserModule>>> getUsersUserFirebase() async {

    BaseUsersActionsSources  usersSources = BaseUsersActionsSources();
    var data = await usersSources.getUsers();
    return  Result(data: data , error: null);
  }
}

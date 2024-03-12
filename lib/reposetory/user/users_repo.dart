
import '../../model/user/base_model/inhertid_models/user_model.dart';
import '../../source/user/users_sourse.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';


class UsersRepo {
  final UserModule _usersApi;

  UsersRepo(this._usersApi);

  Future<  Result< RemoteBaseModel, List<UserModule>>> getUsersUserFirebase() async {
    UsersSources  usersSources = UsersSources();
    var data = await usersSources.getUsers();
    return  Result(data: data , error: null);
  }
}

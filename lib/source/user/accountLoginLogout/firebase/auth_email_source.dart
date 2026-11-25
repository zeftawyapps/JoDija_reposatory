

import '../../../../interface/user/firebase_acc.dart';
import '../../../../model/user/base_model/base_user_module.dart';
import '../../../../utilis/firebase/firebase_account.dart';


class EmailPassowrdAuthSource implements IFirebaseAuthentication {
  String? email;
  String? pass;
  String? name;
  FirebaseAccount? _accountRegist;
  EmailPassowrdAuthSource(
      {required String this.email, required String this.pass, this.name}) {
    _accountRegist = FirebaseAccount();
  }
  @override
  Future<UsersBaseModel> createAccount({Map<String , dynamic >? body  }) async {

    var user = await _accountRegist!.createNewAccount(email!, pass!  );
   await  user.user!.updateDisplayName(name?? "user");
UsersBaseModel usersModel;
    String token = await user.user!.getIdToken() ?? "";
    usersModel = UsersBaseModel(name: user.user!.displayName, email: user.user!.email, uid: user.user!.uid, token: token);
    return usersModel;
  }

  @override
  Future<UsersBaseModel> logIn() async {
    UsersBaseModel usersModel;
    var user = await _accountRegist!.logIn(email!, pass!);
    String token = await user.user!.getIdToken() ?? "";
usersModel = UsersBaseModel(name: user.user!.displayName, email: user.user!.email, uid: user.user!.uid, token: token);
     return usersModel;
  }

  @override
  Future<void> logOut() async {
    await _accountRegist!.logOut();
  }
  
  @override
  Future<UsersBaseModel> changePassword(String email, String oldPassword, String newPassword) {
    return _accountRegist!.changePassword(email, oldPassword, newPassword);
  }


  
}

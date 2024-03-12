import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/user/base_model/base_user_module.dart';


abstract class IBaseAuthentication{

 Future<UsersBaseModel>  createAccount( {Map<String , dynamic >? body  });
 Future <UsersBaseModel> logIn();
Future<void> logOut();
}
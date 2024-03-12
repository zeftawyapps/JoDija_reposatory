
import '../base_user_module.dart';

class ShardUserModel extends UsersBaseModel {
  static const String passKey = "pass";

  String? pass;

  ShardUserModel({this.pass,

    String? uid,
    String? name,
    String? email , String? token})
      : super(email: email, uid: uid, name: name , token: token);


}
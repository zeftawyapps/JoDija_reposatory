import '../../model/user/base_model/inhertid_models/shardUserModel.dart';

class UserDataStored{
  // sengleton class for user data stored from shared prefrence with sahredUserModel
 ShardUserModel? userModel ;
  static final UserDataStored _userDataStored = UserDataStored._internal();
  factory UserDataStored() {
    return _userDataStored;
  }
  UserDataStored._internal();
  void setUserData(ShardUserModel userModel){
    this.userModel = userModel ;
  }
  ShardUserModel? getUserData(){
    return userModel ;
  }



}
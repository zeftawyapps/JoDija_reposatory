import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/user/base/actions.dart';
import '../../model/user/base_model/base_user_module.dart';
import '../../source/user/account_actions.dart';
import '../../utilis/firebase/fireBase_exception_consts.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';
import '../../utilis/result/result.dart';
import '../../utilis/shardeprefrance/shard_check.dart';


class ProfilRebo{

  SharedPrefranceChecking ? _sharedRefrance ;
 late IBaseAccountActions _accountActions;
  ProfilRebo(IBaseAccountActions accountActions){
    _sharedRefrance = SharedPrefranceChecking();
     _accountActions = accountActions;
  }
   Future<Result<RemoteBaseModel, UsersBaseModel >> getProfile(  ) async {
    try {
      String uid =  await _sharedRefrance!.getUid();
      _accountActions = UserProfileFirebaseActions();
      var profileMapData =    await _accountActions!.getData(uid );
      UsersBaseModel  usersModel = UsersBaseModel . formJson(profileMapData);
      return  Result.data(usersModel);
    } on FirebaseException catch (e) {
      return  Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }
  Future< Result< RemoteBaseModel, UsersBaseModel >> editProfile( Map<String ,dynamic> map  ) async {
    try {
      String uid =  await _sharedRefrance!.getUid();
      _accountActions = UserProfileFirebaseActions();
       var result  =   await _accountActions.updateProfileData(id: uid , mapData: map );
      UsersBaseModel  usersModel = UsersBaseModel . formJson(result);
      return  Result.data(usersModel);

    } on FirebaseException catch (e) {
      return  Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }
}
 import 'package:JoDija_DataSource/utilis/shardeprefrance/shardPrfrance.dart';
import 'package:JoDija_DataSource/utilis/shardeprefrance/user_data_stored.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user/base_model/inhertid_models/shardUserModel.dart';



class SharedPrefranceChecking {

 void   IsUserRejised(
     { required  Function(ShardUserModel shardUserModel) isRegistAction,
       required  Function() NotRegistAction}) async  {
 var data = await    SharedPreferences.getInstance();
    bool isRejset = data.getBool(SharedPrefranceData.USER_ISREJESTED)?? false ;
     if (isRejset){
       String email = data.getString(SharedPrefranceData.USER_EMAIL)??"";
       String pass = data.getString(SharedPrefranceData.USER_PASS )??"";
       String uid = data.getString(SharedPrefranceData.USER_UID )??"";
       String token = data.getString(SharedPrefranceData.USER_TOKen )??"";
print ("token : $token");
print ("email : $email");
print ("uid : $uid");
var modele = ShardUserModel(email: email , pass: pass ,uid: uid , token: token ) ;
UserDataStored().setUserData(modele);
       isRegistAction(  modele );
     } else {
       NotRegistAction();
     }
  }
Future<String > getUid() async{
 var value =   await  SharedPreferences.getInstance();
      return value.  getString(SharedPrefranceData.USER_UID) ?? "";

  }
  Future setDataInShardRefrace ({String? email, String? pass , String? uid , String? token  })async {
   var modele =    ShardUserModel(email: email , pass: pass ,uid: uid , token: token ) ;
   UserDataStored().setUserData(modele);
    var data = await    SharedPreferences.getInstance();
    await data.setBool(SharedPrefranceData.USER_ISREJESTED, true  );
    await   data.setString(SharedPrefranceData.USER_EMAIL,email ?? ""  );
    await   data.setString(SharedPrefranceData.USER_PASS,pass?? ""  );
    await   data.setString(SharedPrefranceData.USER_UID,uid ?? ""  );
    await  data.setString(SharedPrefranceData.USER_TOKen, token ?? "" );



  }


}
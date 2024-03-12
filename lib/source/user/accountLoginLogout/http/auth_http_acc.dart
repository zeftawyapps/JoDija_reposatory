import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../constes/api_urls.dart';
import '../../../../interface/user/http_acc.dart';
import '../../../../model/user/base_model/base_user_module.dart';
import '../../../../utilis/http_remotes/http_client.dart';
import '../../../../utilis/http_remotes/http_client.dart';
import '../../../../utilis/http_remotes/http_methos_enum.dart';


class AuthHttpSource implements IHttpAuthentication {
  String? email;
  String? pass;
  String? name;

  AuthHttpSource({required String email, required String pass }) {
    this.email = email;
    this.pass = pass;

  }
  @override
  Future<UsersBaseModel> createAccount({Map<String , dynamic >? body  }) async {
    Map<String , dynamic >? allBody = {"email": email , "password": pass ,    }    ;
allBody.addAll(body!  );
    var user = await  JoDijaHttpClient (userToken: true).sendRequestResultWithMap(
        method: HttpMethod.POST,
        url: "ApiUrls.createAccount",
        body: allBody   ,
        cancelToken: CancelToken());
    var data = user.data!["data"];
    return UsersBaseModel.formJson(data) ;
  }

  @override
  Future<UsersBaseModel> logIn() async {

    var user =     await JoDijaHttpClient(userToken: true).sendRequestResultWithMap(
        method: HttpMethod.POST,
        url:" ApiUrls.logIn",
        body:  {"email": email , "password": pass}   ,
        cancelToken: CancelToken());

    var status = user.data!["status"];
    if (status != 200) {
      throw Exception(user );
    }


    var data = user.data!["data"];
 Map<String ,dynamic>userData = {};
    userData["email"] = email  ;
    userData["token"] = data["token"]  ;
    userData.addAll(data);

    return UsersBaseModel.formJson(userData!) ;
  }

  @override
  Future<void> logOut() async {

      await  JoDijaHttpClient(userToken: true).sendRequestResultWithMap(
        method: HttpMethod.POST,
        url: "ApiUrls.logOut ",
        body:  {"email": email , "password": pass}   ,
        cancelToken: CancelToken());


  }
}

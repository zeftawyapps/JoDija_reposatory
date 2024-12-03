

import 'package:JoDija_DataSource/https/http_urls.dart';
import 'package:JoDija_DataSource/source/user/proflle_actions.dart';
import 'package:JoDija_DataSource/utilis/result/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../interface/user/base/account.dart';
import '../../interface/user/base/actions.dart';
import '../../interface/user/http_acc.dart';
import '../../model/user/base_model/base_user_module.dart';
import '../../model/user/base_model/inhertid_models/user_model.dart';
 import '../../utilis/firebase/fireBase_exception_consts.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';

class BaseAuthRepo {
  IBaseAccountActions? _accountActions;
  late IBaseAuthentication _account;
  BaseAuthRepo(IBaseAuthentication account) {
    _account = account;
  }

  Future< Result< RemoteBaseModel, UsersBaseModel>> logIn() async {
    try {
      if (_account is IHttpAuthentication) {
        return _logInHttp();
      } else {
        return _logInFirebase();
      }
    } on FirebaseException catch (e) {
      return Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status:StatusModel.error ));
    }
  }

  Future<Result< RemoteBaseModel, UsersBaseModel>> createAccount(
      ) async {
    try {
      if (_account is IHttpAuthentication) {
        return _createAccountHttp();
      } else {
        return _createAccountFirebase();
      }
    } on FirebaseException catch (e) {
      return Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status:  StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, UsersBaseModel>> createAccountAndProfile(
      UsersBaseModel usersModel) async {
    try {
      if (_account is IHttpAuthentication) {
        return _createAccountAndProfileHttp(usersModel);
      } else {
        return _createAccountAndProfileFirebase(usersModel);
      }
    } on FirebaseException catch (e) {
      return Result.error(
          RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  Future lagOut() async {
    _account.logOut();
  }

  Future<Result<RemoteBaseModel, UsersBaseModel>> _logInFirebase() async {
    try {
      var user = await _account.logIn();

      _accountActions = ProfileActions();
 var data =      await _accountActions!.getDataByDoc(user.uid!);
      UsersBaseModel usersModel =
          UsersBaseModel.formJson(  data );
      HttpHeader().setAuthHeader( user.token  ?? "");
      usersModel.token = user.token;
      usersModel.uid = user.uid; 
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, UsersBaseModel>> _logInHttp() async {
    try {
      var user = await _account.logIn();

      return Result.data(user);
    }  catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString()  , status: StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, UsersBaseModel>>
      _createAccountHttp() async {
    try {

      var user = await _account.createAccount();

      return Result.data(user);
    } on FirebaseException catch (e) {
      return Result.error(
          RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, UsersBaseModel>>
      _createAccountFirebase() async {
    try {
      var user = await _account.createAccount();

      _accountActions = ProfileActions();
      var profileMapData = await _accountActions!.getDataByDoc(user.uid!);
      if (profileMapData.isEmpty || profileMapData.length == 0) {
        await _accountActions!
            .createProfileData(id: user.uid!, data: user.toJson());

        HttpHeader().setAuthHeader(user.token ?? "");
      } else {
        user = UsersBaseModel.formJson(profileMapData);
      }
      // set token
      String token = user!.token!;
      HttpHeader().setAuthHeader(user.token! ?? "");

      return  Result.data(user);
    } on FirebaseException catch (e) {
      return  Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  Future< Result< RemoteBaseModel, UsersBaseModel>>
      _createAccountAndProfileFirebase(UsersBaseModel usersModel) async {
    try {
      var user = await _account.createAccount();
      String userNameFromEmail = user.email!.split("@").first;
      String name = usersModel.name ?? user.name ?? "$userNameFromEmail";
      UsersBaseModel busersModel =
          UsersBaseModel(uid: user.uid, email: user.email, name: name);
      usersModel.uid = busersModel.uid;
      usersModel.email = busersModel.email;
      usersModel.name = busersModel.name;
      usersModel.token = user.token;
      _accountActions = ProfileActions();

      await _accountActions!
          .createProfileData(id: usersModel.uid!, data: usersModel.toJson());
      // set token
      HttpHeader().setAuthHeader(user.token ?? "");
      return  Result.data(usersModel);
    } on FirebaseException catch (e) {
      return  Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status:  StatusModel.error));
    }
  }

  Future< Result< RemoteBaseModel, UsersBaseModel>>
      _createAccountAndProfileHttp(UsersBaseModel usersModel) async {
    try {
      var user = await _account.createAccount(body: usersModel.toJson());
      String userNameFromEmail = user.email!.split("@").first;
      String name = usersModel.name ?? user.name ?? "$userNameFromEmail";

      UsersBaseModel busersModel =
          UsersBaseModel(uid: user.uid, email: user.email, name: name);


      // set token
      HttpHeader().setAuthHeader(user.token ?? "");
      return  Result.data(busersModel);
    }  catch (e) {
      return  Result.error(
           RemoteBaseModel(message: e.toString()  , status:  StatusModel.error));
    }
  }
}

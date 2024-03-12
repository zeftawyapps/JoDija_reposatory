import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../constes/collections.dart';
import '../../interface/user/base/actions.dart';
import '../../utilis/firebase/fireBase_exception_consts.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';
import '../../utilis/result/result.dart';
import '../../utilis/shardeprefrance/shard_check.dart';


class ProfileSubDataRebo {
  SharedPrefranceChecking? _sharedRefrance;
  late IProfileSubDataActions _Actions;
  ProfileSubDataRebo(IProfileSubDataActions accountActions) {
    _sharedRefrance = SharedPrefranceChecking();
    _Actions = accountActions;
  }


  Future<Result<RemoteBaseModel, List<Map<String, dynamic>>>> getProfileSubData(
      {  required String subCollection ,  required String docId, Query Function(Query query)? query}) async {
    try {
      String collection = CollectionsName.usersAccountData;
      var path = "$collection/$docId/$subCollection";
      var profileMapData =
      await _Actions!.getData(path: path, queryBuilder: query);
      return  Result.data(profileMapData);
    } on FirebaseException catch (e) {
      return  Result.error(
           RemoteBaseModel(message: handilExcepstons(e.code), status:  StatusModel.error));
    }
  }





}

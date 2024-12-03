import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constes/collections.dart';
import '../../interface/user/base/actions.dart';
import '../../model/user/base_model/base_user_module.dart';
import '../../utilis/firebase/firebase.dart';
import '../../utilis/firebase/firebase_and_storage_action.dart';
import '../../utilis/firebase/firestore_inputs.dart';

class ProfileActions implements IBaseAccountActions {


  FirestoreAndStorageActions? _firestoreAndStorageActions =   FirestoreAndStorageActions() ;
  FireStoreAction? _fireStoreAction = FireStoreAction();
  FirebaseLoadingData? _firebaseLoadingData = FirebaseLoadingData();



  ProfileActions() ;

  @override
  Future createProfileData(
      {required String id, required Map<String, dynamic> data}) async {
    await _fireStoreAction!.addDataCloudFirestore(
        id: id, path: CollectionsName.usersAccountData, mymap: data);
  }

  @override
  Future<Map<String, dynamic>> getDataByDoc(String uid) async {
    _firebaseLoadingData = FirebaseLoadingData();
  var data  = await    _firebaseLoadingData!.loadSingleDocData(
         CollectionsName.usersAccountData, uid);
     if (data == null) {
       return {};
     } else {
       return data;
     }

  }


  @override
  Future<Map<String, dynamic>> SearchDataById(String uid) async {
    CollectionReference firebaseCollection;
    firebaseCollection =
        FirebaseFirestore.instance.collection(CollectionsName.usersAccountData);
    QuerySnapshot doc =
    await firebaseCollection.where("uid", isEqualTo: uid).limit(1).get();

    var data = FirebaseLoadingData().getDataSnapshotOpjectToMap(doc);
    var result = data.length;
    if (result == 0) {
      return {};
    } else {
      return data.first;
    }
  }


  @override
  Future<Map<String, dynamic>> updateProfileData(
      {required String id,    Map<String, dynamic>? mapData ,
      Object ? file
      }) async {
    await _firestoreAndStorageActions!.editeDataCloudFirestorWithUpload(
        collection: CollectionsName.usersAccountData,
        id: id,
        mymap: mapData!,
        file: file,
        filedowloadurifieldname: "imguri");
    return getDataByDoc(id);
  }
}
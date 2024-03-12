import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constes/collections.dart';
import '../../interface/user/base/actions.dart';
import '../../utilis/firebase/firebase.dart';
import '../../utilis/firebase/firebase_and_storage_action.dart';
import '../../utilis/firebase/firestore_inputs.dart';


class UserProfileFirebaseActions implements IBaseAccountActions {
  FirestoreAndStorageActions? _firestoreAndStorageActions;
  FireStoreAction? _fireStoreAction;
  FirebaseLoadingData? _firebaseLoadingData;

  File? file;
  Map<String, dynamic>? data;

  UserProfileFirebaseActions({this.file, this.data}) {
    _fireStoreAction = FireStoreAction();
    _firebaseLoadingData = FirebaseLoadingData();
    _firestoreAndStorageActions = FirestoreAndStorageActions();
  }

  @override
  Future createProfileData(
      {required String id, required Map<String, dynamic> data}) async {
    await _fireStoreAction!.addDataCloudFirestore(
        id: id, path: CollectionsName.usersAccountData, mymap: data);
  }

  @override
  Future<Map<String, dynamic>> getData(String uid) async {
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
  Future<Map<String, dynamic>> updateProfileData({required String id , Map<String , dynamic >?mapData }) async {


    await _firestoreAndStorageActions!.editeDataCloudFirestorWithUpload(
        collection: CollectionsName.usersAccountData,
        id: id,
        mymap: mapData!,
        file: file,
        filedowloadurifieldname: "imguri");
    return getData(id);
  }
}

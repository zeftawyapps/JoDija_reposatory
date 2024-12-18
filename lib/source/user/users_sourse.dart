import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constes/collections.dart';
import '../../model/user/base_model/inhertid_models/user_model.dart';
import '../../utilis/firebase/firebase.dart';
import '../../utilis/firebase/firebase_and_storage_action.dart';
import '../../utilis/firebase/firestore_inputs.dart';


class BaseUsersActionsSources  {
  FirestoreAndStorageActions? _firestoreAndStorageActions;
  FireStoreAction? _fireStoreAction;
  FirebaseLoadingData? _firebaseLoadingData;

  File? file;
  Map<String, dynamic>? data;
String path = CollectionsName.usersAccountData1;
  BaseUsersActionsSources({this.path =  CollectionsName.usersAccountData1} ) {
    _fireStoreAction = FireStoreAction();
    _firebaseLoadingData = FirebaseLoadingData();
    _firestoreAndStorageActions = FirestoreAndStorageActions();
  }

  // get users
  Future<List<UserModule>> getUsers() async {
    CollectionReference firebaseCollection;
    firebaseCollection =
        FirebaseFirestore.instance.collection(path );
    QuerySnapshot doc =
        await firebaseCollection.get();

    var data = FirebaseLoadingData().getDataSnapshotOpjectToMap(doc);
    var result = data.length;
    if (result == 0) {
      return [];
    } else {
      return data.map((e) => UserModule.formJson(e)).toList();
    }
  }

 }

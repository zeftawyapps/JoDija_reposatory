import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../constes/collections.dart';
import '../../../../model/user/base_model/inhertid_models/user_model.dart';
import '../../../../utilis/firebase/firebase.dart';


class BaseUsersActionsSources  {
  File? file;
  Map<String, dynamic>? data;
  String path = CollectionsName.usersAccountData;
  BaseUsersActionsSources({this.path = CollectionsName.usersAccountData});

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

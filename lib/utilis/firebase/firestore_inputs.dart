
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

   class FireStoreAction{
  String firestoreDocmentid = "";


  Future<DocumentReference> addDataCloudFirestoreWithoutid(
      {required String collection, required Map<String, dynamic> mymap}) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection.add(mymap);
  }

  Future<Object> editDataCloudFirestore({required String path,
    required String id,
    required Map<String, dynamic> mymap}) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(path);
    await firebaseCollection.doc(id).update(mymap);
    var docData = await  firebaseCollection.doc(id).get();
  return docData.data()! ;
  }

  Future<Object> editDataCloudFirestoreSubColletion({required String collection,
    required String id,
    required String subCollection,
    required String docId,

    required Map<String, dynamic> mymap}) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    await firebaseCollection.
        doc(docId).collection(subCollection).doc(id).update(mymap);

    var docData = await  firebaseCollection.doc(id).get();
    return docData.data()! ;
  }

  Future<void> deleteDataCloudFirestoreOneDocument(
      {required String path, required String id}) async {
    await Firebase.initializeApp();
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(path);
    return firebaseCollection.doc(id).delete();
  }
  Future<void> deleteDataCloudFirestoreOneDocumentSubCollection(
      {required String collection,
        required String subCollection,
        required String docId,
        required String id}) async {
    await Firebase.initializeApp();
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection.doc(docId)
        .collection(subCollection).doc(id).delete();

  }
  Future<void> deleteDataCloudFirestoreAllCollection(
      {required String collection}) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection.doc().delete();
  }



  Future<void> testFireStore() {
    return addDataCloudFirestore(path: "Test", mymap: {"name": "Moaz"});
  }
  Future<String> addDataCloudFirestoreSupCollection({required String collection,
    required String subCollection,
    required String docId,
    String? id,
    required Map<String, dynamic> mymap}) async {
    if (id == null) {
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(collection)
      .doc(docId).collection(subCollection);
      ;
      await firebaseCollection.add(mymap).then((value) {
        this.firestoreDocmentid = value.id;
      });
    } else {
      firestoreDocmentid = id;
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(collection);
       await  firebaseCollection.doc(id).set(mymap);

    }
    return firestoreDocmentid ;
  }


  Future<String> addDataCloudFirestore({required String path,
    String? id,
    required Map<String, dynamic> mymap}) async {
    if (id == null|| id=="") {
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(path);
      await firebaseCollection.add(mymap).then((value) {
        this.firestoreDocmentid = value.id;
      });
    } else {
      firestoreDocmentid = id;
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(path);
      await  firebaseCollection.doc(id).set(mymap);

    }
    return firestoreDocmentid ;
  }


   }
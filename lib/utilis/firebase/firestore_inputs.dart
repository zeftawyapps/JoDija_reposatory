
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// A class that provides various Firestore actions such as adding, editing, and deleting documents.
class FireStoreAction {
  String firestoreDocmentid = "";

  /// Adds a document to a Firestore collection without specifying an ID.
  ///
  /// Parameters:
  /// - `collection`: The name of the collection.
  /// - `mymap`: The data to be added.
  ///
  /// Returns a `DocumentReference` of the added document.
  Future<DocumentReference> addDataCloudFirestoreWithoutid({
    required String collection,
    required Map<String, dynamic> mymap,
  }) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection.add(mymap);
  }

  /// Edits a document in a Firestore collection.
  ///
  /// Parameters:
  /// - `path`: The path of the collection.
  /// - `id`: The ID of the document to be edited.
  /// - `mymap`: The data to be updated.
  ///
  /// Returns the updated document data.
  Future<Object> editDataCloudFirestore({
    required String path,
    required String id,
    required Map<String, dynamic> mymap,
  }) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(path);
    await firebaseCollection.doc(id).update(mymap);
    var docData = await firebaseCollection.doc(id).get();
    return docData.data()!;
  }

  /// Edits a document in a sub-collection of a Firestore collection.
  ///
  /// Parameters:
  /// - `collection`: The name of the collection.
  /// - `id`: The ID of the document to be edited.
  /// - `subCollection`: The name of the sub-collection.
  /// - `docId`: The ID of the parent document.
  /// - `mymap`: The data to be updated.
  ///
  /// Returns the updated document data.
  Future<Object> editDataCloudFirestoreSubColletion({
    required String collection,
    required String id,
    required String subCollection,
    required String docId,
    required Map<String, dynamic> mymap,
  }) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    await firebaseCollection
        .doc(docId)
        .collection(subCollection)
        .doc(id)
        .update(mymap);

    var docData = await firebaseCollection.doc(id).get();
    return docData.data()!;
  }

  /// Deletes a document from a Firestore collection.
  ///
  /// Parameters:
  /// - `path`: The path of the collection.
  /// - `id`: The ID of the document to be deleted.
  Future<void> deleteDataCloudFirestoreOneDocument({
    required String path,
    required String id,
  }) async {
    await Firebase.initializeApp();
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(path);
    return firebaseCollection.doc(id).delete();
  }

  /// Deletes a document from a sub-collection of a Firestore collection.
  ///
  /// Parameters:
  /// - `collection`: The name of the collection.
  /// - `subCollection`: The name of the sub-collection.
  /// - `docId`: The ID of the parent document.
  /// - `id`: The ID of the document to be deleted.
  Future<void> deleteDataCloudFirestoreOneDocumentSubCollection({
    required String collection,
    required String subCollection,
    required String docId,
    required String id,
  }) async {
    await Firebase.initializeApp();
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection
        .doc(docId)
        .collection(subCollection)
        .doc(id)
        .delete();
  }

  /// Deletes all documents from a Firestore collection.
  ///
  /// Parameters:
  /// - `collection`: The name of the collection.
  Future<void> deleteDataCloudFirestoreAllCollection({
    required String collection,
  }) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection.doc().delete();
  }

  /// A test method to add a document to the "Test" collection.
  Future<void> testFireStore() {
    return addDataCloudFirestore(path: "Test", mymap: {"name": "Moaz"});
  }

  /// Adds a document to a sub-collection of a Firestore collection.
  ///
  /// Parameters:
  /// - `collection`: The name of the collection.
  /// - `subCollection`: The name of the sub-collection.
  /// - `docId`: The ID of the parent document.
  /// - `id`: The ID of the document to be added (optional).
  /// - `mymap`: The data to be added.
  ///
  /// Returns the ID of the added document.
  Future<String> addDataCloudFirestoreSupCollection({
    required String collection,
    required String subCollection,
    required String docId,
    String? id,
    required Map<String, dynamic> mymap,
  }) async {
    if (id == null) {
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .collection(subCollection);
      await firebaseCollection.add(mymap).then((value) {
        this.firestoreDocmentid = value.id;
      });
    } else {
      firestoreDocmentid = id;
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(collection);
      await firebaseCollection.doc(id).set(mymap);
    }
    return firestoreDocmentid;
  }

  /// Adds a document to a Firestore collection.
  ///
  /// Parameters:
  /// - `path`: The path of the collection.
  /// - `id`: The ID of the document to be added (optional).
  /// - `mymap`: The data to be added.
  ///
  /// Returns the ID of the added document.
  Future<String> addDataCloudFirestore({
    required String path,
    String? id,
    required Map<String, dynamic> mymap,
  }) async {
    if (id == null || id == "") {
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(path);
      await firebaseCollection.add(mymap).then((value) {
        this.firestoreDocmentid = value.id;
      });
    } else {
      firestoreDocmentid = id;
      CollectionReference firebaseCollection;
      firebaseCollection = FirebaseFirestore.instance.collection(path);
      await firebaseCollection.doc(id).set(mymap);
    }
    return firestoreDocmentid;
  }
}
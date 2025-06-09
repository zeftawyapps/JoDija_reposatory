import 'dart:async';

import 'package:JoDija_reposatory/utilis/models/base_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A class that handles loading data from Firebase.
class FirebaseLoadingData {
  /// Instance of FirebaseFirestore to interact with the Firestore database.
  final _fireStore = FirebaseFirestore.instance;

  /// Returns a CollectionReference for the specified collection.
  ///
  /// [collection] - The name of the collection.
  CollectionReference getCollrection(String collection) {
    return _fireStore.collection(collection);
  }

  /// Loads data from the specified collection and returns it as a Future<QuerySnapshot>.
  ///
  /// [collection] - The name of the collection.
  Future<QuerySnapshot> loadDataAsFuture(String collection) async {
    CollectionReference firebaseCollection;
    firebaseCollection = _fireStore.collection(collection);
    return await firebaseCollection.get();
  }

  /// Loads all data from the specified path and returns it as a Future<T>.
  ///
  /// [path] - The path to the data.
  /// [builder] - The function to build the data.
  Future<T> loadAllData<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.get();
    return snapshots.then((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  /// Loads single data from the specified path and returns it as a Future<T>.
  ///
  /// [path] - The path to the data.
  /// [builder] - The function to build the data.
  Future<T> loadSingleData<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.get();
    return snapshots.then((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  /// Streams data with a query from the specified path and returns it as a Stream<List<T>>.
  ///
  /// [path] - The path to the data.
  /// [builder] - The function to build the data.
  /// [queryBuilder] - The function to build the query.
  /// [sort] - The function to sort the data.
  Stream<List<T>> StreamDataWithQuery<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async* {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    var snapshots = query.snapshots();
    snapshots.listen((snapshot) {
      var result = snapshot.docs
          .map(
            (snapshot) => builder(
              snapshot.data() as Map<String, dynamic>,
              snapshot.id,
            ),
          )
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
    });
  }

  /// Streams single data from the specified path and id and returns it as a Stream<T>.
  ///
  /// [path] - The path to the data.
  /// [id] - The id of the data.
  /// [builder] - The function to build the data.
  Stream<T> streamSingleData<T>({
    required String path,
    required String id,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.collection(path).doc(id);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  /// Loads data with a query from the specified path and returns it as a Future<List<T>>.
  ///
  /// [path] - The path to the data.
  /// [builder] - The function to build the data.
  /// [queryBuilder] - The function to build the query.
  /// [sort] - The function to sort the data.
  Future<List<T>> loadDataWithQuery<T extends BaseDataModel>({
    required String path,
    required T Function(Map<String, dynamic>? jsondata, String docId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.get();
    return snapshots.then((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
              snapshot.data() as Map<String, dynamic>,
              snapshot.id,
            ),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  /// Streams all data from the specified path and returns it as a Stream<List<T>>.
  ///
  /// [path] - The path to the data.
  /// [builder] - The function to build the data.
  Stream<List<T>>? streamAllData<T>({
    required String path,
    required T Function(Map<String, dynamic>? jsondata, String docId) builder,
  }) async* {
    yield* _fireStore.collection(path).snapshots().map((snamp) {
      return snamp.docs.map((d) {
        return builder(d.data(), d.id);
      }).toList();
    });
  }

  /// Streams snapshot from the specified path and returns it as a Stream.
  ///
  /// [path] - The path to the data.
  Stream streamSnapshot({
    required String path,
  }) {
    return _fireStore.collection(path).snapshots();
  }

  /// A list to store the data snapshot.
  List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];

  /// Converts the data snapshot to a list of maps.
  ///
  /// [snapshot] - The data snapshot.
  List<Map<String, dynamic>> getDataSnapshotToMap(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];
    QuerySnapshot qs = snapshot.data!;
    qs.docs.map((doc) {
      getlist.add(doc.data()! as Map<String, dynamic>);
    }).toList();

    return getlist;
  }

  /// Loads quiz data and returns it as a list of maps.
  ///
  /// [snapshot] - The data snapshot.
  /// [idcell] - The id of the cell.
  List<Map<String, dynamic>> getDataSnapshotOpjectToMap(QuerySnapshot snapshot,
      {String? idcell}) {
    List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];

    QuerySnapshot qs = snapshot;
    qs.docs.map((doc) {
      Map<String, dynamic> docmap = Map();
      docmap = doc.data()! as Map<String, dynamic>;
      if (idcell != null) {
        docmap.addAll({idcell: doc.id});
      }
      getlist.add(docmap);
    }).toList();

    return getlist;
  }

  /// Loads single document data from the specified collection and id and returns it as a Future<Map<String, dynamic>>.
  ///
  /// [collectin] - The name of the collection.
  /// [id] - The id of the document.
  Future<Map<String, dynamic>?> loadSingleDocData(
      String collectin, String id) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collectin);
    DocumentSnapshot doc = await firebaseCollection.doc(id).get();

    return doc.data() as Map<String, dynamic>;
  }
}

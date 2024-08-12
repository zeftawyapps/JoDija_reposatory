import 'dart:async';

import 'package:JoDija_DataSource/utilis/models/base_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseLoadingData {
  final _fireStore = FirebaseFirestore.instance;
  CollectionReference getCollrection(String collection) {
    return _fireStore.collection(collection);
  }

  Future<QuerySnapshot> loadDataAsFuture(String collection) async {
    CollectionReference firebaseCollection;
    firebaseCollection = _fireStore.collection(collection);
    return await firebaseCollection.get();
  }

  Future<T> loadAllData<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.get();
    return snapshots.then((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<T> loadSingleData<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.get();
    return snapshots.then((snapshot) => builder(snapshot.data(), snapshot.id));
  }

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

  Stream<T> streamSingleData<T>({
    required String path,
    required String id,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.collection(path).doc(id);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<List<T  >> loadDataWithQuery<T extends BaseDataModel>({
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

  Stream streamSnapshot({
    required String path,
  }) {
    return _fireStore.collection(path).snapshots();
  }

  List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> getDataSnapshotToMap(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];
    QuerySnapshot qs = snapshot.data!;
    qs.docs.map((doc) {
      getlist.add(doc.data()! as Map<String, dynamic>);
    }).toList();

    return getlist;
  }

  // load quiz data
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

  Future<Map<String, dynamic>?> loadSingleDocData(
      String collectin, String id) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collectin);
    DocumentSnapshot doc = await firebaseCollection.doc(id).get();

    return doc.data() as Map<String, dynamic>;
  }
}

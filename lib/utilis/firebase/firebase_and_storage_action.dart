import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'firestore_inputs.dart';
import 'storage.dart';

/// A class that handles Firestore and Storage actions.
class FirestoreAndStorageActions extends FireStoreAction with StorageActions {

  /// Edits data in Firestore and uploads a file to Storage if provided.
  ///
  /// [collection] - The Firestore collection.
  /// [id] - The document ID.
  /// [mymap] - The data to update.
  /// [file] - The file to upload (optional).
  /// [filedowloadurifieldname] - The field name for the file download URL (optional).
  Future<dynamic> editeDataCloudFirestorWithUpload({
    required String collection,
    required String id,
    required Map<String, dynamic> mymap,
    Object? file,
    String? filedowloadurifieldname = "imguri",
  }) async {
    var data = await editDataCloudFirestore(id: id, path: collection, mymap: mymap);

    if (file != null) {
      await uploadToStoreage(file);
      String download = await downloadURLStoreage();

      data = await editDataCloudFirestore(
          path: collection,
          id: id,
          mymap: {filedowloadurifieldname!: download});
    }
    return data;
  }

  /// Edits data in a Firestore subcollection and uploads a file to Storage if provided.
  ///
  /// [collection] - The Firestore collection.
  /// [docId] - The document ID.
  /// [subcollection] - The subcollection name.
  /// [id] - The subcollection document ID.
  /// [image] - The field name for the image URL (optional).
  /// [mymap] - The data to update.
  /// [file] - The file to upload (optional).
  Future<dynamic> editeDataCloudFirestorWithUploadSubCollection({
    required String collection,
    required String docId,
    required String subcollection,
    required String id,
    String? image = "imageUrl",
    required Map<String, dynamic> mymap,
    Object? file,
  }) async {
    var data = await editDataCloudFirestoreSubColletion(
        subCollection: subcollection,
        docId: docId,
        id: id,
        collection: collection,
        mymap: mymap);

    if (file != null) {
      await uploadToStoreage(file);
      String download = await downloadURLStoreage();

      data = await editDataCloudFirestoreSubColletion(
          subCollection: subcollection,
          docId: docId,
          collection: collection,
          id: id,
          mymap: {image!: download});
    }
    return data;
  }

  /// Adds data to Firestore and uploads a file to Storage if provided.
  ///
  /// [path] - The Firestore collection path.
  /// [id] - The document ID (optional).
  /// [mymap] - The data to add.
  /// [file] - The file to upload (optional).
  /// [dir] - The directory for the file (optional).
  /// [filedowloadurifieldname] - The field name for the file download URL (optional).
  Future<String> addDataCloudFirestorWithUpload({
    required String path,
    String? id,
    required Map<String, dynamic> mymap,
    Object? file,
    String dir = "",
    String? filedowloadurifieldname = "imguri",
  }) async {
    String iddoc = await addDataCloudFirestore(id: id, path: path, mymap: mymap);

    if (file != null) {
      await uploadToStoreage(file);
      String download = await downloadURLStoreage();
      String docId;
      if (id == null || id == "") {
        docId = iddoc;
      } else {
        docId = id;
      }
      editDataCloudFirestore(
          path: path,
          id: docId,
          mymap: {filedowloadurifieldname!: download});
    }
    return iddoc;
  }

  /// Adds data to a Firestore subcollection and uploads a file to Storage if provided.
  ///
  /// [collection] - The Firestore collection.
  /// [id] - The document ID (optional).
  /// [mymap] - The data to add.
  /// [file] - The file to upload (optional).
  /// [dir] - The directory for the file (optional).
  /// [subcollection] - The subcollection name.
  /// [docId] - The document ID of the parent collection.
  /// [imageField] - The field name for the image URL (optional).
  Future<String> addDataCloudFirestorWithUploadSubCollection({
    required String collection,
    String? id,
    required Map<String, dynamic> mymap,
    Object? file,
    String dir = "",
    required String subcollection,
    required String docId,
    String? imageField = "imguri",
  }) async {
    String iddoc = await addDataCloudFirestoreSupCollection(
        subCollection: subcollection,
        docId: docId,
        id: id,
        collection: collection,
        mymap: mymap);

    if (file != null) {
      await uploadToStoreage(file);
      String download = await downloadURLStoreage();

      editDataCloudFirestoreSubColletion(
          subCollection: subcollection,
          docId: docId,
          collection: collection,
          id: id ?? iddoc,
          mymap: {imageField!: download});
    }
    return iddoc;
  }

  /// Adds data to Firestore with multiple collection paths and uploads a file to Storage if provided.
  ///
  /// [pathes] - The Firestore collection paths.
  /// [id] - The document ID (optional).
  /// [mymap] - The data to add.
  /// [file] - The file to upload (optional).
  /// [dir] - The directory for the file (optional).
  /// [imageField] - The field name for the image URL (optional).
  Future<String> addDataCloudFirestorWithUploadCollectionPathes({
    required String pathes,
    String? id,
    required Map<String, dynamic> mymap,
    Object? file,
    String dir = "",
    String? imageField = "imguri",
  }) async {
    String iddoc = await addDataCloudFirestore(id: id, path: pathes, mymap: mymap);

    if (file != null) {
      await uploadToStoreage(file);
      String download = await downloadURLStoreage();

      editDataCloudFirestore(
          path: pathes, id: id ?? iddoc, mymap: {imageField!: download});
    }
    return iddoc;
  }

  /// Edits data in a Firestore subcollection, uploads a file to Storage if provided, and replaces the old file.
  ///
  /// [collection] - The Firestore collection.
  /// [dir] - The directory for the file (optional).
  /// [id] - The document ID.
  /// [subcollection] - The subcollection name.
  /// [docid] - The document ID of the parent collection.
  /// [mymap] - The data to update.
  /// [file] - The file to upload (optional).
  /// [iamgeField] - The field name for the image URL (optional).
  /// [oldurl] - The URL of the old file to delete (optional).
  Future<void> editeDataCloudFirestorWithUploadAndReplacementSubCollection({
    required String collection,
    String dir = "",
    required String id,
    required String subcollection,
    required String docid,
    required Map<String, dynamic> mymap,
    Object? file,
    String? iamgeField = "imguri",
    String? oldurl,
  }) {
    return editDataCloudFirestoreSubColletion(
            id: id,
            subCollection: subcollection,
            collection: collection,
            mymap: mymap,
            docId: docid)
        .then((value) {
      if (file != null) {
        if (oldurl != "") {
          deleteDataStoreagefromurl(url: oldurl!);
        }
        uploadToStoreage(file, dir: dir).then((value) {
          downloadURLStoreage().then((value) {
            editDataCloudFirestoreSubColletion(
                subCollection: subcollection,
                docId: docid,
                collection: collection,
                id: id,
                mymap: {iamgeField!: value});
          });
        });
      }
    });
  }

  /// Edits data in Firestore, uploads a file to Storage if provided, and replaces the old file.
  ///
  /// [path] - The Firestore collection path.
  /// [dir] - The directory for the file (optional).
  /// [id] - The document ID.
  /// [mymap] - The data to update.
  /// [file] - The file to upload (optional).
  /// [imageField] - The field name for the image URL (optional).
  /// [oldurl] - The URL of the old file to delete (optional).
  Future<void> editeDataCloudFirestorWithUploadAndReplacement({
    required String path,
    String dir = "",
    required String id,
    required Map<String, dynamic> mymap,
    Object? file,
    String? imageField = "imgur",
    String? oldurl,
  }) {
    String imgfield = imageField!;
    return editDataCloudFirestore(
      id: id,
      path: path,
      mymap: mymap,
    ).then((value) {
      if (file != null) {
        if (oldurl != "") {
          deleteDataStoreagefromurl(url: oldurl!);
        }
        uploadToStoreage(file, dir: dir).then((value) {
          downloadURLStoreage().then((value) {
            editDataCloudFirestore(
                path: path,
                id: id,
                mymap: {imgfield!: value});
          });
        });
      }
    });
  }

  /// Deletes data from Firestore and deletes the associated file from Storage if provided.
  ///
  /// [path] - The Firestore collection path.
  /// [id] - The document ID.
  /// [oldurl] - The URL of the old file to delete (optional).
  Future<void> deleteDataCloudFirestorWithdeletFile({
    required String path,
    required String id,
    String? oldurl,
  }) async {
    return await deleteDataCloudFirestoreOneDocument(
      id: id,
      path: path,
    ).then((value) async {
      if (oldurl != "") {
        await deleteDataStoreagefromurl(url: oldurl!);
      }
    });
  }
}
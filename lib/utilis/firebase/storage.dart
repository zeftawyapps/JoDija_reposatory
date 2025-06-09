import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_auth/firebase_auth.dart';

/// A mixin that provides various storage actions such as uploading, downloading, and deleting files.
mixin StorageActions {
  String dawenlaodUri = "";
  String _filename = '';
  String _directory = '';
  String filepath = '';

  /// Uploads a file to Firebase Storage.
  ///
  /// Parameters:
  /// - `file`: The file to be uploaded. Can be of type `File` or `Uint8List`.
  /// - `dir`: The directory where the file will be stored (optional).
  /// - `filename`: The name of the file (optional).
  /// - `extention`: The extension of the file (optional).
  Future uploadToStoreage(Object file, {String? dir, String? filename, String? extention}) async {
    if (file is File) {
      return await uploadFileStoreage(file, dir: dir, filename: filename);
    } else if (file is Uint8List) {
      return await uploadBytesDataStoreage(file, dir: dir, extntion: extention ?? "png");
    }
  }

  /// Uploads a `File` to Firebase Storage.
  ///
  /// Parameters:
  /// - `file`: The file to be uploaded.
  /// - `dir`: The directory where the file will be stored (optional).
  /// - `filename`: The name of the file (optional).
  Future uploadFileStoreage(File file, {String? dir, String? filename}) async {
    if (dir == null) {
      dir = 'Z_Apps';
    } else {
      _directory = dir;
    }
    if (filename == null) {
      filename = DateTime.now().millisecondsSinceEpoch.toString();
      _filename = filename;
    } else {
      _filename = filename;
    }

    String name = file.path.split("/").last;
    String extantion = name.split('.').last;
    _filename = '$_filename.$extantion';
    filepath = '$_directory/$_filename';
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('$filepath')
          .putData(await file.readAsBytes());
    } on FirebaseException catch (e) {
      e.code;
    }
  }

  /// Uploads a `Uint8List` to Firebase Storage.
  ///
  /// Parameters:
  /// - `file`: The file to be uploaded.
  /// - `dir`: The directory where the file will be stored (optional).
  /// - `extntion`: The extension of the file.
  Future uploadBytesDataStoreage(Uint8List file, {String? dir, required String extntion}) async {
    if (dir == null) {
      dir = 'Z_Apps';
    } else {
      _directory = dir;
    }

    String fileRename = DateTime.now().millisecondsSinceEpoch.toString();
    _filename = fileRename;

    _filename = '$_filename.$extntion';
    filepath = '$_directory/$_filename';
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('$filepath')
          .putData(await file);
    } on FirebaseException catch (e) {
      e.code;
    }
  }

  /// Deletes a file from Firebase Storage.
  ///
  /// Parameters:
  /// - `dir`: The directory where the file is stored (optional).
  /// - `filename`: The name of the file to be deleted.
  Future deleteDataStoreage({String? dir, required String filename}) async {
    if (dir == null) {
      dir = 'Z_Apps';
    } else {
      _directory = dir;
    }

    _filename = filename;

    _filename = '$_filename';
    filepath = '$_directory/$_filename';
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('$filepath')
          .delete();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  /// Deletes a file from Firebase Storage using its URL.
  ///
  /// Parameters:
  /// - `url`: The URL of the file to be deleted.
  Future deleteDataStoreagefromurl({required String url}) async {
    try {
      return await firebase_storage.FirebaseStorage.instance
          .refFromURL(url)
          .delete();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  /// Retrieves the download URL of a file from Firebase Storage.
  ///
  /// Returns the download URL as a `String`.
  Future<String> downloadURLStoreage() async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .getDownloadURL();
  }
}
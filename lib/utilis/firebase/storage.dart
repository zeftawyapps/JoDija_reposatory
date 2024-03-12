import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_auth/firebase_auth.dart';

 mixin StorageActions{
  String dawenlaodUri = "";
  String _filename = '';
  String _directory = '';
  String filepath = '';

  Future uploadToStoreage(Object file, {String? dir, String? filename , String? extention  }) async {
    if (file is File) {
      return await uploadFileStoreage(file, dir: dir, filename: filename);
    } else if (file is Uint8List) {
      return await uploadBytesDataStoreage(file, dir: dir, extntion: extention??"png");
    }
  }

  Future uploadFileStoreage(File file, {String? dir, String? filename}) async {
    if (dir == null) {
      dir = 'Z_Apps';
    } else {
      _directory = dir;
    }
    if (filename == null) {
      filename = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      _filename = filename;
    } else {
      _filename = filename;
    }

    String name = file.path
        .split("/")
        .last;
    String extantion = name
        .split('.')
        .last;
    _filename = '$_filename.$extantion';
    filepath = '$_directory/$_filename';
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('$filepath')
          .putData(await  file.readAsBytes());
    } on FirebaseException catch (e) {
       e.code ;
    }
  }

  Future uploadBytesDataStoreage(Uint8List file, {String? dir, required String extntion
  }) async {
    if (dir == null) {
      dir = 'Z_Apps';
    } else {
      _directory = dir;
    }

    String   fileRename = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      _filename = fileRename;



    _filename = '$_filename.$extntion';
    filepath = '$_directory/$_filename';
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('$filepath')
          .putData(await  file );
    } on FirebaseException catch (e) {
      e.code ;
    }
  }


  Future deleteDataStoreage({String? dir, required String filename}) async {
    if (dir == null) {
      dir = 'Z_Apps';
    } else {
      _directory = dir;
    }

    _filename = filename;


    // String name = file.path.split("/").last;
    // String extantion = name.split('.').last;
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

  Future deleteDataStoreagefromurl({required String url }) async {
    try {
      return await firebase_storage.FirebaseStorage.instance
          .refFromURL(url)
          .delete();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
  Future<String> downloadURLStoreage() async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .getDownloadURL();
  }

}
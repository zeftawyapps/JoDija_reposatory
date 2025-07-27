import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';

import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/sources/i_json_base_source.dart';
import '../../utilis/firebase/firebase.dart';
import '../../utilis/firebase/firebase_and_storage_action.dart';
import '../../utilis/models/base_data_model.dart';

/// A data source implementation for Firebase that handles CRUD operations.
///
/// This class provides methods to add, delete, edit, and retrieve data from
/// Firebase Firestore. It also supports uploading files to Firebase Storage
/// and handling image fields.
///
/// Type parameter [T] must extend [BaseEntityDataModel].
class DataSourceFirebaseSource<T extends BaseEntityDataModel>
    implements IBaseDataActionsSource<BaseEntityDataModel> {
  late FirestoreAndStorageActions _fireStoreAction;
  late FirebaseLoadingData _firebaseLoadingData;
  BaseEntityDataModel? _data;
  Object? _file;
  String _path = "";
  String? deleteUrl = "";
  String? imageField = "image";
  Query Function(Query query)? _query;
  T Function(Map<String, dynamic>? jsondata, String docId)? dataBuilder;

  /// Creates a new instance of [DataSourceFirebaseSource].
  ///
  /// The [path] parameter specifies the Firestore collection path.
  /// The [query] parameter is an optional function to modify the Firestore query.
  DataSourceFirebaseSource(String path, {Query Function(Query query)? query}) {
    _fireStoreAction = FirestoreAndStorageActions();
    _firebaseLoadingData = FirebaseLoadingData();
    _path = path;
    _query = query;
  }

  /// Factory constructor for getting data from Firebase.
  ///
  /// The [path] parameter specifies the Firestore collection path.
  /// The [query] parameter is an optional function to modify the Firestore query.
  /// The [builder] parameter is a function to build the data model from JSON.
  factory DataSourceFirebaseSource.get({
    required String path,
    Query Function(Query query)? query,
    required T Function(Map<String, dynamic>? jsondata, String docId) builder,
  }) {
    return DataSourceFirebaseSource(path, query: query)..dataBuilder = builder;
  }

  /// Factory constructor for inserting data into Firebase.
  ///
  /// The [dataModel] parameter specifies the data model to insert.
  /// The [path] parameter specifies the Firestore collection path.
  /// The [file] parameter is an optional file to upload.
  /// The [imageField] parameter specifies the field name for the image.
  factory DataSourceFirebaseSource.insert({
    required BaseEntityDataModel dataModel,
    required String path,
    Object? file,
    String? imageField = "image",
  }) {
    return DataSourceFirebaseSource(path)
      .._data = dataModel
      .._file = file
      ..imageField = imageField!;
  }

  /// Factory constructor for editing data in Firebase.
  ///
  /// The [dataModel] parameter specifies the data model to edit.
  /// The [path] parameter specifies the Firestore collection path.
  /// The [file] parameter is an optional file to upload.
  /// The [oldImg] parameter specifies the old image URL to delete.
  /// The [imageField] parameter specifies the field name for the image.
  factory DataSourceFirebaseSource.edit({
    required BaseEntityDataModel dataModel,
    required String path,
    Object? file,
    String? oldImg = "",
    String? imageField = "image",
  }) {
    return DataSourceFirebaseSource(path)
      .._data = dataModel
      .._file = file
      ..imageField = imageField!
      ..deleteUrl = oldImg!;
  }

  /// Factory constructor for deleting data from Firebase.
  ///
  /// The [path] parameter specifies the Firestore collection path.
  /// The [oldImg] parameter specifies the old image URL to delete.
  factory DataSourceFirebaseSource.delete({
    required String path,
    String? oldImg,
  }) {
    return DataSourceFirebaseSource(path)..deleteUrl = oldImg ?? "";
  }

  /// Adds a data item to Firebase.
  ///
  /// If `_data` is null, returns an error result.
  /// If `_file` is not null, uploads the file and adds the data to Firestore.
  /// Otherwise, adds the data directly to Firestore.
  ///
  /// Returns a `Result` containing the added data or an error.
  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>> addDataItem() async {
    try {
      if (_data == null) {
        return Result.error(RemoteBaseModel(message: "data is null"));
      }

      if (_file != null) {
        var result = await _fireStoreAction
            .addDataCloudFirestorWithUploadCollectionPathes(
                pathes: _path,
                mymap: _data!.toJson(),
                file: _file,
                imageField: imageField!);
        return Result.data(RemoteBaseModel(data: result));
      } else {
        var result = await _fireStoreAction.addDataCloudFirestore(
            path: _path, mymap: _data!.toJson());
        return Result.data(RemoteBaseModel(data: result));
      }
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Deletes a data item from Firebase.
  ///
  /// Deletes the data item with the specified `id` from Firestore.
  /// If `deleteUrl` is not null, deletes the associated file.
  ///
  /// Returns a `Result` indicating success or an error.
  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(
      String id) async {
    try {
      await _fireStoreAction.deleteDataCloudFirestorWithdeletFile(
          path: _path, id: id, oldurl: deleteUrl);
      return Result.data(RemoteBaseModel(data: "done"));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Edits a data item in Firebase.
  ///
  /// If `_data` is null, returns an error result.
  /// If `_file` is not null, uploads the file and updates the data in Firestore.
  /// Otherwise, updates the data directly in Firestore.
  ///
  /// Returns a `Result` indicating success or an error.
  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>> editeDataItem(
      String id) async {
    try {
      if (_data == null) {
        return Result.error(RemoteBaseModel(message: "data is null"));
      }
      if (_file == null) {
        await _fireStoreAction.editDataCloudFirestore(
            path: _path, id: id, mymap: _data!.toJson());
      } else {
        await _fireStoreAction.editeDataCloudFirestorWithUploadAndReplacement(
            path: _path,
            id: id,
            mymap: _data!.toJson(),
            file: _file,
            oldurl: deleteUrl,
            imageField: imageField!);
      }

      return Result.data(RemoteBaseModel(data: "done"));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Retrieves a list of data items from Firebase.
  ///
  /// Uses the optional `dataBuilder` to build the data model from JSON.
  /// If `dataBuilder` is not provided, uses a default builder.
  ///
  /// Returns a `Result` containing the list of data items or an error.
  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>>
      getDataList() async {
    try {
      this.dataBuilder ??=
          (data, documentId) => BaseEntityDataModel.fromJson(data!, documentId) as T;
      var product = await _firebaseLoadingData.loadDataWithQuery<T>(
          queryBuilder: _query, path: _path, builder: this.dataBuilder!);
      return Result.data(RemoteBaseModel(data: product as List<T>));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Retrieves a single data item from Firebase.
  ///
  /// Uses the optional `dataBuilder` to build the data model from JSON.
  /// If `dataBuilder` is not provided, uses a default builder.
  ///
  /// Returns a `Result` containing the data item or an error.
  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(
      String id) async {
    try {
      var buid = this.dataBuilder ??
          (data, documentId) => BaseEntityDataModel.fromJson(data!, documentId) as T;

      var data = await _firebaseLoadingData.loadSingleDocData(_path, id);

      return Result.data(RemoteBaseModel(data: buid(data, id)));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }
}

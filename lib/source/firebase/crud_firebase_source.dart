

import 'package:JoDija_DataSource/utilis/models/remote_base_model.dart';

import 'package:JoDija_DataSource/utilis/result/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/sources/i_json_base_source.dart';
import '../../utilis/firebase/firebase.dart';
import '../../utilis/firebase/firebase_and_storage_action.dart';
import '../../utilis/models/base_data_model.dart';

class DataSourceFirebaseSource<T extends  BaseDataModel >
    implements IBaseDataActionsSource<BaseDataModel> {
  late FirestoreAndStorageActions _fireStoreAction;
  late FirebaseLoadingData _firebaseLoadingData;
  BaseDataModel? _data;
  Object? _file;
  String _path = "";
  String? deleteUrl = "";
  String? imageField = "image";
  Query Function(Query query)? _query;
 T Function(Map<String, dynamic>? jsondata, String docId)? dataBuilder

  ;


      DataSourceFirebaseSource(String path , { Query Function(Query query)? query}) {
    _fireStoreAction = FirestoreAndStorageActions();
    _firebaseLoadingData = FirebaseLoadingData();
    _path = path;
    _query = query;
  }

  factory DataSourceFirebaseSource.get(
      {required String path, Query Function(Query query)? query
      , required T Function(Map<String, dynamic>? jsondata, String docId) builder
      }) {
    return DataSourceFirebaseSource(path , query: query)
      ..dataBuilder = builder ;
  }

  factory DataSourceFirebaseSource.insert(
      {required BaseDataModel dataModel, required String path, Object? file
      , String? imageField = "image"
      }) {
    return DataSourceFirebaseSource(path).._data = dataModel
    .._file = file
    ..imageField = imageField!
    ;}

  factory DataSourceFirebaseSource.edit(
      {required BaseDataModel dataModel, required String path, Object? file , String? oldImg=""
      , String? imageField = "image"
      }) {
    return DataSourceFirebaseSource(path).._data = dataModel
      .._file = file
      ..imageField = imageField!
    ..deleteUrl = oldImg!
    ;}


  factory DataSourceFirebaseSource.delete(
      {  required String path,  String? oldImg}) {
    return DataSourceFirebaseSource(path)..deleteUrl = oldImg??"";}
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
                imageField:  imageField!);
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

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(
      String id ) async {
    try {
      await _fireStoreAction.deleteDataCloudFirestorWithdeletFile(

          path: _path, id: id ,oldurl : deleteUrl );
      return Result.data(RemoteBaseModel(data: "done"));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

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
            path: _path, id: id, mymap: _data!.toJson()
            , file: _file
            , oldurl: deleteUrl
          , imageField: imageField! ) ;
      }


             return Result.data(RemoteBaseModel(data: "done"));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>>
      getDataList() async {
    try {
this.dataBuilder ??= (data, documentId) => BaseDataModel.fromJson(data!, documentId) as T;
      var product = await _firebaseLoadingData.loadDataWithQuery<T>(
          queryBuilder: _query ,
          path: _path, builder:this.dataBuilder!);
      return Result.data(RemoteBaseModel(data: product as List<T>));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(
      String id) async {
    try {
   var buid =    this.dataBuilder ??  (data, documentId) => BaseDataModel.fromJson(data!, documentId) as T;


      var data = await _firebaseLoadingData.loadSingleDocData(_path, id);

      return Result.data(RemoteBaseModel(data:  buid(data, id) ));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }
}



import 'package:JoDija_DataSource/utilis/models/remote_base_model.dart';

import 'package:JoDija_DataSource/utilis/result/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/sources/i_json_base_source.dart';
import '../../utilis/firebase/firebase.dart';
import '../../utilis/firebase/firebase_and_storage_action.dart';
import '../../utilis/models/base_data_model.dart';

class DataSourceCRUDFirebaseSource
    implements IResultBaseCRUDSource<BaseDataModel> {
  late FirestoreAndStorageActions _fireStoreAction;
  late FirebaseLoadingData _firebaseLoadingData;
  BaseDataModel? _data;
  Object? _file;
  String _path = "";
  String? deleteUrl = "";
  String? imageField = "image";
  Query Function(Query query)? _query;


  DataSourceCRUDFirebaseSource(String path , { Query Function(Query query)? query}) {
    _fireStoreAction = FirestoreAndStorageActions();
    _firebaseLoadingData = FirebaseLoadingData();
    _path = path;
    _query = query;
  }
  factory DataSourceCRUDFirebaseSource.insert(
      {required BaseDataModel dataModel, required String path, Object? file
      , String? imageField = "image"
      }) {
    return DataSourceCRUDFirebaseSource(path).._data = dataModel
    .._file = file
    ..imageField = imageField!
    ;}

  factory DataSourceCRUDFirebaseSource.edit(
      {required BaseDataModel dataModel, required String path, Object? file , String? oldImg=""
      , String? imageField = "image"
      }) {
    return DataSourceCRUDFirebaseSource(path).._data = dataModel
      .._file = file
      ..imageField = imageField!
    ..deleteUrl = oldImg!
    ;}


  factory DataSourceCRUDFirebaseSource.delete(
      {  required String path,  String? oldImg}) {
    return DataSourceCRUDFirebaseSource(path)..deleteUrl = oldImg??"";}
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
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<BaseDataModel>>>>
      getDataList() async {
    try {
      var product = await _firebaseLoadingData.loadDataWithQuery(
          queryBuilder: _query ,
          path: _path, builder: (data, id) => BaseDataModel.fromJson(data! , id ));
      return Result.data(RemoteBaseModel(data: product));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<BaseDataModel>>> getSingleData(
      String id) async {
    try {
      var data = await _firebaseLoadingData.loadSingleDocData(_path, id);

      return Result.data(RemoteBaseModel(data: BaseDataModel.fromJson(data!, id )));
    } on Exception catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }
}

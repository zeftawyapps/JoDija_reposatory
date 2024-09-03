import '../interface/sources/i_json_base_source.dart';
import '../utilis/models/base_data_model.dart';
import '../utilis/models/remote_base_model.dart';
import '../utilis/models/staus_model.dart';
import '../utilis/result/result.dart';

class DataSourceRepo<T extends BaseDataModel> {
  IBaseDataActionsSource<T>? _inputSource;
  DataSourceRepo({ required  IBaseDataActionsSource<T>    inputSource}) {
    _inputSource = inputSource;
  }
  Future<Result<RemoteBaseModel, RemoteBaseModel>> addData() async {
    try {
      var result = await _inputSource!.addDataItem();
      return Result.data(result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> deleteData(String id) async {
    try {
      var result = await _inputSource!.deleteDataItem(id);

      return Result.data(result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getListData() async {
    var result = await _inputSource!.getDataList( );

    return Result<RemoteBaseModel, RemoteBaseModel<List<T>>>(
        data:  result.data  , error: result.error);
  }

  Future<Result<RemoteBaseModel, RemoteBaseModel<BaseDataModel>>> getSingleData(
      String id) async {
    try {
      var result = await _inputSource!.getSingleData(id)  ;
      return Result(data: result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  Future<Result<RemoteBaseModel, RemoteBaseModel>> updateData(String id) async {
    try {
      var result = await _inputSource!.editeDataItem(
        id,
      );

      return Result.data(result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }
}

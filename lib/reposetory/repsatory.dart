import '../interface/sources/i_json_base_source.dart';
import '../utilis/models/base_data_model.dart';
import '../utilis/models/remote_base_model.dart';
import '../utilis/models/staus_model.dart';
import '../utilis/result/result.dart';

/// A repository class for managing data sources.
///
/// This class provides methods to add, delete, retrieve, and update data
/// using the provided data actions source interface.
class DataSourceRepo<T extends BaseEntityDataModel> {
  IBaseDataActionsSource<T>? _inputSource;

  /// Constructs a `DataSourceRepo` instance.
  ///
  /// \param inputSource The data actions source interface.
  DataSourceRepo({required IBaseDataActionsSource<T> inputSource}) {
    _inputSource = inputSource;
  }

  /// Adds a data item.
  ///
  ///  \param id An optional identifier for the data item. If provided, it will be used
  /// \returns A `Result` containing either a `RemoteBaseModel` or an error message.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> addData({String? id}) async {
    try {
      var result = await _inputSource!.addDataItem(id: id);
      return Result.data(result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Deletes a data item by ID.
  ///
  /// \param id The ID of the data item to delete.
  /// \returns A `Result` containing either a `RemoteBaseModel` or an error message.
  Future<Result<RemoteBaseModel, dynamic>> deleteData(String id) async {
    try {
      var result = await _inputSource!.deleteDataItem(id);
      return Result.data(result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Retrieves a list of data items.
  ///
  /// \returns A `Result` containing either a `RemoteBaseModel` with a list of data items or an error message.
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>>
      getListData() async {
    try {
      var result = await _inputSource!.getDataList();
      return Result<RemoteBaseModel, RemoteBaseModel<List<T>>>(
          data: result.data, error: result.error);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Retrieves a single data item by ID.
  ///
  /// \param id The ID of the data item to retrieve.
  /// \returns A `Result` containing either a `RemoteBaseModel` with the data item or an error message.
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(
      String id) async {
    try {
      var result = await _inputSource!.getSingleData(id);
      return Result(data: result.data, error: result.error);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Updates a data item by ID.
  ///
  /// \param id The ID of the data item to update.
  /// \returns A `Result` containing either a `RemoteBaseModel` or an error message.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> updateData(String id) async {
    try {
      var result = await _inputSource!.editeDataItem(id);
      return Result.data(result.data);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }
}

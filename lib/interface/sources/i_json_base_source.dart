import '../../utilis/models/base_data_model.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';

/// An abstract class that defines standard CRUD actions for data sources.
///
/// The type parameter `T` represents the type of data item this source manages.
abstract class IBaseDataActionsSource<T extends BaseEntityDataModel> {
  /// Adds a new data item.
  ///
  /// [id] is an optional identifier for the data item.
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> addDataItem({String? id});

  /// Edits an existing data item identified by [id].
  ///
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> editeDataItem(String id);

  /// Deletes a data item identified by [id].
  ///
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(String id);

  /// Retrieves a list of data items.
  ///
  /// Returns a [Future] with a [Result] containing a list of [T] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getDataList();

  /// Retrieves a single data item identified by [id].
  ///
  /// Returns a [Future] with a [Result] containing the item [T] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(String id);
}

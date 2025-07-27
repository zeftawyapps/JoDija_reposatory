

import '../../utilis/models/base_data_model.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';

/// An abstract class that defines the actions for data sources.
///
/// This class provides methods to perform CRUD operations on data items.
/// The type parameter `T` represents the type of data items.
abstract class IBaseDataActionsSource<T extends BaseEntityDataModel> {
  /// Adds a data item.
  ///
  /// \returns A `Future` that completes with a `Result` containing either
  /// a `RemoteBaseModel` on success or another `RemoteBaseModel` on error.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> addDataItem();

  /// Edits a data item identified by the given `id`.
  ///
  /// \param id The identifier of the data item to edit.
  /// \returns A `Future` that completes with a `Result` containing either
  /// a `RemoteBaseModel` on success or another `RemoteBaseModel` on error.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> editeDataItem(String id);

  /// Deletes a data item identified by the given `id`.
  ///
  /// \param id The identifier of the data item to delete.
  /// \returns A `Future` that completes with a `Result` containing either
  /// a `RemoteBaseModel` on success or another `RemoteBaseModel` on error.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(String id);

  /// Retrieves a list of data items.
  ///
  /// \returns A `Future` that completes with a `Result` containing either
  /// a `RemoteBaseModel` with a list of data items on success or another
  /// `RemoteBaseModel` on error.
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getDataList();

  /// Retrieves a single data item identified by the given `id`.
  ///
  /// \param id The identifier of the data item to retrieve.
  /// \returns A `Future` that completes with a `Result` containing either
  /// a `RemoteBaseModel` with the data item on success or another
  /// `RemoteBaseModel` on error.
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(String id);
}

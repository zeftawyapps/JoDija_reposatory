import 'package:jodija_repository/utilis/models/base_data_model.dart';
import 'package:jodija_repository/utilis/result/result_data_indecator.dart';
import '../../utilis/models/remote_base_model.dart';

/// An abstract repository class for data source operations.
///
/// This class defines the basic CRUD operations for a data source
/// and provides a helper for result data handling. The type parameter
/// `T` represents the type of data model.
///
/// Type parameter `T` represents the data model extending `BaseEntityDataModel`.
abstract class IBaseDataSourceRepo<T extends BaseEntityDataModel> {

  /// Adds data to the data source.
  ///
  /// \returns A `Future` that completes with a `RemoteBaseModel`.
  Future<RemoteBaseModel> addData();

  /// Deletes data from the data source by ID.
  ///
  /// \param id The ID of the data to delete.
  /// \returns A `Future` that completes with a `RemoteBaseModel`.
  Future<RemoteBaseModel> deleteData(String id);

  /// Retrieves a list of data items from the data source.
  ///
  /// \returns A `Future` that completes with a `RemoteBaseModel` containing a list of data items.
  Future<RemoteBaseModel<List<T>>> getListData();

  /// Retrieves a single data item from the data source by ID.
  ///
  /// \param id The ID of the data to retrieve.
  /// \returns A `Future` that completes with a `RemoteBaseModel` containing the data item.
  Future<RemoteBaseModel<T>> getSingleData(String? id);

  /// Updates data in the data source by ID.
  ///
  /// \param id The ID of the data to update.
  /// \returns A `Future` that completes with a `RemoteBaseModel`.
  Future<RemoteBaseModel> updateData(String id);

  /// Gets the result data helper.
  ///
  /// \returns The `ResultDataHelper` instance.
  ResultDataHelper get resultDataHelper;
}

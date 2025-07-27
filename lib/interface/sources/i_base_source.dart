import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utilis/models/base_data_model.dart';



/// An abstract class that defines the basic operations for a data source.
///
/// This class provides methods for adding, updating, deleting, and retrieving data items.
/// The type parameter `T` must extend `BaseDataModel`.
abstract class IBaseSource<T extends BaseEntityDataModel> {
  /// The data item of type `T`.
  T? data;

  /// Adds a data item.
  Future addDataItem();

  /// Updates a data item identified by the given `id`.
  ///
  /// \param [id] The identifier of the data item to update.
  Future updateDataItem(String id);

  /// Deletes a data item identified by the given `id`.
  ///
  /// \param [id] The identifier of the data item to delete.
  Future deleteDataItem(String id);

  /// Retrieves a list of all data items.
  ///
  /// \returns A `Future` that completes with a list of data items of type `T`.
  Future<List<T>> getAllDataList();

  /// Retrieves a data item identified by the given `id`.
  ///
  /// \param [id] The identifier of the data item to retrieve.
  /// \returns A `Future` that completes with the data item of type `T`.
  Future<T> getDataItem(String id);

  /// Retrieves a list of data items based on the given query.
  ///
  /// \param query A function that modifies the query used to retrieve the data items.
  /// \returns A `Future` that completes with a list of data items of type `T`.
  Future<List<T>> getData(Query Function(Query query)? query);
}

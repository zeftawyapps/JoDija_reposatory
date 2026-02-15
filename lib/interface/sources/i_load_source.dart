import '../../utilis/models/base_data_model.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';

/// An abstract class defining data loading actions for data sources.
///
/// This interface focuses only on retrieving data, either as a list or a single item.
abstract class IBaseLoadSource<T extends BaseEntityDataModel> {
  /// Retrieves a list of data items.
  ///
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] with a list of [T] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getDataList();

  /// Retrieves a single data item.
  ///
  /// [id] is an optional identifier for the data item.
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] with the item [T] on success.
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(
      {String? id});
}

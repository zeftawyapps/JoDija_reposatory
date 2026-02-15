import '../interface/sources/i_load_source.dart';
import '../utilis/models/base_data_model.dart';
import '../utilis/models/remote_base_model.dart';
import '../utilis/models/staus_model.dart';
import '../utilis/result/result.dart';

/// A repository class designed exclusively for data loading operations.
///
/// This repository acts as a wrapper around an [IBaseLoadSource] to provide
/// a clean API for fetching lists and single items of data.
class LoadDataRepo<T extends BaseEntityDataModel> {
  IBaseLoadSource<T>? _loadSource;

  /// Constructs a [LoadDataRepo] with a specific data load source.
  ///
  /// \param loadSource The source implementation used to fetch data.
  LoadDataRepo({required IBaseLoadSource<T> loadSource}) {
    _loadSource = loadSource;
  }

  /// Fetches a list of data items from the source.
  ///
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] with a list of [T].
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>>
      getListData() async {
    try {
      return await _loadSource!.getDataList();
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }

  /// Fetches a single data item from the source.
  ///
  /// [id] optionally overrides the identifier configured in the source.
  /// Returns a [Future] with a [Result] containing a [RemoteBaseModel] with the item [T].
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(
      {String? id}) async {
    try {
      return await _loadSource!.getSingleData(id: id);
    } catch (e) {
      return Result.error(
          RemoteBaseModel(message: e.toString(), status: StatusModel.error));
    }
  }
}

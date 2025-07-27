import 'package:JoDija_reposatory/utilis/result/result.dart';

import '../models/base_data_model.dart';
import '../models/remote_base_model.dart';
import '../models/staus_model.dart';

/// this class is a helper class to help in the process of getting data from the result object
///
class ResultDataHelper<T extends BaseEntityDataModel> {
  /// Retrieves a list of data from a `RemoteBaseModel` result object.
  ///
  /// This method processes the result object to extract a list of data items of type `T`.
  /// It uses a builder function to convert each item in the list to the desired type `T`.
  ///
  /// Throws a `RemoteBaseModel` with an error status if the result contains an error.
  ///
  /// \param result The `RemoteBaseModel` result object containing the data.
  /// \param builder A function that converts a `BaseDataModel` item to type `T`.
  /// \returns A `RemoteBaseModel` containing a list of data items of type `T` and a success status.

  RemoteBaseModel getResulInput(Result result) {
    if (result.error == null) {
      return RemoteBaseModel(data: result.data, status: StatusModel.success);
    } else {
      throw RemoteBaseModel(
          error: result.error,
          message: result.error!.message,
          status: StatusModel.error);
    }
  }

  /// Retrieves a list of data from a `RemoteBaseModel` result object.
  ///
  /// This method processes the result object to extract a list of data items of type `T`.
  /// It uses a builder function to convert each item in the list to the desired type `T`.
  ///
  /// Throws a `RemoteBaseModel` with an error status if the result contains an error.
  ///
  /// \param result The `RemoteBaseModel` result object containing the data.
  /// \param builder A function that converts a `BaseDataModel` item to type `T`.
  /// \returns A `RemoteBaseModel` containing a list of data items of type `T` and a success status.
  RemoteBaseModel<List<T>> getResultOfListData(
      RemoteBaseModel result,
      T? Function(
        BaseEntityDataModel? data,
      ) builder) {
    if (result.error == null) {
      List<BaseEntityDataModel> listData = result.data as List<BaseEntityDataModel>;

      List<T> list = [];
      for (var item in listData) {
        T data = builder(item) as T;
        list.add(data);
      }
      return RemoteBaseModel(data: list, status: StatusModel.success);
    } else {
      throw RemoteBaseModel(
          error: result.error,
          message: result.message,
          status: StatusModel.error);
    }
  }

  /// Retrieves a single data item from a `Result` object.
  ///
  /// This method processes the `Result` object to extract a single data item of type `T`.
  /// It uses a builder function to convert the data map to the desired type `T`.
  ///
  /// Throws a `RemoteBaseModel` with an error status if the result contains an error.
  ///
  /// \param result The `Result` object containing the data.
  /// \param builder A function that converts a `Map<String, dynamic>` item to type `T`.
  /// \returns A `RemoteBaseModel` containing a data item of type `T` and a success status.

  RemoteBaseModel<T> getResultOfData(
      Result result,
      T? Function(
        Map<String, dynamic>? data,
      ) builder) {
    if (result.error == null) {
      BaseEntityDataModel resultData = result.data as BaseEntityDataModel;
      T getedData = builder(resultData.map) as T;
      return RemoteBaseModel(data: getedData, status: StatusModel.success);
    } else {
      throw RemoteBaseModel(
          error: result.error,
          message: result.error!.message,
          status: StatusModel.error);
    }
  }
}

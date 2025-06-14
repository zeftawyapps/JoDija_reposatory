
import '../models/remote_base_model.dart';

class Result<Error extends RemoteBaseModel, Data> {
  final Data? data;
  final Error? error;

 //*
  // *  Result class is a generic class that is used to return data from the response of the repository
  // *  It is used to return data from the repository to the view model
  // [data] is the data that is returned from the repository
  // [error] is the error that is returned from the repository

  // *//

  Result({this.data, this.error}) : assert(data != null || error != null);

  /// checks whether data is available
  bool get hasDataOnly => data != null && error == null;

  /// checks whether an error is present
  bool get hasErrorOnly => data == null && error != null;

  /// checks whether data and error is present
  /// error from network data source and data from cache data source
  bool get hasDataAndError => data != null && error != null;

  /// returns the error
  factory Result.error(Error error) {
    return Result(
      error: error,
      data: null,
    );
  }

  /// returns just data
  factory Result.data( Data? data ) {
    return Result(
      error: null,
      data: data,
    );
  }



  /// Cherry pick values
  ///
  /// onError will return error, if present
  /// onNoError will return data if error is not present
  /// onData will return data if data is available
  /// onDataWithError will return data if error is present and data is available
  ///
  void pick<T>({
    T Function(Error error)? onError,
   T Function(Data data)? onData,
   T Function(Data data, Error error)? onErrorWithData,
  }) {
    if (hasErrorOnly) {
      if (onError != null) {
       onError(error!);
      }
    }

    else if (hasDataOnly) {
      if (onData != null) {
        onData(data!);
      }
    }

    else if (onErrorWithData != null) {
      onErrorWithData(data!, error!);
    }

  }
}
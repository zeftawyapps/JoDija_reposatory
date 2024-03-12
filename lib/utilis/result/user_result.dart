
import '../models/remote_base_model.dart';

class UserResult<Error extends RemoteBaseModel, Data> {
  final Data? data;
  final Error? error;

  UserResult({this.data, this.error}) : assert(data != null || error != null);

  /// checks whether data is available
  bool get hasDataOnly => data != null && error == null;

  /// checks whether an error is present
  bool get hasErrorOnly => data == null && error != null;

  /// checks whether data and error is present
  /// error from network data source and data from cache data source
  bool get hasDataAndError => data != null && error != null;

  /// returns the error
  factory UserResult.error(Error error) {
    return UserResult(
      error: error,

    );
  }

  /// returns just data
  factory UserResult.data( Data? data ) {
    return UserResult(
      error: null,
      data: data,
    );
  }

  /// returns error and data
  factory UserResult.dataWithError(Data? data,Error error) {
    return UserResult(
      error: error,
      data: data,
    );
  }

  /// forwards the error if present else forwards the data
  factory UserResult.forward(UserResult _result, Data? data) {
    if (_result.hasErrorOnly) {
      return UserResult.error(_result.error as Error);
    }
     return UserResult.data(data);
  }

  fold({required UserResult Function(Error error) onError,required UserResult Function(Data data) onData}) {
    if(hasDataOnly) {
      return onData;
    } else {
      return onError;
    }
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
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';

/// A generic class that represents a remote data model.
///
/// This class is used to encapsulate the data, status, message, and error
/// information retrieved from a remote source.
class RemoteBaseModel<T> {
  /// Constructs a [RemoteBaseModel] instance with optional parameters.
  ///
  /// \param status The status of the remote operation.
  /// \param message An optional message associated with the remote operation.
  /// \param data The data retrieved from the remote source.
  /// \param error An optional error object if the remote operation failed.
  RemoteBaseModel({
    this.status,
    this.message,
    this.data,
    this.error,
  });

  /// The status of the remote operation.
  StatusModel? status;

  /// An optional message associated with the remote operation.
  String? message;

  /// The data retrieved from the remote source.
  T? data;

  /// An optional error object if the remote operation failed.
  Object? error;

  /// Creates a [RemoteBaseModel] instance from a JSON map.
  ///
  /// \param json A map containing the data to initialize the model.
  /// \returns A [RemoteBaseModel] instance with the data from the JSON map.
  factory RemoteBaseModel.fromJson(Map<String, dynamic> json) {
    return RemoteBaseModel(
      status: json['status'] ?? "" as String?,
      message: json['message'] ?? "" as String?,
      data: json['data'] ?? "" as T?,
      error: json['error'] ?? "" as Object?,
    );
  }

  /// Converts the [RemoteBaseModel] instance to a JSON map.
  ///
  /// \returns A map containing the data of the model.
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data;
    _data['error'] = error;
    return _data;
  }
}

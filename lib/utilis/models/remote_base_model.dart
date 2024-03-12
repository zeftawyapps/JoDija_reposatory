
import 'package:JoDija_DataSource/utilis/models/staus_model.dart';

class RemoteBaseModel<T> {

  RemoteBaseModel({
    this.status,
    this.message,this.data , this.error
  });
  StatusModel? status;
  String? message;
  T?data ;
  Object? error;
  factory RemoteBaseModel.fromJson(Map<String, dynamic> json) {
    return RemoteBaseModel(
      status: json['status']??"" as String?,
      message: json['message']??"" as String?,
      data: json['data']??"" as T?,
      error: json['error']??"" as Object?,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data;
    _data['error'] = error;
    return _data;
  }
}

import 'package:JoDija_DataSource/interface/sources/i_json_base_source.dart';
import 'package:JoDija_DataSource/utilis/models/base_data_model.dart';

import '../../utilis/models/remote_base_model.dart';
import '../../utilis/result/result.dart';

abstract class IBaseDataSourceRepo<T extends BaseDataModel> {
  IBaseDataActionsSource<T>? _inputSource;
  Future<RemoteBaseModel> addData();
  Future<RemoteBaseModel> deleteData(String id);
  Future<RemoteBaseModel<List<T>>> getListData();
  Future<RemoteBaseModel<T>> getSingleData(String id);
  Future<RemoteBaseModel> updateData(String id);
}

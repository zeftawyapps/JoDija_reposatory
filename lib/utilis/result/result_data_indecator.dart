import 'package:JoDija_DataSource/utilis/result/result.dart';

import '../models/base_data_model.dart';
import '../models/remote_base_model.dart';
import '../models/staus_model.dart';

class ResultDataHelper<T extends BaseDataModel  > {
    RemoteBaseModel getResulInputt(Result result) {
    if (result.error == null) {
      return RemoteBaseModel(data: result.data, status: StatusModel.success);
    } else {
      throw RemoteBaseModel(error: result.error,
          message: result.error!.message,
          status: StatusModel.error);
    }
  }

    RemoteBaseModel<List<T>> getResultOfListData(RemoteBaseModel result,
      T? Function(Map<String, dynamic>? data, ) builder
      ) {
    if (result.error == null) {
      List<BaseDataModel> listData = result.data  as List<BaseDataModel>;

      List<T> list = [];
      for (var item in listData) {
        T data = builder(item.map) as T;
        list.add(data ) ;
      }
      return RemoteBaseModel(data: list, status: StatusModel.success);
    } else {
      throw RemoteBaseModel(error: result.error,
          message: result.message,
          status: StatusModel.error);
    }
  }

  RemoteBaseModel<T> getResultOfData(Result result,
      T? Function(Map<String, dynamic>? data, ) builder

      ) {
    if (result.error == null) {
      BaseDataModel resultData = result.data as BaseDataModel;
      T getedData  = builder(resultData.map) as T;
      return RemoteBaseModel(data: getedData , status: StatusModel.success);
    } else {
      throw RemoteBaseModel(error: result.error,
          message: result.error!.message,
          status: StatusModel.error);
    }
  }

}

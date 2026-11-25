// created class

import '../interface/sources/i_base_stream.dart';
import '../utilis/models/base_data_model.dart';

class StreamRepo <T extends BaseEntityDataModel>   {
  // add name
  IBaseStream<T>? _dataSource;
  StreamRepo({
    required IBaseStream<T> dataSource,
  }) {
    _dataSource = dataSource;
  }


  Stream<List<T>> streamData() {
    return _dataSource!.streamData();
  }


}
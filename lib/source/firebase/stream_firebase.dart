import 'package:JoDija_DataSource/interface/sources/i_base_stream.dart';
import 'package:JoDija_DataSource/utilis/models/base_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/sources/i_base_source.dart';
import '../../utilis/firebase/firebase.dart';

class StreamFirebaseDataSource<T extends BaseDataModel > implements IBaseStream<BaseDataModel> {
  final _fireStore = FirebaseLoadingData();
  String path;
  T Function(Map<String, dynamic>? jsondata, String docId) builder ;
  StreamFirebaseDataSource({required this.path,
  required this.builder
  });

  Stream<List<T>> streamData() async* {
    var dataResult = _fireStore.streamAllData(
        path: path,
        builder: (data, documentId) =>
             builder(data, documentId),);
    yield* dataResult!;
  }
}

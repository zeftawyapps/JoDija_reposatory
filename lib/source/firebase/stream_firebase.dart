import 'package:JoDija_reposatory/interface/sources/i_base_stream.dart';
import 'package:JoDija_reposatory/utilis/models/base_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/sources/i_base_source.dart';
import '../../utilis/firebase/firebase.dart';

/// A data source class for streaming data from Firebase Firestore.
///
/// This class implements the [IBaseStream] interface to provide a stream of data
/// from a specified Firestore collection path. It uses a builder function to
/// convert JSON data into a data model of type [T].
///
/// Type Parameters:
/// - [T]: The type of the data model, which must extend [BaseEntityDataModel].
///
/// Example usage:
/// ```dart
/// final streamSource = StreamFirebaseDataSource<BaseDataModel>(
///   path: 'collectionPath',
///   builder: (json, docId) => BaseDataModel.fromJson(json, docId),
/// );
///
/// streamSource.streamData().listen((dataList) {
///   // Handle the streamed data list
/// });
/// ```
///
/// See also:
/// - [FirebaseLoadingData], which provides methods for loading data from Firestore.
/// - [BaseEntityDataModel], the base class for data models.
class StreamFirebaseDataSource<T extends BaseEntityDataModel>
    implements IBaseStream<BaseEntityDataModel> {
  final _fireStore = FirebaseLoadingData();
  String path;
  T Function(Map<String, dynamic>? jsondata, String docId) builder;

  /// Creates a new instance of [StreamFirebaseDataSource].
  ///
  /// The [path] parameter specifies the Firestore collection path.
  /// The [builder] parameter is a function to build the data model from JSON.
  StreamFirebaseDataSource({
    required this.path,
    required this.builder,
  });

  /// Streams a list of data items from Firebase Firestore.
  ///
  /// This method returns a stream of data items of type [T] from the specified
  /// Firestore collection path. The data is built using the provided [builder] function.
  ///
  /// Returns:
  /// - A [Stream] of [List] of [T] containing the streamed data items.
  Stream<List<T>> streamData() async* {
    var dataResult = _fireStore.streamAllData(
      path: path,
      builder: (data, documentId) => builder(data, documentId),
    );
    yield* dataResult!;
  }
}

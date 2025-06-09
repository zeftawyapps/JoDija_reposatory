# IBaseStream

`IBaseStream` is an abstract class that defines a stream of data items of type `T`. It provides a method to retrieve a stream of data items.

## Type Parameters

- `T`: The type of data items to be streamed.

## Methods

### streamData()

Retrieves a stream of data items.

```dart
Stream<List<T>> streamData();
```

**Returns**: A `Stream` that emits lists of data items of type `T`. The stream will emit new lists whenever the underlying data changes.

## Usage Example

This abstract class is meant to be implemented by concrete data source classes that provide streaming capabilities:

```dart
class MyStreamDataSource extends IBaseStream<MyDataModel> {
  @override
  Stream<List<MyDataModel>> streamData() {
    // Implementation that returns a stream of MyDataModel lists
    return myDataStream;
  }
}
```

A common implementation is `StreamFirebaseDataSource` which streams data from Firebase:

```dart
final streamSource = StreamFirebaseDataSource<BaseDataModel>(
  path: 'collectionPath',
  builder: (json, docId) => BaseDataModel.fromJson(json, docId),
);

streamSource.streamData().listen((dataList) {
  // Process the streamed data list
  for (var item in dataList) {
    print(item);
  }
});
```

## Related Classes

- `StreamFirebaseDataSource`: A concrete implementation that streams data from Firebase Firestore.

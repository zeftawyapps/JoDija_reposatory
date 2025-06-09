# IBaseDataActionsSource

`IBaseDataActionsSource` is an abstract class that defines the actions for data sources. It provides methods to perform CRUD (Create, Read, Update, Delete) operations on data items.

## Type Parameters

- `T`: The type of data items, which must extend `BaseDataModel`.

## Methods

### addDataItem()

Adds a data item.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> addDataItem();
```

**Returns**: A `Future` that completes with a `Result` containing either a `RemoteBaseModel` on success or another `RemoteBaseModel` on error.

### editeDataItem(String id)

Edits a data item identified by the given `id`.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> editeDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data item to edit.

**Returns**: A `Future` that completes with a `Result` containing either a `RemoteBaseModel` on success or another `RemoteBaseModel` on error.

### deleteDataItem(String id)

Deletes a data item identified by the given `id`.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data item to delete.

**Returns**: A `Future` that completes with a `Result` containing either a `RemoteBaseModel` on success or another `RemoteBaseModel` on error.

### getDataList()

Retrieves a list of data items.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getDataList();
```

**Returns**: A `Future` that completes with a `Result` containing either a `RemoteBaseModel` on success or a `RemoteBaseModel<List<T>>` with the list of data items.

### getSingleData(String id)

Retrieves a single data item identified by the given `id`.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(String id);
```

**Parameters**:

- `id`: The identifier of the data item to retrieve.

**Returns**: A `Future` that completes with a `Result` containing either a `RemoteBaseModel` on success or a `RemoteBaseModel<T>` with the data item.

## Implementations

The `IBaseDataActionsSource` interface is implemented by the following concrete classes:

- `DataSourceFirebaseSource`: Implements data actions using Firebase Firestore.
- `DataSourceDataActionsHttpSources`: Implements data actions using HTTP requests.

## Usage Example

```dart
// Create a Firebase data source
var firebaseSource = DataSourceFirebaseSource.insert(
  dataModel: myDataModel,
  path: 'myCollection',
);

// Add a data item
var result = await firebaseSource.addDataItem();
result.when(
  data: (data) => print('Data added successfully'),
  error: (error) => print('Error: ${error.message}'),
);

// Retrieve data
var dataResult = await firebaseSource.getDataList();
dataResult.when(
  data: (data) => print('Retrieved ${data.data.length} items'),
  error: (error) => print('Error: ${error.message}'),
);
```

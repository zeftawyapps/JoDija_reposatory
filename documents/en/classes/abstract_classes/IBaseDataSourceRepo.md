# IBaseDataSourceRepo

`IBaseDataSourceRepo` is an abstract repository class for data source operations. It defines the basic CRUD (Create, Read, Update, Delete) operations for a data source and provides a helper for result data handling.

## Type Parameters

- `T`: The type of data model that extends `BaseDataModel`.

## Properties

- `_inputSource`: The input source for data actions.
  - Type: `IBaseDataActionsSource<T>?`

## Methods

### addData()

Adds data to the data source.

```dart
Future<RemoteBaseModel> addData();
```

**Returns**: A `Future` that completes with a `RemoteBaseModel`.

### editData(String id)

Edits data in the data source.

```dart
Future<RemoteBaseModel> editData(String id);
```

**Parameters**:

- `id`: The identifier of the data to edit.

**Returns**: A `Future` that completes with a `RemoteBaseModel`.

### deleteData(String id)

Deletes data from the data source.

```dart
Future<RemoteBaseModel> deleteData(String id);
```

**Parameters**:

- `id`: The identifier of the data to delete.

**Returns**: A `Future` that completes with a `RemoteBaseModel`.

### getData()

Retrieves data from the data source.

```dart
Future<RemoteBaseModel<List<T>>> getData();
```

**Returns**: A `Future` that completes with a `RemoteBaseModel` containing a list of data items.

### getSingle(String id)

Retrieves a single data item from the data source.

```dart
Future<RemoteBaseModel<T>> getSingle(String id);
```

**Parameters**:

- `id`: The identifier of the data to retrieve.

**Returns**: A `Future` that completes with a `RemoteBaseModel` containing a single data item.

## Usage Example

This abstract class is meant to be implemented by concrete repository classes, such as `DataSourceRepo`:

```dart
class MyDataRepo extends IBaseDataSourceRepo<MyDataModel> {
  MyDataRepo({required IBaseDataActionsSource<MyDataModel> source}) {
    _inputSource = source;
  }

  @override
  Future<RemoteBaseModel> addData() async {
    // Implementation
  }

  // Implement other methods...
}
```

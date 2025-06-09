# IBaseSource

`IBaseSource` is an abstract class that defines the basic operations for a data source. It provides methods for adding, updating, deleting, and retrieving data items.

## Type Parameters

- `T`: The type of data model that extends `BaseDataModel`.

## Properties

- `data`: The data item of type `T`.
  - Type: `T?`

## Methods

### addDataItem()

Adds a data item.

```dart
Future addDataItem();
```

**Returns**: A `Future` that completes when the data item is added.

### updateDataItem(String id)

Updates a data item identified by the given `id`.

```dart
Future updateDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data item to update.

**Returns**: A `Future` that completes when the data item is updated.

### deleteDataItem(String id)

Deletes a data item identified by the given `id`.

```dart
Future deleteDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data item to delete.

**Returns**: A `Future` that completes when the data item is deleted.

### getDataList()

Retrieves a list of all data items.

```dart
Future<List<T>> getDataList();
```

**Returns**: A `Future` that completes with a list of all data items.

### getSingleData(String id)

Retrieves a single data item identified by the given `id`.

```dart
Future<T> getSingleData(String id);
```

**Parameters**:

- `id`: The identifier of the data item to retrieve.

**Returns**: A `Future` that completes with the requested data item.

## Usage Example

This abstract class is meant to be implemented by concrete data source classes:

```dart
class MyDataSource extends IBaseSource<MyDataModel> {
  @override
  Future addDataItem() {
    // Implementation
  }

  @override
  Future updateDataItem(String id) {
    // Implementation
  }

  @override
  Future deleteDataItem(String id) {
    // Implementation
  }

  @override
  Future<List<MyDataModel>> getDataList() {
    // Implementation
  }

  @override
  Future<MyDataModel> getSingleData(String id) {
    // Implementation
  }
}
```

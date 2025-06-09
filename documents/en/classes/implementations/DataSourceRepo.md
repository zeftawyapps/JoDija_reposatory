# DataSourceRepo

`DataSourceRepo` is a repository class for managing data sources. It provides methods to add, delete, retrieve, and update data using the provided data actions source interface.

## Type Parameters

- `T`: The type of data model that extends `BaseDataModel`.

## Properties

- `_inputSource`: The data actions source interface.
  - Type: `IBaseDataActionsSource<T>?`

## Constructors

### DataSourceRepo({required IBaseDataActionsSource<T> inputSource})

Creates a new instance of `DataSourceRepo`.

**Parameters**:

- `inputSource`: The data actions source interface implementation.

## Methods

### addData()

Adds a data item to the data source.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> addData();
```

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### editData(String id)

Edits a data item in the data source.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> editData(String id);
```

**Parameters**:

- `id`: The identifier of the data to edit.

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### deleteData(String id)

Deletes a data item from the data source.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteData(String id);
```

**Parameters**:

- `id`: The identifier of the data to delete.

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### getData()

Retrieves data from the data source.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getData();
```

**Returns**: A `Result` containing either an error `RemoteBaseModel` or a `RemoteBaseModel` with a list of data items.

### getSingle(String id)

Retrieves a single data item from the data source.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingle(String id);
```

**Parameters**:

- `id`: The identifier of the data to retrieve.

**Returns**: A `Result` containing either an error `RemoteBaseModel` or a `RemoteBaseModel` with a single data item.

## Usage Example

```dart
// Create a data model
class ProductModel extends BaseDataModel {
  String name;
  double price;

  ProductModel({required this.name, required this.price});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }

  static ProductModel fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    )..documentId = documentId;
  }
}

// Create a data source
var dataSource = DataSourceFirebaseSource.insert(
  dataModel: ProductModel(name: 'New Product', price: 29.99),
  path: 'products',
);

// Create a repository
var repo = DataSourceRepo<ProductModel>(inputSource: dataSource);

// Add data
var result = await repo.addData();
result.when(
  data: (success) => print('Data added successfully'),
  error: (error) => print('Error: ${error.message}')
);

// Retrieve data
var dataSource = DataSourceFirebaseSource.get<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
);
var repo = DataSourceRepo<ProductModel>(inputSource: dataSource);

var dataResult = await repo.getData();
dataResult.when(
  data: (data) {
    print('Retrieved ${data.data.length} items:');
    for (var product in data.data) {
      print('- ${product.name}: \$${product.price}');
    }
  },
  error: (error) => print('Error: ${error.message}')
);

// Edit data
var productToEdit = ProductModel(name: 'Updated Product', price: 39.99);
var dataSource = DataSourceFirebaseSource.edit(
  dataModel: productToEdit,
  path: 'products',
);
var repo = DataSourceRepo<ProductModel>(inputSource: dataSource);

var editResult = await repo.editData('product123');
editResult.when(
  data: (_) => print('Product updated successfully'),
  error: (error) => print('Error: ${error.message}')
);

// Delete data
var dataSource = DataSourceFirebaseSource.delete(
  path: 'products',
);
var repo = DataSourceRepo<ProductModel>(inputSource: dataSource);

var deleteResult = await repo.deleteData('product123');
deleteResult.when(
  data: (_) => print('Product deleted successfully'),
  error: (error) => print('Error: ${error.message}')
);
```

## Implementation Details

The `DataSourceRepo` class acts as a wrapper around the `IBaseDataActionsSource` interface, which actually performs the data operations. The repository class provides a clean API for the application layer to interact with data sources, abstracting away the implementation details.

The class uses the `Result` type to handle operation outcomes, which can be either successful or contain errors. This approach allows for robust error handling and makes it clear to callers when operations succeed or fail.

## Related Classes

- `IBaseDataActionsSource`: Abstract interface for data source operations.
- `DataSourceFirebaseSource`: Firebase implementation of `IBaseDataActionsSource`.
- `DataSourceDataActionsHttpSources`: HTTP implementation of `IBaseDataActionsSource`.
- `BaseDataModel`: Base class for all data models.
- `RemoteBaseModel`: Generic model for remote data operations.
- `Result`: Generic result type that can contain either success data or error information.

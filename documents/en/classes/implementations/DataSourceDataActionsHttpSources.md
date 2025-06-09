# DataSourceDataActionsHttpSources

`DataSourceDataActionsHttpSources` is an implementation of the `IBaseDataActionsSource` interface that uses HTTP requests to perform CRUD operations on remote data sources. It provides methods for adding, updating, deleting, and retrieving data through HTTP API endpoints.

## Properties

- `data`: The data model to be operated on.

  - Type: `BaseDataModel?`

- `file`: An optional file to be uploaded.

  - Type: `MultipartFile?`

- `imagfileld`: The field name for the image file.

  - Type: `String`
  - Default: `"image"`

- `baseUrl`: The base URL for API requests.

  - Type: `String`

- `url`: The specific endpoint URL path.
  - Type: `String`

## Factory Constructors

### DataSourceDataActionsHttpSources.inputs({String? baseUrl = "", required String url, required BaseDataModel dataModyle, MultipartFile? file})

Factory constructor for creating an instance with input data.

**Parameters**:

- `baseUrl`: The base URL for API requests (optional, default: "").
- `url`: The specific endpoint URL path.
- `dataModyle`: The data model to operate on.
- `file`: An optional file to upload.

## Methods

### addDataItem()

Adds a data item to the remote server using HTTP POST request.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> addDataItem();
```

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### updateDataItem(String id)

Updates a data item on the remote server using HTTP PUT request.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> updateDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data to update.

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### deleteDataItem(String id)

Deletes a data item from the remote server using HTTP DELETE request.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data to delete.

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### getDataList()

Retrieves a list of data items from the remote server using HTTP GET request.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<List<BaseDataModel>>>> getDataList();
```

**Returns**: A `Result` containing either an error `RemoteBaseModel` or a `RemoteBaseModel` with a list of data items.

### getSingleData(String id)

Retrieves a single data item from the remote server using HTTP GET request.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<BaseDataModel>>> getSingleData(String id);
```

**Parameters**:

- `id`: The identifier of the data to retrieve.

**Returns**: A `Result` containing either an error `RemoteBaseModel` or a `RemoteBaseModel` with a single data item.

## Usage Example

```dart
// Define a data model
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

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    )..documentId = documentId;
  }
}

// Create a MultipartFile for an image (if needed)
final productImageFile = await MultipartFile.fromFile(
  'path/to/image.jpg',
  filename: 'product_image.jpg',
);

// Create an HTTP data source
final productData = ProductModel(name: 'Smart Watch', price: 299.99);
final dataSource = DataSourceDataActionsHttpSources.inputs(
  baseUrl: 'https://api.example.com',
  url: '/products',
  dataModyle: productData,
  file: productImageFile
);

// Add a new product
final addResult = await dataSource.addDataItem();
addResult.when(
  data: (success) => print('Product added successfully: ${success.data}'),
  error: (error) => print('Error adding product: ${error.message}')
);

// Update a product
final updateDataSource = DataSourceDataActionsHttpSources.inputs(
  baseUrl: 'https://api.example.com',
  url: '/products',
  dataModyle: ProductModel(name: 'Smart Watch Pro', price: 349.99),
);
final updateResult = await updateDataSource.updateDataItem('product123');
updateResult.when(
  data: (success) => print('Product updated successfully'),
  error: (error) => print('Error updating product: ${error.message}')
);

// Delete a product
final deleteDataSource = DataSourceDataActionsHttpSources.inputs(
  baseUrl: 'https://api.example.com',
  url: '/products',
  dataModyle: ProductModel(name: '', price: 0),
);
final deleteResult = await deleteDataSource.deleteDataItem('product123');
deleteResult.when(
  data: (success) => print('Product deleted successfully'),
  error: (error) => print('Error deleting product: ${error.message}')
);

// Get all products
final getAllDataSource = DataSourceDataActionsHttpSources.inputs(
  baseUrl: 'https://api.example.com',
  url: '/products',
  dataModyle: ProductModel(name: '', price: 0),
);
final listResult = await getAllDataSource.getDataList();
listResult.when(
  data: (data) {
    print('Retrieved ${data.data.length} products:');
    for (var product in data.data) {
      print('- ${product.name}: \$${product.price}');
    }
  },
  error: (error) => print('Error getting products: ${error.message}')
);

// Get a single product
final getSingleDataSource = DataSourceDataActionsHttpSources.inputs(
  baseUrl: 'https://api.example.com',
  url: '/products',
  dataModyle: ProductModel(name: '', price: 0),
);
final singleResult = await getSingleDataSource.getSingleData('product456');
singleResult.when(
  data: (product) => print('Retrieved product: ${product.data.name}'),
  error: (error) => print('Error getting product: ${error.message}')
);
```

## Implementation Details

The `DataSourceDataActionsHttpSources` class uses the `JodijaHttpClient` class for making HTTP requests to remote APIs. It supports file uploads by handling `MultipartFile` objects and can be used with RESTful API endpoints.

For each CRUD operation, the class:

1. Prepares the data and URL
2. Makes the appropriate HTTP request (GET, POST, PUT, DELETE)
3. Handles the response and converts it to a `Result` object
4. Processes any errors that might occur during the request

The class supports operations with or without authentication tokens, which are managed by the `HttpHeader` class.

## Related Classes

- `IBaseDataActionsSource`: The interface that defines data source operations.
- `JodijaHttpClient`: Handles the HTTP requests.
- `BaseDataModel`: Base class for all data models.
- `RemoteBaseModel`: Generic model for remote data operations.
- `Result`: Generic result type that can contain either success data or error information.
- `HttpMethod`: Enum defining HTTP method types (GET, POST, PUT, DELETE).

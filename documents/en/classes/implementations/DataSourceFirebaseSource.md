# DataSourceFirebaseSource

`DataSourceFirebaseSource` is a data source implementation for Firebase that handles CRUD operations. It provides methods to add, delete, edit, and retrieve data from Firebase Firestore, with support for uploading files to Firebase Storage and handling image fields.

## Type Parameters

- `T`: The type of data model that extends `BaseDataModel`.

## Properties

- `_fireStoreAction`: Handles Firestore and Storage actions.

  - Type: `FirestoreAndStorageActions`

- `_firebaseLoadingData`: Handles loading data from Firebase.

  - Type: `FirebaseLoadingData`

- `_data`: The data model to be operated on.

  - Type: `BaseDataModel?`

- `_file`: An optional file to be uploaded to Firebase Storage.

  - Type: `Object?`

- `_path`: The Firestore collection path.

  - Type: `String`

- `deleteUrl`: The URL of a file to be deleted.

  - Type: `String?`

- `imageField`: The field name for the image URL.

  - Type: `String?`
  - Default: `"image"`

- `_query`: An optional function to modify the Firestore query.

  - Type: `Query Function(Query query)?`

- `dataBuilder`: A function to build the data model from JSON.
  - Type: `T Function(Map<String, dynamic>? jsondata, String docId)?`

## Constructors

### DataSourceFirebaseSource(String path, {Query Function(Query query)? query})

Creates a new instance of `DataSourceFirebaseSource`.

**Parameters**:

- `path`: The Firestore collection path.
- `query`: An optional function to modify the Firestore query.

### Factory Constructors

#### DataSourceFirebaseSource.get({required String path, Query Function(Query query)? query, required T Function(Map<String, dynamic>? jsondata, String docId) builder})

Factory constructor for getting data from Firebase.

**Parameters**:

- `path`: The Firestore collection path.
- `query`: An optional function to modify the Firestore query.
- `builder`: A function to build the data model from JSON.

#### DataSourceFirebaseSource.insert({required BaseDataModel dataModel, required String path, Object? file, String? imageField = "image"})

Factory constructor for inserting data into Firebase.

**Parameters**:

- `dataModel`: The data model to insert.
- `path`: The Firestore collection path.
- `file`: An optional file to upload.
- `imageField`: The field name for the image (default: "image").

#### DataSourceFirebaseSource.edit({required BaseDataModel dataModel, required String path, Object? file, String? oldImg = "", String? imageField = "image"})

Factory constructor for editing data in Firebase.

**Parameters**:

- `dataModel`: The data model to edit.
- `path`: The Firestore collection path.
- `file`: An optional file to upload.
- `oldImg`: The old image URL to delete.
- `imageField`: The field name for the image (default: "image").

#### DataSourceFirebaseSource.delete({required String path, String? oldImg})

Factory constructor for deleting data from Firebase.

**Parameters**:

- `path`: The Firestore collection path.
- `oldImg`: The old image URL to delete.

## Methods

### addDataItem()

Adds a data item to Firebase.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> addDataItem();
```

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### updateDataItem(String id)

Updates a data item in Firebase.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> updateDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data to update.

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### deleteDataItem(String id)

Deletes a data item from Firebase.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(String id);
```

**Parameters**:

- `id`: The identifier of the data to delete.

**Returns**: A `Result` containing either a successful `RemoteBaseModel` or an error `RemoteBaseModel`.

### getDataList()

Retrieves a list of data items from Firebase.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>> getDataList();
```

**Returns**: A `Result` containing either an error `RemoteBaseModel` or a `RemoteBaseModel` with a list of data items.

### getSingleData(String id)

Retrieves a single data item from Firebase.

```dart
Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(String id);
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

  static ProductModel fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    )..documentId = documentId;
  }
}

// Adding a new product with an image
File productImage = File('path/to/image.jpg');
var dataSource = DataSourceFirebaseSource.insert(
  dataModel: ProductModel(name: 'Premium Chair', price: 199.99),
  path: 'products',
  file: productImage,
  imageField: 'productImage'
);

var result = await dataSource.addDataItem();
result.when(
  data: (success) => print('Product added successfully'),
  error: (error) => print('Error: ${error.message}')
);

// Retrieving products
var productsSource = DataSourceFirebaseSource.get<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
);

var dataResult = await productsSource.getDataList();
dataResult.when(
  data: (data) {
    print('Retrieved ${data.data.length} products:');
    for (var product in data.data) {
      print('- ${product.name}: \$${product.price}');
    }
  },
  error: (error) => print('Error: ${error.message}')
);

// Updating a product
var productToEdit = ProductModel(name: 'Deluxe Chair', price: 249.99);
var editSource = DataSourceFirebaseSource.edit(
  dataModel: productToEdit,
  path: 'products',
);

var editResult = await editSource.updateDataItem('product123');
editResult.when(
  data: (_) => print('Product updated successfully'),
  error: (error) => print('Error: ${error.message}')
);

// Deleting a product with its image
var deleteSource = DataSourceFirebaseSource.delete(
  path: 'products',
  oldImg: 'https://storage.firebase.com/images/product123.jpg'
);

var deleteResult = await deleteSource.deleteDataItem('product123');
deleteResult.when(
  data: (_) => print('Product and its image deleted successfully'),
  error: (error) => print('Error: ${error.message}')
);

// Retrieving a single product
var singleProductSource = DataSourceFirebaseSource.get<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
);

var singleResult = await singleProductSource.getSingleData('product456');
singleResult.when(
  data: (product) => print('Retrieved product: ${product.data.name}'),
  error: (error) => print('Error: ${error.message}')
);
```

## Implementation Details

The `DataSourceFirebaseSource` class implements the `IBaseDataActionsSource` interface, providing Firebase-specific implementations of the data operations. It uses `FirestoreAndStorageActions` for interacting with Firestore and Firebase Storage, and `FirebaseLoadingData` for loading data from Firebase.

When handling files, the class will upload the file to Firebase Storage and store the download URL in the specified image field of the Firestore document. When deleting documents with associated files, it will also delete the files from Firebase Storage.

## Related Classes

- `IBaseDataActionsSource`: Abstract interface for data source operations.
- `FirestoreAndStorageActions`: Handles Firestore and Storage operations.
- `FirebaseLoadingData`: Handles loading data from Firebase.
- `BaseDataModel`: Base class for all data models.
- `RemoteBaseModel`: Generic model for remote data operations.
- `Result`: Generic result type that can contain either success data or error information.

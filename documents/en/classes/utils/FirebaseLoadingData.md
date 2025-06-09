# FirebaseLoadingData

`FirebaseLoadingData` is a utility class that handles loading and streaming data from Firebase Firestore. It provides methods for retrieving and observing data from Firestore collections and documents, with support for queries and data transformation.

## Properties

- `_fireStore`: Instance of FirebaseFirestore to interact with the Firestore database.
  - Type: `FirebaseFirestore`

## Methods

### getCollrection(String collection)

Returns a CollectionReference for the specified collection.

```dart
CollectionReference getCollrection(String collection);
```

**Parameters**:

- `collection`: The name of the collection.

**Returns**: A `CollectionReference` for the specified collection.

### loadDataAsFuture(String collection)

Loads data from the specified collection and returns it as a Future<QuerySnapshot>.

```dart
Future<QuerySnapshot> loadDataAsFuture(String collection);
```

**Parameters**:

- `collection`: The name of the collection.

**Returns**: A `Future` that completes with a `QuerySnapshot` containing the collection data.

### loadSingleData<T>({required String path, required T Function(Map<String, dynamic>? data, String documentId) builder})

Loads single data from the specified path and returns it as a Future<T>.

```dart
Future<T> loadSingleData<T>({
  required String path,
  required T Function(Map<String, dynamic>? data, String documentId) builder
});
```

**Parameters**:

- `path`: The path to the data.
- `builder`: The function to build the data from the document.

**Returns**: A `Future` that completes with the built data of type `T`.

### loadAllData<T>({required String path, required T Function(Map<String, dynamic>? data, String documentId) builder})

Loads all data from the specified path and returns it as a Future<T>.

```dart
Future<T> loadAllData<T>({
  required String path,
  required T Function(Map<String, dynamic>? data, String documentId) builder
});
```

**Parameters**:

- `path`: The path to the data.
- `builder`: The function to build the data from the document.

**Returns**: A `Future` that completes with the built data of type `T`.

### streamSingleData<T>({required String path, required String id, required T Function(Map<String, dynamic>? data, String documentId) builder})

Streams single data from the specified path and id and returns it as a Stream<T>.

```dart
Stream<T> streamSingleData<T>({
  required String path,
  required String id,
  required T Function(Map<String, dynamic>? data, String documentId) builder
});
```

**Parameters**:

- `path`: The path to the data.
- `id`: The id of the document.
- `builder`: The function to build the data from the document.

**Returns**: A `Stream` of type `T` that emits when the document changes.

### loadDataWithQuery<T extends BaseDataModel>({required String path, required T Function(Map<String, dynamic>? jsondata, String docId) builder, Query Function(Query query)? queryBuilder, int Function(T lhs, T rhs)? sort})

Loads data with a query from the specified path and returns it as a Future<List<T>>.

```dart
Future<List<T>> loadDataWithQuery<T extends BaseDataModel>({
  required String path,
  required T Function(Map<String, dynamic>? jsondata, String docId) builder,
  Query Function(Query query)? queryBuilder,
  int Function(T lhs, T rhs)? sort
});
```

**Parameters**:

- `path`: The path to the data.
- `builder`: The function to build the data from the document.
- `queryBuilder`: An optional function to build the query.
- `sort`: An optional function to sort the data.

**Returns**: A `Future` that completes with a list of built data of type `T`.

### StreamDataWithQuery<T>({required String path, required T Function(Map<String, dynamic>? data, String documentId) builder, Query Function(Query query)? queryBuilder, int Function(T lhs, T rhs)? sort})

Streams data with a query from the specified path and returns it as a Stream<List<T>>.

```dart
Stream<List<T>> StreamDataWithQuery<T>({
  required String path,
  required T Function(Map<String, dynamic>? data, String documentId) builder,
  Query Function(Query query)? queryBuilder,
  int Function(T lhs, T rhs)? sort
});
```

**Parameters**:

- `path`: The path to the data.
- `builder`: The function to build the data from the document.
- `queryBuilder`: An optional function to build the query.
- `sort`: An optional function to sort the data.

**Returns**: A `Stream` of list of type `T` that emits when the query results change.

### streamAllData<T>({required String path, required T Function(Map<String, dynamic>? jsondata, String docId) builder})

Streams all data from the specified path and returns it as a Stream<List<T>>.

```dart
Stream<List<T>>? streamAllData<T>({
  required String path,
  required T Function(Map<String, dynamic>? jsondata, String docId) builder
});
```

**Parameters**:

- `path`: The path to the data.
- `builder`: The function to build the data from the document.

**Returns**: A `Stream` of list of type `T` that emits when the collection changes.

### streamSnapshot({required String path})

Streams snapshot from the specified path and returns it as a Stream.

```dart
Stream streamSnapshot({required String path});
```

**Parameters**:

- `path`: The path to the data.

**Returns**: A `Stream` of snapshots that emits when the collection changes.

### loadAllDataAsList<T>({required String path, required T Function(Map<String, dynamic> jsondata, String docId) builder})

Loads all data from the specified path and returns it as a Future<List<T>>.

```dart
Future<List<T>> loadAllDataAsList<T>({
  required String path,
  required T Function(Map<String, dynamic> jsondata, String docId) builder
});
```

**Parameters**:

- `path`: The path to the data.
- `builder`: The function to build the data from the document.

**Returns**: A `Future` that completes with a list of built data of type `T`.

### loadSingleDocData(String path, String documentId)

Loads a single document from the specified path and document ID.

```dart
Future<Map<String, dynamic>?> loadSingleDocData(String path, String documentId);
```

**Parameters**:

- `path`: The collection path.
- `documentId`: The document ID.

**Returns**: A `Future` that completes with the document data as a `Map<String, dynamic>?`.

### getDataSnapshotOpjectToMap(QuerySnapshot doc)

Extracts a list of maps from a QuerySnapshot.

```dart
List<Map<String, dynamic>> getDataSnapshotOpjectToMap(QuerySnapshot doc);
```

**Parameters**:

- `doc`: The QuerySnapshot to extract data from.

**Returns**: A `List<Map<String, dynamic>>` containing the document data.

## Usage Example

```dart
// Create an instance of FirebaseLoadingData
FirebaseLoadingData firebaseLoader = FirebaseLoadingData();

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

  static ProductModel fromJson(Map<String, dynamic>? json, String documentId) {
    if (json == null) return ProductModel(name: '', price: 0)..documentId = documentId;

    return ProductModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    )..documentId = documentId;
  }
}

// Loading data with a query
List<ProductModel> products = await firebaseLoader.loadDataWithQuery<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
  queryBuilder: (query) => query.where('price', isGreaterThan: 50).orderBy('price', descending: true),
);

// Print the products
for (var product in products) {
  print('${product.name}: \$${product.price}');
}

// Stream data changes
firebaseLoader.streamAllData<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
).listen((productList) {
  print('Products updated - count: ${productList.length}');
  for (var product in productList) {
    print('- ${product.name}: \$${product.price}');
  }
});

// Get a single document
Map<String, dynamic>? productData = await firebaseLoader.loadSingleDocData('products', 'product123');
if (productData != null) {
  print('Product name: ${productData['name']}');
  print('Product price: ${productData['price']}');
} else {
  print('Product not found');
}

// Get all documents as a list
List<ProductModel> allProducts = await firebaseLoader.loadAllDataAsList<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
);
print('All products count: ${allProducts.length}');
```

## Implementation Details

The `FirebaseLoadingData` class provides a comprehensive set of utilities for interacting with Firestore data. It supports both one-time loading and real-time streaming of data, with options for filtering, sorting, and transforming the data.

The class uses Firebase Firestore's query capabilities and snapshot listeners to provide efficient data access. For streaming operations, it leverages Firestore's real-time update features to provide continuously updated data.

The data transformation functions (`builder` parameters) allow for converting raw Firestore data into typed Dart objects, making it easier to work with the data in a type-safe manner.

## Related Classes

- `FirestoreAndStorageActions`: Handles Firestore and Storage operations.
- `FireStoreAction`: Provides direct Firestore operations.
- `BaseDataModel`: Base class for all data models.
- `StreamFirebaseDataSource`: Uses `FirebaseLoadingData` for streaming data.
- `DataSourceFirebaseSource`: Uses `FirebaseLoadingData` for CRUD operations.

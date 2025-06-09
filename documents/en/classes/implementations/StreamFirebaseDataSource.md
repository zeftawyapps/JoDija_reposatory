# StreamFirebaseDataSource

`StreamFirebaseDataSource` is a data source class for streaming data from Firebase Firestore. It implements the `IBaseStream` interface to provide a stream of data from a specified Firestore collection path, using a builder function to convert JSON data into a data model.

## Type Parameters

- `T`: The type of the data model, which must extend `BaseDataModel`.

## Properties

- `_fireStore`: Provides Firebase loading functionality.

  - Type: `FirebaseLoadingData`

- `path`: The Firestore collection path to stream data from.

  - Type: `String`

- `builder`: A function to build the data model from JSON.
  - Type: `T Function(Map<String, dynamic>? jsondata, String docId)`

## Constructor

### StreamFirebaseDataSource({required String path, required T Function(Map<String, dynamic>? jsondata, String docId) builder})

Creates a new instance of `StreamFirebaseDataSource`.

**Parameters**:

- `path`: The Firestore collection path to stream data from.
- `builder`: A function to build the data model from JSON.

## Methods

### streamData()

Streams a list of data items from Firebase Firestore.

```dart
Stream<List<T>> streamData();
```

**Returns**: A `Stream` of `List<T>` containing the streamed data items.

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

  static ProductModel fromJson(Map<String, dynamic>? json, String documentId) {
    if (json == null) return ProductModel(name: '', price: 0)..documentId = documentId;

    return ProductModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    )..documentId = documentId;
  }
}

// Create a stream data source
final streamSource = StreamFirebaseDataSource<ProductModel>(
  path: 'products',
  builder: (json, docId) => ProductModel.fromJson(json, docId),
);

// Listen to the stream of products
streamSource.streamData().listen((productList) {
  print('Products updated - count: ${productList.length}');

  for (var product in productList) {
    print('- ${product.name}: \$${product.price} (ID: ${product.documentId})');
  }
});

// In another part of your application, when products are added, updated, or removed
// in the 'products' collection, the stream will automatically emit the updated list
```

## Implementation Details

The `StreamFirebaseDataSource` class uses Firebase Firestore's realtime update capabilities to provide a continuous stream of data. Whenever documents in the specified collection are added, modified, or removed, Firestore will emit a new event, and this class will transform that event into a list of data models.

The class relies on:

1. `FirebaseLoadingData` to handle the streaming functionality by wrapping Firestore's snapshot listeners
2. The provided `builder` function to convert the raw Firestore document data into typed data models

This implementation is particularly useful for UI components that need to reflect the current state of the database in real-time without requiring manual refresh operations.

## Common Use Cases

- Real-time dashboards and displays
- Chat applications
- Live inventory systems
- Collaborative applications where multiple users interact with the same data
- Applications requiring push notifications or live updates

## Related Classes

- `IBaseStream`: The interface that defines the streaming functionality.
- `FirebaseLoadingData`: Provides Firebase data loading and streaming utilities.
- `BaseDataModel`: The base class for all data models.
- `DataSourceFirebaseSource`: The non-streaming counterpart that handles CRUD operations.

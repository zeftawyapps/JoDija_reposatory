# FireStoreAction

`FireStoreAction` is a utility class that provides various Firestore actions such as adding, editing, and deleting documents. It serves as the foundation for Firestore database operations in the application.

## Properties

- `firestoreDocmentid`: The ID of the last added Firestore document.
  - Type: `String`

## Methods

### addDataCloudFirestoreWithoutid()

Adds a document to a Firestore collection without specifying an ID.

```dart
Future<DocumentReference> addDataCloudFirestoreWithoutid({
  required String collection,
  required Map<String, dynamic> mymap,
});
```

**Parameters**:

- `collection`: The name of the collection.
- `mymap`: The data to be added.

**Returns**: A `Future` that completes with a `DocumentReference` of the added document.

### addDataCloudFirestore()

Adds a document to a Firestore collection with an optional ID.

```dart
Future<String> addDataCloudFirestore({
  String? id,
  required String path,
  required Map<String, dynamic> mymap,
});
```

**Parameters**:

- `id`: Optional document ID.
- `path`: The name of the collection.
- `mymap`: The data to be added.

**Returns**: A `Future` that completes with the document ID.

### addDataCloudFirestoreSupCollection()

Adds a document to a Firestore subcollection.

```dart
Future<String> addDataCloudFirestoreSupCollection({
  required String collection,
  required String docId,
  required String subCollection,
  String? id,
  required Map<String, dynamic> mymap,
});
```

**Parameters**:

- `collection`: The name of the parent collection.
- `docId`: The ID of the parent document.
- `subCollection`: The name of the subcollection.
- `id`: Optional document ID.
- `mymap`: The data to be added.

**Returns**: A `Future` that completes with the document ID.

### editDataCloudFirestore()

Edits a document in a Firestore collection.

```dart
Future<void> editDataCloudFirestore({
  required String path,
  required String id,
  required Map<String, dynamic> mymap,
});
```

**Parameters**:

- `path`: The name of the collection.
- `id`: The ID of the document to edit.
- `mymap`: The data to update.

**Returns**: A `Future` that completes when the document is updated.

### editDataCloudFirestoreSubColletion()

Edits a document in a Firestore subcollection.

```dart
Future<void> editDataCloudFirestoreSubColletion({
  required String collection,
  required String docId,
  required String subCollection,
  required String id,
  required Map<String, dynamic> mymap,
});
```

**Parameters**:

- `collection`: The name of the parent collection.
- `docId`: The ID of the parent document.
- `subCollection`: The name of the subcollection.
- `id`: The ID of the document to edit.
- `mymap`: The data to update.

**Returns**: A `Future` that completes when the document is updated.

### deleteDataCloudFirestoreOneDocument()

Deletes a document from a Firestore collection.

```dart
Future<void> deleteDataCloudFirestoreOneDocument({
  required String path,
  required String id,
});
```

**Parameters**:

- `path`: The name of the collection.
- `id`: The ID of the document to delete.

**Returns**: A `Future` that completes when the document is deleted.

### deleteDataCloudFirestoreAllCollection()

Deletes all documents from a Firestore collection.

```dart
Future<void> deleteDataCloudFirestoreAllCollection({
  required String collection,
});
```

**Parameters**:

- `collection`: The name of the collection.

**Returns**: A `Future` that completes when all documents are deleted.

### testFireStore()

A test method to add a document to the "Test" collection.

```dart
Future<void> testFireStore();
```

**Returns**: A `Future` that completes when the test document is added.

## Usage Example

```dart
// Create an instance of FireStoreAction
final fireStoreAction = FireStoreAction();

// Add a new document without specifying ID
final docRef = await fireStoreAction.addDataCloudFirestoreWithoutid(
  collection: 'users',
  mymap: {
    'name': 'John Doe',
    'email': 'john@example.com',
    'age': 30
  }
);
print('Document added with ID: ${docRef.id}');

// Add a new document with a specific ID
final docId = await fireStoreAction.addDataCloudFirestore(
  id: 'user123',
  path: 'users',
  mymap: {
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'age': 28
  }
);
print('Document added with ID: $docId');

// Add a document to a subcollection
final subDocId = await fireStoreAction.addDataCloudFirestoreSupCollection(
  collection: 'users',
  docId: 'user123',
  subCollection: 'addresses',
  mymap: {
    'street': '123 Main St',
    'city': 'New York',
    'country': 'USA'
  }
);
print('Subdocument added with ID: $subDocId');

// Edit a document
await fireStoreAction.editDataCloudFirestore(
  path: 'users',
  id: 'user123',
  mymap: {
    'age': 29,
    'lastUpdated': DateTime.now().toIso8601String()
  }
);

// Edit a document in a subcollection
await fireStoreAction.editDataCloudFirestoreSubColletion(
  collection: 'users',
  docId: 'user123',
  subCollection: 'addresses',
  id: subDocId,
  mymap: {
    'city': 'Los Angeles'
  }
);

// Delete a document
await fireStoreAction.deleteDataCloudFirestoreOneDocument(
  path: 'users',
  id: 'user123'
);
```

## Related Classes

- `FirestoreAndStorageActions`: Extends this class to provide additional functionality for working with Firebase Storage.
- `DataSourceFirebaseSource`: Uses `FireStoreAction` methods for CRUD operations on Firestore.
- `ProfileActions`: Uses `FireStoreAction` methods for profile data management.

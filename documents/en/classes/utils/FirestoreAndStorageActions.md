# FirestoreAndStorageActions

`FirestoreAndStorageActions` is a utility class that handles both Firestore and Storage actions. It extends `FireStoreAction` and mixes in `StorageActions` to provide a comprehensive set of methods for working with both Firebase Firestore and Firebase Storage.

## Inheritance

- Extends: `FireStoreAction`
- Mixes In: `StorageActions`

## Methods

### editeDataCloudFirestorWithUpload()

Edits data in Firestore and uploads a file to Storage if provided.

```dart
Future<dynamic> editeDataCloudFirestorWithUpload({
  required String collection,
  required String id,
  required Map<String, dynamic> mymap,
  Object? file,
  String? filedowloadurifieldname = "imguri",
});
```

**Parameters**:

- `collection`: The Firestore collection name.
- `id`: The document ID to edit.
- `mymap`: The data to update.
- `file`: Optional file to upload.
- `filedowloadurifieldname`: Field name for the file download URL (defaults to "imguri").

**Returns**: A `Future` that completes with the result of the operation.

### editeDataCloudFirestorWithUploadSubCollection()

Edits data in a Firestore subcollection and uploads a file to Storage if provided.

```dart
Future<dynamic> editeDataCloudFirestorWithUploadSubCollection({
  required String collection,
  required String docId,
  required String subcollection,
  required String id,
  String? image = "imageUrl",
  required Map<String, dynamic> mymap,
  Object? file,
});
```

**Parameters**:

- `collection`: The Firestore collection name.
- `docId`: The parent document ID.
- `subcollection`: The subcollection name.
- `id`: The subcollection document ID.
- `image`: Field name for the image URL (defaults to "imageUrl").
- `mymap`: The data to update.
- `file`: Optional file to upload.

**Returns**: A `Future` that completes with the result of the operation.

### addDataCloudFirestorWithUpload()

Adds data to Firestore and uploads a file to Storage if provided.

```dart
Future<String> addDataCloudFirestorWithUpload({
  required String path,
  String? id,
  required Map<String, dynamic> mymap,
  Object? file,
  String dir = "",
  String? filedowloadurifieldname = "imguri",
});
```

**Parameters**:

- `path`: The Firestore collection path.
- `id`: Optional document ID.
- `mymap`: The data to add.
- `file`: Optional file to upload.
- `dir`: Directory for the file (defaults to "").
- `filedowloadurifieldname`: Field name for the file download URL (defaults to "imguri").

**Returns**: A `Future` that completes with the document ID.

### addDataCloudFirestorWithUploadSubCollection()

Adds data to a Firestore subcollection and uploads a file to Storage if provided.

```dart
Future<String> addDataCloudFirestorWithUploadSubCollection({
  required String collection,
  String? id,
  required Map<String, dynamic> mymap,
  Object? file,
  String dir = "",
  required String subcollection,
  required String docId,
  String? imageField = "imguri",
});
```

**Parameters**:

- `collection`: The Firestore collection name.
- `id`: Optional document ID.
- `mymap`: The data to add.
- `file`: Optional file to upload.
- `dir`: Directory for the file (defaults to "").
- `subcollection`: The subcollection name.
- `docId`: The parent document ID.
- `imageField`: Field name for the image URL (defaults to "imguri").

**Returns**: A `Future` that completes with the document ID.

### addDataCloudFirestorWithUploadCollectionPathes()

Adds data to Firestore with collection paths and uploads a file to Storage if provided.

```dart
Future<String> addDataCloudFirestorWithUploadCollectionPathes({
  required String pathes,
  String? id,
  required Map<String, dynamic> mymap,
  Object? file,
  String dir = "",
  String? imageField = "imguri",
});
```

**Parameters**:

- `pathes`: The Firestore collection paths.
- `id`: Optional document ID.
- `mymap`: The data to add.
- `file`: Optional file to upload.
- `dir`: Directory for the file (defaults to "").
- `imageField`: Field name for the image URL (defaults to "imguri").

**Returns**: A `Future` that completes with the document ID.

### editeDataCloudFirestorWithUploadAndReplacementSubCollection()

Edits data in a Firestore subcollection, uploads a file to Storage if provided, and replaces the old file.

```dart
Future<void> editeDataCloudFirestorWithUploadAndReplacementSubCollection({
  required String collection,
  String dir = "",
  required String id,
  required String subcollection,
  required String docid,
  required Map<String, dynamic> mymap,
  Object? file,
  String? iamgeField = "imguri",
  String? oldurl,
});
```

**Parameters**:

- `collection`: The Firestore collection name.
- `dir`: Directory for the file (defaults to "").
- `id`: The document ID to edit.
- `subcollection`: The subcollection name.
- `docid`: The parent document ID.
- `mymap`: The data to update.
- `file`: Optional file to upload.
- `iamgeField`: Field name for the image URL (defaults to "imguri").
- `oldurl`: URL of the old file to delete.

**Returns**: A `Future` that completes when the operation is finished.

### editeDataCloudFirestorWithUploadAndReplacement()

Edits data in Firestore, uploads a file to Storage if provided, and replaces the old file.

```dart
Future<void> editeDataCloudFirestorWithUploadAndReplacement({
  required String path,
  String dir = "",
  required String id,
  required Map<String, dynamic> mymap,
  Object? file,
  String? imageField = "imgur",
  String? oldurl,
});
```

**Parameters**:

- `path`: The Firestore collection path.
- `dir`: Directory for the file (defaults to "").
- `id`: The document ID to edit.
- `mymap`: The data to update.
- `file`: Optional file to upload.
- `imageField`: Field name for the image URL (defaults to "imgur").
- `oldurl`: URL of the old file to delete.

**Returns**: A `Future` that completes when the operation is finished.

### deleteDataCloudFirestorWithdeletFile()

Deletes data from Firestore and deletes the associated file if provided.

```dart
Future<void> deleteDataCloudFirestorWithdeletFile({
  required String path,
  required String id,
  String? oldurl,
});
```

**Parameters**:

- `path`: The Firestore collection path.
- `id`: The document ID to delete.
- `oldurl`: URL of the file to delete.

**Returns**: A `Future` that completes when the operation is finished.

## Usage Example

```dart
// Create an instance of FirestoreAndStorageActions
final firestoreAndStorageActions = FirestoreAndStorageActions();

// Add data with file upload
final id = await firestoreAndStorageActions.addDataCloudFirestorWithUpload(
  path: 'users',
  mymap: {
    'name': 'John Doe',
    'email': 'john@example.com'
  },
  file: myFile,
  filedowloadurifieldname: 'profilePicture'
);

// Edit data with file upload and replacement
await firestoreAndStorageActions.editeDataCloudFirestorWithUploadAndReplacement(
  path: 'users',
  id: 'user123',
  mymap: {
    'name': 'Jane Doe',
    'email': 'jane@example.com'
  },
  file: newFile,
  oldurl: 'https://storage.firebase.com/old-image-url.jpg'
);

// Delete data and file
await firestoreAndStorageActions.deleteDataCloudFirestorWithdeletFile(
  path: 'users',
  id: 'user123',
  oldurl: 'https://storage.firebase.com/image-url.jpg'
);
```

## Related Classes

- `FireStoreAction`: Base class that provides methods for Firestore operations.
- `StorageActions`: Mixin that provides methods for Firebase Storage operations.
- `DataSourceFirebaseSource`: Data source class that uses `FirestoreAndStorageActions` for CRUD operations.

# StorageActions

`StorageActions` is a mixin that provides various storage operations for Firebase Storage, such as uploading, downloading, and deleting files. It handles file storage operations for the application.

## Properties

- `dawenlaodUri`: The download URL of the uploaded file.

  - Type: `String`

- `_filename`: The name of the file being uploaded.

  - Type: `String`
  - Private

- `_directory`: The directory where the file is stored.

  - Type: `String`
  - Private

- `filepath`: The complete path to the file in Firebase Storage.
  - Type: `String`

## Methods

### uploadToStoreage()

Uploads a file to Firebase Storage.

```dart
Future uploadToStoreage(
  Object file, {
  String? dir,
  String? filename,
  String? extention
});
```

**Parameters**:

- `file`: The file to be uploaded (can be `File` or `Uint8List`).
- `dir`: Optional directory where the file will be stored.
- `filename`: Optional name for the file.
- `extention`: Optional file extension.

**Returns**: A `Future` that completes when the upload is successful.

### uploadFileDataStoreage()

Uploads a File object to Firebase Storage.

```dart
Future uploadFileDataStoreage(
  File file, {
  String? dir,
  String? filename
});
```

**Parameters**:

- `file`: The File to be uploaded.
- `dir`: Optional directory where the file will be stored.
- `filename`: Optional name for the file.

**Returns**: A `Future` that completes when the upload is successful.

### uploadBytesDataStoreage()

Uploads a Uint8List to Firebase Storage.

```dart
Future uploadBytesDataStoreage(
  Uint8List file, {
  String? dir,
  required String extntion
});
```

**Parameters**:

- `file`: The Uint8List to be uploaded.
- `dir`: Optional directory where the file will be stored.
- `extntion`: The extension of the file.

**Returns**: A `Future` that completes when the upload is successful.

### downloadURLStoreage()

Gets the download URL for the uploaded file.

```dart
Future<String> downloadURLStoreage();
```

**Returns**: A `Future` that completes with the download URL as a String.

### deleteDataStoreagefromurl()

Deletes a file from Firebase Storage using its URL.

```dart
Future<void> deleteDataStoreagefromurl({required String url});
```

**Parameters**:

- `url`: The URL of the file to be deleted.

**Returns**: A `Future` that completes when the deletion is successful.

### deleteDataStoreageFromPath()

Deletes a file from Firebase Storage using its path.

```dart
Future<void> deleteDataStoreageFromPath({required String path});
```

**Parameters**:

- `path`: The path of the file to be deleted.

**Returns**: A `Future` that completes when the deletion is successful.

## Usage Example

```dart
// Create a class that uses StorageActions mixin
class MyStorageHandler with StorageActions {
  // Methods using StorageActions
}

// Use the storage handler
final storageHandler = MyStorageHandler();

// Upload a file
File imageFile = File('path/to/image.jpg');
await storageHandler.uploadToStoreage(
  imageFile,
  dir: 'user_profiles',
  filename: 'user_123'
);

// Get the download URL
String downloadUrl = await storageHandler.downloadURLStoreage();
print('File uploaded. Download URL: $downloadUrl');

// Delete a file using its URL
await storageHandler.deleteDataStoreagefromurl(
  url: 'https://storage.firebase.com/image-url.jpg'
);

// Delete a file using its path
await storageHandler.deleteDataStoreageFromPath(
  path: 'user_profiles/user_123.jpg'
);
```

## Implementation Details

The `StorageActions` mixin uses Firebase Storage to perform operations:

1. For file uploads, it generates unique filenames based on the current timestamp if a filename is not provided.
2. For byte data uploads, it requires an extension to properly save the file.
3. When deleting files by URL, it extracts the file path from the URL to locate the file in Storage.
4. The download URL is stored in the `dawenlaodUri` property after a successful upload.

## Error Handling

The mixin catches Firebase exceptions during uploads and can be extended to handle these exceptions in specific ways:

```dart
try {
  await storageHandler.uploadToStoreage(imageFile);
} on FirebaseException catch (e) {
  print('Firebase Storage error: ${e.code}');
}
```

## Related Classes

- `FirestoreAndStorageActions`: Combines this mixin with `FireStoreAction` to provide comprehensive Firebase functionality.
- `DataSourceFirebaseSource`: Uses classes with this mixin for file operations.

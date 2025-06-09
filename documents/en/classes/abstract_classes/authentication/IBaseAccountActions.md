# IBaseAccountActions

`IBaseAccountActions` is an abstract class that defines the actions for account and profile data. It provides methods to create, update, and retrieve profile data, as well as methods for handling sub-profile data actions.

## Methods

### createProfileData()

Creates profile data for a user.

```dart
Future createProfileData({required String id, required Map<String, dynamic> data});
```

**Parameters**:

- `id`: The identifier of the user.
- `data`: A map containing the profile data.

**Returns**: A `Future` that completes when the profile data is created.

### updateProfileData()

Updates profile data for a user.

```dart
Future<Map<String, dynamic>> updateProfileData({
  required String id,
  Map<String, dynamic>? mapData,
  Object? file
});
```

**Parameters**:

- `id`: The identifier of the user.
- `mapData`: An optional map containing the updated profile data.
- `file`: An optional file object associated with the profile data.

**Returns**: A `Future` that completes with a map containing the updated profile data.

### getDataByDoc()

Retrieves profile data for a user by document ID.

```dart
Future<Map<String, dynamic>> getDataByDoc(String id);
```

**Parameters**:

- `id`: The identifier of the document.

**Returns**: A `Future` that completes with a map containing the profile data.

### SearchDataById()

Searches for profile data by ID.

```dart
Future<Map<String, dynamic>> SearchDataById(String id);
```

**Parameters**:

- `id`: The identifier to search for.

**Returns**: A `Future` that completes with a map containing the found profile data.

## Implementations

The `IBaseAccountActions` interface is implemented by classes like `ProfileActions` which provide concrete implementations of these methods.

## Usage Example

```dart
// Create an instance of a class implementing IBaseAccountActions
ProfileActions profileActions = ProfileActions();

// Create a user profile
await profileActions.createProfileData(
  id: 'user123',
  data: {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'age': 30,
  },
);

// Update a user profile
Map<String, dynamic> updatedProfile = await profileActions.updateProfileData(
  id: 'user123',
  mapData: {'age': 31},
);

// Get user profile data
Map<String, dynamic> profileData = await profileActions.getDataByDoc('user123');
```

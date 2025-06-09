# BaseProfilRebo

`BaseProfilRebo` is a repository class for managing user profiles. It provides methods to retrieve and edit user profiles using the provided account actions interface.

## Properties

- `_accountActions`: Manages account actions like creating and updating profile data.
  - Type: `IBaseAccountActions`

## Constructors

### BaseProfilRebo(IBaseAccountActions accountActions)

Creates a new instance of `BaseProfilRebo`.

**Parameters**:

- `accountActions`: The account actions interface implementation.

## Methods

### getProfile(String uid)

Retrieves the user profile for the given user ID.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> getProfile(String uid);
```

**Parameters**:

- `uid`: The user ID.

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### editProfile({String? id, UsersBaseModel? data, Object? file})

Edits the user profile for the given user ID.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> editProfile({
  String? id,
  UsersBaseModel? data,
  Object? file
});
```

**Parameters**:

- `id`: The user ID.
- `data`: The updated user model.
- `file`: An optional file object (e.g., profile picture).

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

## Usage Example

```dart
// Create account actions source
IBaseAccountActions profileActions = ProfileActions();

// Create repository
BaseProfilRebo profileRepo = BaseProfilRebo(profileActions);

// Get user profile
var result = await profileRepo.getProfile('user123');
result.when(
  data: (userProfile) {
    print('User name: ${userProfile.name}');
    print('User email: ${userProfile.email}');
  },
  error: (error) {
    print('Failed to get profile: ${error.message}');
  }
);

// Edit user profile
File profilePicture = File('path/to/image.jpg');
var user = UsersBaseModel(
  name: 'Updated Name',
  email: 'user@example.com',
  map: {'phone': '123-456-7890'}
);

var updateResult = await profileRepo.editProfile(
  id: 'user123',
  data: user,
  file: profilePicture
);

updateResult.when(
  data: (updatedProfile) {
    print('Profile updated: ${updatedProfile.name}');
  },
  error: (error) {
    print('Failed to update profile: ${error.message}');
  }
);
```

## Error Handling

The class handles Firebase exceptions by converting them to user-friendly error messages using the `handilExcepstons` function, which is part of the `fireBase_exception_consts` utility.

## Related Classes

- `IBaseAccountActions`: Abstract interface for account and profile actions.
- `ProfileActions`: Implementation of `IBaseAccountActions` that interacts with Firebase.
- `UsersBaseModel`: User data model.
- `RemoteBaseModel`: Generic model for remote data operations.
- `Result`: Generic result type that can contain either success data or error information.

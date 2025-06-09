# BaseAuthRepo

`BaseAuthRepo` is a repository class for handling authentication-related operations. It provides methods for logging in, creating accounts, and managing user profiles. The class supports both HTTP and Firebase authentication mechanisms.

## Properties

- `_accountActions`: Manages account actions like creating and updating profile data.

  - Type: `IBaseAccountActions`

- `_account`: Handles authentication operations.
  - Type: `IBaseAuthentication`

## Constructors

### BaseAuthRepo(IBaseAuthentication account, {IBaseAccountActions? accountActions})

Creates a new instance of `BaseAuthRepo`.

**Parameters**:

- `account`: The authentication account interface implementation.
- `accountActions`: Optional account actions interface implementation. If not provided, defaults to `ProfileActions`.

## Methods

### logIn()

Logs in the user using either HTTP or Firebase authentication, depending on the type of `_account`.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> logIn();
```

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### createAccount()

Creates a new account using either HTTP or Firebase authentication, depending on the type of `_account`.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> createAccount();
```

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### createAccountAndProfile(UsersBaseModel usersModel)

Creates a new account and profile using either HTTP or Firebase authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> createAccountAndProfile(UsersBaseModel usersModel);
```

**Parameters**:

- `usersModel`: The user model containing profile data.

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### lagOut()

Logs out the currently authenticated user.

```dart
Future lagOut();
```

**Returns**: A `Future` that completes when the logout operation is finished.

## Private Methods

### \_logInFirebase()

Logs in the user using Firebase authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> _logInFirebase();
```

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### \_logInHttp()

Logs in the user using HTTP authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> _logInHttp();
```

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### \_createAccountFirebase()

Creates a new account using Firebase authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> _createAccountFirebase();
```

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### \_createAccountHttp()

Creates a new account using HTTP authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> _createAccountHttp();
```

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### \_createAccountAndProfileFirebase(UsersBaseModel usersModel)

Creates a new account and profile using Firebase authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> _createAccountAndProfileFirebase(UsersBaseModel usersModel);
```

**Parameters**:

- `usersModel`: The user model containing profile data.

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

### \_createAccountAndProfileHttp(UsersBaseModel usersModel)

Creates a new account and profile using HTTP authentication.

```dart
Future<Result<RemoteBaseModel, UsersBaseModel>> _createAccountAndProfileHttp(UsersBaseModel usersModel);
```

**Parameters**:

- `usersModel`: The user model containing profile data.

**Returns**: A `Result` containing either a `RemoteBaseModel` (error) or a `UsersBaseModel` (success).

## Usage Example

```dart
// Create authentication source
IBaseAuthentication authSource = EmailPassowrdAuthSource(
  email: 'user@example.com',
  password: 'password123'
);

// Create repository
BaseAuthRepo authRepo = BaseAuthRepo(authSource);

// Login
var result = await authRepo.logIn();
result.when(
  data: (user) {
    print('Login successful: ${user.name}');
    print('User ID: ${user.uid}');
  },
  error: (error) {
    print('Login failed: ${error.message}');
  }
);

// Create account and profile
var userModel = UsersBaseModel(
  name: 'John Doe',
  email: 'john.doe@example.com'
);

var createResult = await authRepo.createAccountAndProfile(userModel);
createResult.when(
  data: (user) {
    print('Account created: ${user.uid}');
  },
  error: (error) {
    print('Account creation failed: ${error.message}');
  }
);

// Logout
await authRepo.lagOut();
```

## Related Classes

- `IBaseAuthentication`: Abstract interface for authentication operations.
- `IBaseAccountActions`: Abstract interface for account and profile actions.
- `IFirebaseAuthentication`: Firebase-specific authentication interface.
- `IHttpAuthentication`: HTTP-specific authentication interface.
- `ProfileActions`: Implementation for managing user profiles.
- `UsersBaseModel`: User data model.

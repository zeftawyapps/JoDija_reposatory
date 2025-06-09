# GoogleAuthSoucre

`GoogleAuthSoucre` is an implementation of the `IFirebaseAuthentication` interface that provides Google Sign-In authentication using Firebase Authentication services. It handles user operations such as login, account creation, and logout using Google as the authentication provider.

## Properties

- `_accountRegist`: Firebase account operations helper.
  - Type: `FirebaseAccount?`

## Constructor

### GoogleAuthSoucre()

Creates a new instance of `GoogleAuthSoucre` and initializes the Firebase account helper.

## Methods

### createAccount({Map<String, dynamic>? body})

Creates a new user account or signs in using Google Authentication.

```dart
Future<UsersBaseModel> createAccount({Map<String, dynamic>? body});
```

**Parameters**:

- `body`: An optional map containing additional data for account creation.

**Returns**: A `Future` that completes with a `UsersBaseModel` containing the user account details.

### logIn()

Logs in a user using Google Authentication.

```dart
Future<UsersBaseModel> logIn();
```

**Returns**: A `Future` that completes with a `UsersBaseModel` containing the authenticated user details.

### logOut()

Logs out the currently authenticated user from Firebase Authentication.

```dart
Future logOut();
```

**Returns**: A `Future` that completes when the logout operation is finished.

### \_signInWithGoogle() [private]

Handles the Google Sign-In authentication flow.

```dart
Future<UserCredential?> _signInWithGoogle();
```

**Returns**: A `Future` that completes with a `UserCredential` if authentication is successful, or `null` otherwise.

## Usage Example

```dart
// Create a Google authentication instance
GoogleAuthSoucre authSource = GoogleAuthSoucre();

// Login with Google
try {
  UsersBaseModel user = await authSource.logIn();
  print('User logged in with Google:');
  print('- Name: ${user.name}');
  print('- Email: ${user.email}');
  print('- ID: ${user.uid}');
  print('- Token: ${user.token}');
} catch (e) {
  print('Google login failed: $e');
}

// Create an account with Google
// Note: For Google authentication, createAccount() and logIn()
// perform similar operations since the user's Google account already exists
try {
  UsersBaseModel newUser = await authSource.createAccount();
  print('User authenticated with Google:');
  print('- Name: ${newUser.name}');
  print('- Email: ${newUser.email}');
  print('- ID: ${newUser.uid}');
} catch (e) {
  print('Google authentication failed: $e');
}

// Logout
await authSource.logOut();
```

## Implementation Details

The `GoogleAuthSoucre` class implements the `IFirebaseAuthentication` interface, which extends `IBaseAuthentication`. It uses the `FirebaseAccount` utility class for basic Firebase operations, along with the `GoogleSignIn` package to handle Google authentication.

### Google Authentication Process

1. Initiates the Google Sign-In flow using the `GoogleSignIn` package
2. Gets the user's Google authentication credentials
3. Uses those credentials to authenticate with Firebase
4. Retrieves the user's authentication token
5. Constructs and returns a `UsersBaseModel` with the user details

### Error Handling

The class handles several specific Firebase Authentication errors:

- `account-exists-with-different-credential`: When the email is already in use with a different login method
- `invalid-credential`: When the provided Google credentials are invalid
- Other generic errors

## Dependencies

- `firebase_auth`: For Firebase Authentication services
- `google_sign_in`: For Google Sign-In functionality

## Related Classes

- `IFirebaseAuthentication`: The interface that defines Firebase authentication operations.
- `FirebaseAccount`: Utility class for Firebase Authentication operations.
- `UsersBaseModel`: User data model containing authentication details.
- `BaseAuthRepo`: Repository class that uses authentication interfaces.
- `GoogleSignIn`: Package for handling Google Sign-In processes.

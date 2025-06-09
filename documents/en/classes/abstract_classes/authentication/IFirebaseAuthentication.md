# IFirebaseAuthentication

`IFirebaseAuthentication` is an abstract interface that extends `IBaseAuthentication` to provide Firebase-specific authentication functionality. It defines methods for authenticating users with Firebase services.

## Extends

- `IBaseAuthentication`: The base authentication interface.

## Methods

### logIn()

Logs in a user using Firebase authentication services.

```dart
Future<UserResult> logIn();
```

**Returns**: A `Future` that completes with a `UserResult` object containing authentication details like user ID and authentication token.

### createAccount()

Creates a new user account using Firebase Authentication.

```dart
Future<UserResult> createAccount();
```

**Returns**: A `Future` that completes with a `UserResult` object containing the newly created account details.

### logOut()

Logs out the currently authenticated user from Firebase.

```dart
Future logOut();
```

**Returns**: A `Future` that completes when the logout operation is finished.

## Implementations

Common implementations of the `IFirebaseAuthentication` interface include:

- `EmailPassowrdAuthSource`: For email and password authentication with Firebase.
- `GoogleAuthSoucre`: For Google Sign-In authentication with Firebase.

## Usage Example

```dart
// Create an authentication instance
EmailPassowrdAuthSource authSource = EmailPassowrdAuthSource(
  email: 'user@example.com',
  password: 'password123'
);

// Login
try {
  UserResult user = await authSource.logIn();
  print('User logged in: ${user.uid}');
  print('Auth token: ${user.token}');
} catch (e) {
  print('Login failed: $e');
}

// Create an account
try {
  UserResult newUser = await authSource.createAccount();
  print('New user created: ${newUser.uid}');
} catch (e) {
  print('Account creation failed: $e');
}

// Logout
await authSource.logOut();
```

## Related Classes

- `BaseAuthRepo`: A repository class that uses `IFirebaseAuthentication` to handle authentication operations.
- `ProfileActions`: A class that handles user profile data after authentication.

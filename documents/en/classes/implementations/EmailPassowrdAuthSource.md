# EmailPassowrdAuthSource

`EmailPassowrdAuthSource` is an implementation of the `IFirebaseAuthentication` interface that provides email and password-based authentication using Firebase Authentication services. It handles user operations such as login, account creation, and logout.

## Properties

- `email`: The email address for authentication.

  - Type: `String?`

- `pass`: The password for authentication.

  - Type: `String?`

- `name`: The optional user name.

  - Type: `String?`

- `_accountRegist`: Firebase account operations helper.
  - Type: `FirebaseAccount?`

## Constructor

### EmailPassowrdAuthSource({required String email, required String pass, String? name})

Creates a new instance of `EmailPassowrdAuthSource`.

**Parameters**:

- `email`: The email address for authentication.
- `pass`: The password for authentication.
- `name`: The optional user name (optional).

## Methods

### createAccount({Map<String, dynamic>? body})

Creates a new user account using Firebase Authentication with email and password.

```dart
Future<UsersBaseModel> createAccount({Map<String, dynamic>? body});
```

**Parameters**:

- `body`: An optional map containing additional data for account creation.

**Returns**: A `Future` that completes with a `UsersBaseModel` containing the newly created account details.

### logIn()

Logs in a user using Firebase Authentication with email and password.

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

## Usage Example

```dart
// Create an authentication instance
EmailPassowrdAuthSource authSource = EmailPassowrdAuthSource(
  email: 'user@example.com',
  pass: 'secure_password123',
  name: 'John Doe'
);

// Login
try {
  UsersBaseModel user = await authSource.logIn();
  print('User logged in:');
  print('- Name: ${user.name}');
  print('- Email: ${user.email}');
  print('- ID: ${user.uid}');
  print('- Token: ${user.token}');
} catch (e) {
  print('Login failed: $e');
}

// Create an account
try {
  UsersBaseModel newUser = await authSource.createAccount();
  print('New user created:');
  print('- Name: ${newUser.name}');
  print('- Email: ${newUser.email}');
  print('- ID: ${newUser.uid}');
} catch (e) {
  print('Account creation failed: $e');
}

// Logout
await authSource.logOut();
```

## Implementation Details

The `EmailPassowrdAuthSource` class implements the `IFirebaseAuthentication` interface, which extends `IBaseAuthentication`. It uses the `FirebaseAccount` utility class to interact with Firebase Authentication services.

### Account Creation Process

1. Uses `FirebaseAccount.createNewAccount()` to create a Firebase user account
2. Updates the user's display name if provided
3. Retrieves the user's authentication token
4. Constructs and returns a `UsersBaseModel` with the user details

### Login Process

1. Uses `FirebaseAccount.logIn()` to authenticate the user with Firebase
2. Retrieves the user's authentication token
3. Constructs and returns a `UsersBaseModel` with the user details

### Error Handling

The class handles Firebase Authentication errors by propagating them to the caller. Common errors include:

- Invalid email format
- Weak password
- Email already in use
- User not found
- Wrong password

## Firebase Authentication Features Used

- Email/Password sign-in
- User token retrieval
- User display name updates
- Sign-out functionality

## Related Classes

- `IFirebaseAuthentication`: The interface that defines Firebase authentication operations.
- `FirebaseAccount`: Utility class for Firebase Authentication operations.
- `UsersBaseModel`: User data model containing authentication details.
- `BaseAuthRepo`: Repository class that uses authentication interfaces.

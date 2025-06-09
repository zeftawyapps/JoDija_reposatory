# IHttpAuthentication

`IHttpAuthentication` is an abstract interface that extends `IBaseAuthentication` to provide HTTP-specific authentication functionality. It defines methods for authenticating users via HTTP requests.

## Extends

- `IBaseAuthentication`: The base authentication interface.

## Methods

### logIn()

Logs in a user using HTTP authentication.

```dart
Future<UserResult> logIn();
```

**Returns**: A `Future` that completes with a `UserResult` object containing authentication details like user ID and authentication token.

### createAccount()

Creates a new user account using HTTP authentication.

```dart
Future<UserResult> createAccount({Map<String, dynamic>? body});
```

**Parameters**:

- `body`: An optional map containing additional data for account creation.

**Returns**: A `Future` that completes with a `UserResult` object containing the newly created account details.

### logOut()

Logs out the currently authenticated user.

```dart
Future logOut();
```

**Returns**: A `Future` that completes when the logout operation is finished.

## Implementations

Common implementations of the `IHttpAuthentication` interface include:

- `AuthHttpSource`: For HTTP authentication with email and password.

## Usage Example

```dart
// Create an authentication instance
AuthHttpSource authSource = AuthHttpSource(
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

// Create an account with additional data
try {
  Map<String, dynamic> additionalData = {
    'name': 'John Doe',
    'age': 30
  };

  UserResult newUser = await authSource.createAccount(body: additionalData);
  print('New user created: ${newUser.uid}');
} catch (e) {
  print('Account creation failed: $e');
}

// Logout
await authSource.logOut();
```

## Related Classes

- `BaseAuthRepo`: A repository class that uses `IHttpAuthentication` to handle authentication operations.
- `HttpHeader`: Manages HTTP headers for authentication.
- `JodijaHttpClient`: Handles HTTP requests.

# AuthHttpSource

`AuthHttpSource` is an implementation of the `IHttpAuthentication` interface that provides HTTP-based authentication functionality. It handles user authentication operations such as login, account creation, and logout through HTTP API requests.

## Properties

- `email`: The email address for authentication.

  - Type: `String?`

- `pass`: The password for authentication.

  - Type: `String?`

- `name`: The optional user name.
  - Type: `String?`

## Constructor

### AuthHttpSource({required String email, required String pass})

Creates a new instance of `AuthHttpSource`.

**Parameters**:

- `email`: The email address for authentication.
- `pass`: The password for authentication.

## Methods

### createAccount({Map<String, dynamic>? body})

Creates a new user account using HTTP authentication.

```dart
Future<UsersBaseModel> createAccount({Map<String, dynamic>? body});
```

**Parameters**:

- `body`: An optional map containing additional data for account creation.

**Returns**: A `Future` that completes with a `UsersBaseModel` containing the newly created account details.

### logIn()

Logs in a user using HTTP authentication.

```dart
Future<UsersBaseModel> logIn();
```

**Returns**: A `Future` that completes with a `UsersBaseModel` containing the authenticated user details.

### logOut()

Logs out the currently authenticated user.

```dart
Future logOut();
```

**Returns**: A `Future` that completes when the logout operation is finished.

## Usage Example

```dart
// Create an authentication instance
AuthHttpSource authSource = AuthHttpSource(
  email: 'user@example.com',
  password: 'secure_password123'
);

// Login
try {
  UsersBaseModel user = await authSource.logIn();
  print('User logged in: ${user.name}');
  print('User ID: ${user.uid}');
  print('Auth token: ${user.token}');
} catch (e) {
  print('Login failed: $e');
}

// Create an account with additional data
try {
  Map<String, dynamic> userData = {
    'name': 'John Doe',
    'age': 30,
    'role': 'user'
  };

  UsersBaseModel newUser = await authSource.createAccount(body: userData);
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

The `AuthHttpSource` class implements the `IHttpAuthentication` interface, which extends `IBaseAuthentication`. It uses the `HttpClient` class to make HTTP requests to authentication API endpoints.

### Account Creation Process

1. Combines provided credentials with any additional user data
2. Sends a POST request to the account creation API endpoint
3. Processes the server response to extract user data
4. Returns a `UsersBaseModel` with the user details

### Login Process

1. Sends a POST request with the user's credentials to the login API endpoint
2. Validates the response status code
3. Extracts the authentication token and user data
4. Returns a `UsersBaseModel` with the authentication details

### Error Handling

The class includes error handling for HTTP request failures, server errors, and authentication failures. If the server returns an error status code or the request fails, an exception is thrown with details about the error.

## API Endpoints

The class uses the following API endpoints defined in the `ApiUrls` class:

- `ApiUrls.createAccount`: For account creation
- `ApiUrls.logIn`: For user login

## Related Classes

- `IHttpAuthentication`: The interface that defines HTTP-based authentication operations.
- `UsersBaseModel`: User data model containing authentication details.
- `HttpClient`: Class for handling HTTP requests.
- `HttpMethod`: Enum defining HTTP method types.
- `HttpHeader`: Manages HTTP headers for authentication.
- `BaseAuthRepo`: Repository class that uses authentication interfaces.

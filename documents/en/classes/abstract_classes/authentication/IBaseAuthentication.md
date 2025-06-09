# IBaseAuthentication

`IBaseAuthentication` is an abstract class that defines the basic authentication operations for user accounts. It provides methods for user login, logout, and account creation.

## Methods

### logIn()

Logs in a user.

```dart
Future<UserResult> logIn();
```

**Returns**: A `Future` that completes with a `UserResult` object containing authentication details.

### createAccount()

Creates a new user account.

```dart
Future<UserResult> createAccount();
```

**Returns**: A `Future` that completes with a `UserResult` object containing the newly created account details.

### logOut()

Logs out the currently authenticated user.

```dart
Future logOut();
```

**Returns**: A `Future` that completes when the logout operation is finished.

## Implementations

The `IBaseAuthentication` interface is implemented by more specific authentication interfaces:

- `IFirebaseAuthentication`: For Firebase-based authentication.
- `IHttpAuthentication`: For HTTP-based authentication.

## Usage Example

```dart
class FirebaseEmailPasswordAuth implements IFirebaseAuthentication {
  final String email;
  final String password;

  FirebaseEmailPasswordAuth({required this.email, required this.password});

  @override
  Future<UserResult> logIn() async {
    // Implementation using Firebase Authentication
    try {
      // Firebase authentication logic
      var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return user result
      return UserResult(
        uid: userCredential.user?.uid,
        token: await userCredential.user?.getIdToken(),
      );
    } catch (e) {
      // Handle errors
      throw e;
    }
  }

  // Implement other methods...
}
```

# JodijaHttpClient

`JodijaHttpClient` is a utility class that provides HTTP client functionality for making network requests. It uses the Dio package for HTTP operations and handles common request/response processing.

## Properties

- `_instance`: The singleton instance of the class.

  - Type: `JodijaHttpClient`
  - Static
  - Private

- `_dio`: The Dio HTTP client instance.

  - Type: `Dio`
  - Private

- `baseUrl`: The base URL for all HTTP requests.

  - Type: `String`

- `userToken`: Whether to include the user token in requests.
  - Type: `bool`

## Constructors

### JodijaHttpClient({bool userToken = false, String baseUrl = ""})

Creates a new instance of `JodijaHttpClient`. Uses the singleton pattern.

**Parameters**:

- `userToken`: Whether to include the user token in requests (default: `false`).
- `baseUrl`: The base URL for all requests (default: `""`).

### JodijaHttpClient.\_internal()

Internal constructor for the singleton pattern.

## Methods

### sendRequestResultWithMap()

Sends an HTTP request and returns the result with a Map.

```dart
Future<HttpLoadingData> sendRequestResultWithMap({
  required HttpMethod method,
  required String url,
  Map<String, dynamic>? body,
  Map<String, String>? parameters,
  Map<String, dynamic>? headers,
  required CancelToken cancelToken,
});
```

**Parameters**:

- `method`: The HTTP method to use (GET, POST, PUT, DELETE).
- `url`: The endpoint URL.
- `body`: Optional request body.
- `parameters`: Optional URL parameters.
- `headers`: Optional HTTP headers.
- `cancelToken`: Token for canceling the request.

**Returns**: A `Future` that completes with an `HttpLoadingData` object.

### sendRequestResult()

Sends an HTTP request and returns the result.

```dart
Future<HttpLoadingData<T>> sendRequestResult<T>({
  required HttpMethod method,
  required String url,
  Map<String, dynamic>? body,
  Map<String, dynamic>? parameters,
  Map<String, dynamic>? headers,
  required CancelToken cancelToken,
});
```

**Parameters**:

- `method`: The HTTP method to use (GET, POST, PUT, DELETE).
- `url`: The endpoint URL.
- `body`: Optional request body.
- `parameters`: Optional URL parameters.
- `headers`: Optional HTTP headers.
- `cancelToken`: Token for canceling the request.

**Returns**: A `Future` that completes with an `HttpLoadingData<T>` object.

## Private Methods

### \_createDio()

Creates and configures a Dio instance.

```dart
Dio _createDio({required bool userToken});
```

**Parameters**:

- `userToken`: Whether to include the user token in requests.

**Returns**: A configured `Dio` instance.

## Usage Example

```dart
// Create an HTTP client instance
final httpClient = JodijaHttpClient(userToken: true, baseUrl: 'https://api.example.com');

// Make a GET request
var result = await httpClient.sendRequestResultWithMap(
  method: HttpMethod.GET,
  url: '/users',
  parameters: {'page': '1', 'limit': '10'},
  cancelToken: CancelToken()
);

if (result.data != null) {
  print('Success: ${result.data}');
} else {
  print('Error: ${result.error}');
}

// Make a POST request
var createResult = await httpClient.sendRequestResultWithMap(
  method: HttpMethod.POST,
  url: '/users',
  body: {
    'name': 'John Doe',
    'email': 'john@example.com'
  },
  cancelToken: CancelToken()
);

if (createResult.data != null) {
  print('User created: ${createResult.data}');
} else {
  print('Error: ${createResult.error}');
}
```

## Error Handling

The class handles HTTP errors and wraps them in the `HttpLoadingData` class:

```dart
try {
  var result = await httpClient.sendRequestResultWithMap(
    method: HttpMethod.GET,
    url: '/users',
    cancelToken: CancelToken()
  );

  // Check for errors
  if (result.error != null) {
    print('Error: ${result.error.message}');
    print('Status code: ${result.error.statusCode}');
  } else {
    print('Success!');
  }
} catch (e) {
  print('Unexpected error: $e');
}
```

## Authentication

The class can automatically include authentication tokens in requests when `userToken` is set to `true`:

```dart
// First set the auth header with HttpHeader class
HttpHeader().setAuthHeader('your-auth-token');

// Then create a client with userToken: true
final httpClient = JodijaHttpClient(userToken: true);

// The request will include the authentication header automatically
var result = await httpClient.sendRequestResultWithMap(
  method: HttpMethod.GET,
  url: '/protected-resource',
  cancelToken: CancelToken()
);
```

## Related Classes

- `HttpLoadingData`: Data structure for HTTP response.
- `HttpMethod`: Enum defining HTTP methods (GET, POST, PUT, DELETE).
- `HttpHeader`: Utility for setting HTTP headers, particularly authentication.
- `DataSourceDataActionsHttpSources`: Uses `JodijaHttpClient` for data operations.
- `AuthHttpSource`: Uses `JodijaHttpClient` for authentication operations.

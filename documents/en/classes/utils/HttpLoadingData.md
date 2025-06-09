# HttpLoadingData

`HttpLoadingData` is a generic class that represents the data loaded from HTTP requests. It holds either the successful result data or error information from an HTTP request.

## Type Parameters

- `T`: The type of data expected in the response.

## Properties

- `data`: The data retrieved from a successful HTTP request.

  - Type: `T?` (nullable)

- `error`: Error information if the HTTP request failed.
  - Type: `HttpLoadingDataError?` (nullable)

## Constructors

### HttpLoadingData({T? data, HttpLoadingDataError? error})

Creates a new instance of `HttpLoadingData`.

**Parameters**:

- `data`: The data from a successful HTTP request.
- `error`: Error information from a failed HTTP request.

## Nested Classes

### HttpLoadingDataError

Inner class that represents error information from an HTTP request.

#### Properties

- `message`: The error message.

  - Type: `String`

- `statusCode`: The HTTP status code associated with the error.
  - Type: `int?` (nullable)

#### Constructors

##### HttpLoadingDataError({required String message, int? statusCode})

Creates a new instance of `HttpLoadingDataError`.

**Parameters**:

- `message`: The error message.
- `statusCode`: The HTTP status code.

## Methods

### isSuccessful()

Checks if the HTTP request was successful.

```dart
bool isSuccessful();
```

**Returns**: `true` if the request was successful and data is available, `false` otherwise.

### isError()

Checks if the HTTP request resulted in an error.

```dart
bool isError();
```

**Returns**: `true` if the request failed and error information is available, `false` otherwise.

## Usage Example

```dart
// Create a successful response
var successResponse = HttpLoadingData<Map<String, dynamic>>(
  data: {
    'id': 1,
    'name': 'John Doe',
    'email': 'john@example.com'
  }
);

// Check if successful
if (successResponse.isSuccessful()) {
  print('User ID: ${successResponse.data!['id']}');
  print('User Name: ${successResponse.data!['name']}');
}

// Create an error response
var errorResponse = HttpLoadingData<Map<String, dynamic>>(
  error: HttpLoadingDataError(
    message: 'Resource not found',
    statusCode: 404
  )
);

// Check if error
if (errorResponse.isError()) {
  print('Error: ${errorResponse.error!.message}');
  print('Status Code: ${errorResponse.error!.statusCode}');
}
```

## Using with JodijaHttpClient

The `HttpLoadingData` class is commonly used as the return type for HTTP client requests:

```dart
// Make a request with JodijaHttpClient
var httpClient = JodijaHttpClient();
var result = await httpClient.sendRequestResultWithMap(
  method: HttpMethod.GET,
  url: '/users/1',
  cancelToken: CancelToken()
);

// Handle the result
if (result.isSuccessful()) {
  var userData = result.data!;
  print('User data: $userData');
} else {
  print('Error: ${result.error!.message}');
  if (result.error!.statusCode == 404) {
    print('User not found');
  } else if (result.error!.statusCode == 401) {
    print('Unauthorized access');
  }
}
```

## Error Handling

The class provides a clean way to handle both successful and error responses:

```dart
Future<void> fetchUserData(String userId) async {
  var httpClient = JodijaHttpClient();
  var result = await httpClient.sendRequestResult<Map<String, dynamic>>(
    method: HttpMethod.GET,
    url: '/users/$userId',
    cancelToken: CancelToken()
  );

  if (result.isSuccessful()) {
    // Process the data
    var userData = result.data!;
    updateUserInterface(userData);
  } else {
    // Handle the error
    switch (result.error!.statusCode) {
      case 400:
        showErrorMessage('Bad request');
        break;
      case 401:
        redirectToLogin();
        break;
      case 404:
        showErrorMessage('User not found');
        break;
      default:
        showErrorMessage('An error occurred: ${result.error!.message}');
    }
  }
}
```

## Related Classes

- `JodijaHttpClient`: Uses `HttpLoadingData` as the return type for HTTP requests.
- `DataSourceDataActionsHttpSources`: Uses `HttpLoadingData` for handling HTTP results.
- `AuthHttpSource`: Uses `HttpLoadingData` for authentication operations.

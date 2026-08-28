# HTTP Error Handling Architecture

The JoDija Repository library provides a robust, strongly-typed error handling hierarchy for HTTP and network operations. When `HttpClient` encounters network or server errors, it maps them into specific subclasses of `BaseError`.

---

## Base Class: `BaseError`

All HTTP errors in the library inherit from `BaseError`:

```dart
abstract class BaseError {
  final String message;
  final int? statusCode;
  final dynamic data;

  BaseError(this.message, {this.statusCode, this.data});
}
```

---

## Error Classes Reference

| Error Class | Status Code | Description | Typical Cause |
| :--- | :--- | :--- | :--- |
| `BadRequestError` | `400` | The server could not understand the request due to invalid syntax or invalid body params. | Validation errors, malformed JSON. |
| `UnauthorizedError` | `401` | The request requires user authentication or the token has expired. | Missing / expired JWT in `HttpHeader`. |
| `ForbiddenError` | `403` | The server understood the request but refuses to authorize it. | User lacks permissions / role. |
| `NotFoundError` | `404` | The requested endpoint or resource was not found on the server. | Wrong API URL or missing resource ID. |
| `ConflictError` | `409` | The request conflicts with current server state. | Duplicate email/phone registration. |
| `InternalServerError` | `500` | The server encountered an unexpected condition. | Unhandled backend exception / database crash. |
| `TimeoutError` | N/A | The request timed out (connect, send, or receive timeout). | Slow internet or unresponsive server. |
| `ConnectionError` | N/A | Failed to establish connection with the server. | No active internet or DNS failure. |
| `SocketError` | N/A | Low-level OS socket error during communication. | Connection aborted or reset by peer. |
| `FormatError` | N/A | Response data could not be parsed into expected format. | Server returned HTML instead of JSON. |
| `CancelError` | N/A | The request was explicitly cancelled via `CancelToken`. | User navigated away before request finished. |
| `CustomError` | Variable | Custom application-level error wrapper. | Custom business rule failure from backend. |
| `UnknownError` | N/A | Uncategorized fallback error. | Unexpected runtime exceptions. |

---

## Handling Errors in Repositories & UI

When executing repository operations, errors are contained within `Result` objects or handled directly:

```dart
var result = await productRepo.loadData();

if (result.isSuccess) {
  print('Loaded products: ${result.data}');
} else {
  // Handle strongly typed errors
  final error = result.error;
  if (error is UnauthorizedError) {
    // Redirect user to login screen
  } else if (error is ConnectionError || error is TimeoutError) {
    // Show offline / retry banner
  } else {
    // Show error message
    print(error?.message ?? 'An unknown error occurred');
  }
}
```

---

## Related Classes

- [`HttpClient`](JodijaHttpClient.md): Intercepts Dio errors and transforms them into `BaseError` instances.
- [`Result`](../results/result.md): Encapsulates success data or error instances.

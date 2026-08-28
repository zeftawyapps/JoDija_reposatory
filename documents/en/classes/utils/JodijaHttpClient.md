# HttpClient (formerly JodijaHttpClient)

`HttpClient` is a centralized HTTP client utility class that manages network requests using the `Dio` package. It handles JSON serialization, request and response headers (including auth tokens and `x-lang` language codes), logging, timeouts, file uploads, and transforms Dio exceptions into strongly-typed [`BaseError`](HttpErrors.md) instances.

---

## Properties

- `baseUrl`: The base URL for all HTTP requests (defaults to `HttpUrlsEnveiroment().baseUrl`).
  - Type: `String?`
- `userToken`: Whether to automatically attach the authentication token from `HttpHeader`.
  - Type: `bool?` (default: `false`)
- `instance`: Returns the underlying configured `Dio` client instance.
  - Type: `Dio`

---

## Constructors

### `HttpClient({String? baseUrl, bool? userToken = false})`

Creates or configures an `HttpClient` instance.

**Parameters**:
- `baseUrl`: Optional custom base URL. If omitted, uses `HttpUrlsEnveiroment().baseUrl`.
- `userToken`: If `true`, reads the token from `HttpHeader().usertoken` and adds the `Authorization: Bearer <token>` header.

---

## Supported HTTP Methods (`HttpMethod`)

```dart
enum HttpMethod { 
  GET, 
  POST, 
  PUT, 
  DELETE, 
  PATCH 
}
```

---

## Primary Request Methods

### 1. `sendRequestValue<T>()`

Sends an HTTP request and parses the response into type `T`.

```dart
Future<T> sendRequestValue<T>({
  required HttpMethod method,
  required String url,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic>? body,
  required CancelToken cancelToken,
});
```

---

### 2. `sendRequestResult<T>()`

Sends an HTTP request and returns an encapsulated `HttpLoadingData<T>` containing either data or a typed `BaseError`.

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

---

## Language & Authentication Headers Integration

`HttpClient` automatically integrates with [`HttpHeader`](HttpHeader.md):

```dart
// 1. Set language globally in app
HttpHeader().setLangHeader(lang: 'ar');

// 2. Set auth token on user login
HttpHeader().setAuthHeader('jwt_token_here');

// 3. Make request - HttpClient automatically attaches 'x-lang: ar' and 'Authorization'
final client = HttpClient(userToken: true);
```

---

## Error Handling

All Dio errors are intercepted and mapped into specialized error classes:
- Status `400` $\rightarrow$ `BadRequestError`
- Status `401` $\rightarrow$ `UnauthorizedError`
- Status `403` $\rightarrow$ `ForbiddenError`
- Status `404` $\rightarrow$ `NotFoundError`
- Status `409` $\rightarrow$ `ConflictError`
- Status `500` $\rightarrow$ `InternalServerError`
- Timeout $\rightarrow$ `TimeoutError`
- Network/Offline $\rightarrow$ `ConnectionError` / `SocketError`

See [`HttpErrors`](HttpErrors.md) for full documentation on error structures.

---

## Related Classes

- [`HttpHeader`](HttpHeader.md): Manages tokens and language keys.
- [`HttpUrlsEnveiroment`](HttpHeader.md): Stores global `baseUrl` and `imageBaseUrl`.
- [`DataSourceDataActionsHttpSources`](../implementations/DataSourceDataActionsHttpSources.md): Uses `HttpClient` for CRUD operations.
- [`LoadDataHttpSources`](../implementations/LoadDataRepo.md): Uses `HttpClient` for list loading operations.

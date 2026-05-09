# HttpHeader

`HttpHeader` is a singleton utility class for managing HTTP headers across the application, specifically handling authentication and language/locale headers. It works in conjunction with `JodijaHttpClient` (or `HttpClient`) to append appropriate headers to requests.

## Properties

- `_instance`: The singleton instance.
  - Type: `HttpHeader`
  - Static
  - Private

- `_usertoken`: The formatted authentication token value.
  - Type: `String`
  - Private

- `_tokenKey`: The header key for the token (e.g., `'Authorization'`).
  - Type: `String`
  - Private

- `_langKey`: The header key for language (e.g., `'x-lang'`).
  - Type: `String`
  - Private

- `_langValue`: The value of the language header (e.g., `'ar'`, `'en'`).
  - Type: `String?` (Nullable)
  - Private

## Constructors

### HttpHeader()

Provides access to the singleton instance.

## Methods

### setAuthHeader()

Sets or updates the authentication token and its key.

```dart
void setAuthHeader(
  String token, {
  String Bearer = "Bearer",
  String tokenType = "",
  String tokenKey = "Authorization",
});
```

**Parameters**:
- `token`: The raw authentication token.
- `Bearer`: The token prefix (default: `"Bearer"`).
- `tokenKey`: The header key name (default: `"Authorization"`).

---

### setLangHeader()

Sets or updates the language header.

```dart
void setLangHeader({
  String? lang,
  String key = "x-lang",
});
```

**Parameters**:
- `lang`: The language code (e.g., `'ar'`, `'en'`). If `null`, the header will not be sent.
- `key`: The header key name (default: `"x-lang"`).

## Usage Example

### Setting Authentication

```dart
// Set token on login
HttpHeader().setAuthHeader('eyTd76...', Bearer: 'Bearer ');
```

### Setting Language

```dart
// Set language to Arabic
HttpHeader().setLangHeader(lang: 'ar');

// Update header key if needed
HttpHeader().setLangHeader(lang: 'en', key: 'Accept-Language');

// Remove language header (disable sending)
HttpHeader().setLangHeader(lang: null);
```

## Related Classes

- `JodijaHttpClient` / `HttpClient`: Consumes `HttpHeader` values to build requests.

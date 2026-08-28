# DataSourceConfiguration Class

`DataSourceConfigration` is the central configuration class in the Jodija Repository library. It manages environment types (`localDev`, `dev`, `prod`), backend states (`local`, `remote_dev`, `remote_prod`), application types (`App`, `DashBord`), and handles the initialization of Firebase and HTTP Backend Routing (including base API URLs and Image Server URLs).

In **Multi-Solution Architectures** (such as `matger front logic`), this class is extended by the business logic package to provide a unified configuration interface for all client UI solutions (Customer App, Merchant App, Admin Dashboard, Web).

---

## Properties

- `appType`: (getter/setter `AppType`)
  - Specifies the UI solution type (`AppType.App` or `AppType.DashBord`).
- `backendState`: (getter/setter `BackendState`)
  - Determines whether the backend environment is local (`BackendState.local`), remote development (`BackendState.remote_dev`), or remote production (`BackendState.remote_prod`).
- `envType`: (getter/setter `EnvType`)
  - Controls the environment configuration for Firebase and services (`EnvType.localDev`, `EnvType.dev`, `EnvType.prod`).

---

## Methods

### 1. `backendRoutedInit(String path)`

Initializes the backend routing and image base URLs by reading a JSON asset file from the given asset path.

```dart
Future backendRoutedInit(String path) async
```

**Workflow**:
1. Ensures Flutter bindings are initialized.
2. Reads the JSON file via `JsonAssetReader`.
3. Extracts `baseUrls` and `imageBaseUrls` according to the current `backendState`.
4. Configures the singleton `HttpUrlsEnveiroment(baseUrl: ..., imageBaseUrl: ...)`.

---

### 2. `backendRoutedInitFromJson(Map<String, dynamic> data)`

Initializes backend routing and image URLs from an in-memory `Map<String, dynamic>`.

```dart
Future backendRoutedInitFromJson(Map<String, dynamic> data) async
```

---

### 3. `setToHttpUrlsEnveiroment({required String baseUrl, String? imageBaseUrl})`

Directly assigns the base URL and image base URL to the global `HttpUrlsEnveiroment` singleton without requiring a JSON file.

```dart
void setToHttpUrlsEnveiroment({required String baseUrl, String? imageBaseUrl})
```

---

### 4. `FirebaseInit(String path)`

Initializes Firebase by reading configuration from an asset JSON file based on the current `envType`.

```dart
Future FirebaseInit(String path) async
```

---

### 5. `FirebaseInitFromDataJson(Map<String, dynamic> path)`

Initializes Firebase from a configuration map.

```dart
Future FirebaseInitFromDataJson(Map<String, dynamic> path) async
```

---

## Expected JSON Configuration Schema (`config.json`)

When using `backendRoutedInit` and `FirebaseInit`, your JSON asset (e.g., `assets/config/config.json`) should follow this structure:

```json
{
  "baseUrls": {
    "local": "http://10.0.2.2:5000/api/v1",
    "remote_dev": "https://dev-api.matger.com/api/v1",
    "remote_prod": "https://api.matger.com/api/v1"
  },
  "imageBaseUrls": {
    "local": "http://10.0.2.2:5000/",
    "remote_dev": "https://dev-api.matger.com/",
    "remote_prod": "https://api.matger.com/"
  },
  "firebaseConfig": {
    "dev": {
      "apiKey": "AIzaSyDev...",
      "appId": "1:12345:android:dev",
      "messagingSenderId": "123456789",
      "projectId": "matger-dev",
      "storageBucket": "matger-dev.appspot.com"
    },
    "prod": {
      "apiKey": "AIzaSyProd...",
      "appId": "1:12345:android:prod",
      "messagingSenderId": "987654321",
      "projectId": "matger-prod",
      "storageBucket": "matger-prod.appspot.com"
    }
  }
}
```

---

## Enums

```dart
enum AppType { 
  DashBord, 
  App 
}

enum EnvType { 
  localDev, 
  dev, 
  prod 
}

enum BackendState { 
  local, 
  remote_dev, 
  remote_prod 
}
```

---

## Integration in Multi-Solution Architecture (`matger front logic`)

In multi-solution architectures, extend `DataSourceConfigration` inside your shared business logic package:

```dart
import 'package:JoDija_reposatory/jodija_configration.dart';
import 'package:JoDija_reposatory/https/http_urls.dart';

class MatgerLogicConfiguration extends DataSourceConfigration {
  static final MatgerLogicConfiguration _instance = MatgerLogicConfiguration._internal();
  factory MatgerLogicConfiguration() => _instance;
  MatgerLogicConfiguration._internal();

  /// Comprehensive initialization called during App startup
  Future<void> initialize({
    required String assetConfigPath,
    required EnvType env,
    required BackendState backend,
    required AppType app,
    String defaultLanguage = 'ar',
  }) async {
    envType = env;
    backendState = backend;
    appType = app;

    // Initialize HTTP and Image URLs
    await backendRoutedInit(assetConfigPath);

    // Set Default Language Header
    HttpHeader().setLangHeader(lang: defaultLanguage);
  }

  /// Change active language dynamically
  void setLanguage(String langCode) {
    HttpHeader().setLangHeader(lang: langCode);
  }

  /// Set user authentication token
  void setAuthToken(String token) {
    HttpHeader().setAuthHeader(token);
  }
}
```

---

## Related Classes

- [`HttpUrlsEnveiroment`](utils/HttpHeader.md): Stores active `baseUrl` and `imageBaseUrl`.
- [`HttpHeader`](utils/HttpHeader.md): Manages authorization token and `x-lang` language headers.
- [`HttpClient`](utils/JodijaHttpClient.md): Consumes configuration to make network requests.
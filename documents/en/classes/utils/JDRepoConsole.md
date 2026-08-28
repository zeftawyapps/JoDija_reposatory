# JDRepoConsole & Logging System

`JDRepoConsole` is a centralized, structured logging and diagnostics utility designed for the JoDija ecosystem. It provides colored console logs, timestamps, performance timing, context tags, and metadata formatting, while automatically suppressing non-critical logs in production (`kReleaseMode`).

---

## Log Levels (`LogLevel`)

```dart
enum LogLevel { 
  ERROR,   // ❌ Red
  WARN,    // ⚠️ Yellow
  INFO,    // ℹ️ Blue
  DEBUG,   // 🔧 Gray
  SUCCESS  // ✅ Green
}
```

- **In Development (`kDebugMode`)**: All log levels are output to the console.
- **In Production (`kReleaseMode`)**: Only `ERROR` and `WARN` levels are logged.

---

## Log Context (`LogContext`)

`LogContext` attaches contextual information to logs, making debugging across layered architectures seamless.

### Properties:
- `module`: The originating module/package (e.g. `'MatgerAPI'`, `'AuthRepo'`).
- `method`: The specific method name or endpoint (e.g. `'GET /products'`).
- `userId`: Optional ID of the authenticated user.
- `requestId`: Traceability ID for network requests.
- `duration`: Execution time in milliseconds (formatted automatically).
- `metadata`: Additional JSON or diagnostic data map.

---

## Static Logging Methods

### General Logging:
```dart
JDRepoConsole.error('Failed to load products', context: LogContext(module: 'Products'));
JDRepoConsole.warn('Deprecated endpoint called');
JDRepoConsole.info('User session started');
JDRepoConsole.debug('Parsing JSON response payload');
JDRepoConsole.success('Payment completed successfully');
```

### Specialized Convenience Methods:

| Method | Description |
| :--- | :--- |
| `JDRepoConsole.request(method, endpoint)` | Logs outgoing HTTP request details. |
| `JDRepoConsole.response(statusCode, message)` | Logs HTTP response status with automatic level color. |
| `JDRepoConsole.operation(operation, status)` | Logs status of a task (`'started'`, `'completed'`, `'failed'`). |
| `JDRepoConsole.performance(operation, duration)` | Logs elapsed duration in ms (warns if > 5000ms). |
| `JDRepoConsole.initialization(module)` | Logs successful module setup. |
| `JDRepoConsole.productInfo(name, action)` | Logs product lifecycle events. |
| `JDRepoConsole.validation(field, errorMsg)` | Logs form or input validation failures. |
| `JDRepoConsole.database(operation, collection)` | Logs database queries (Firestore / local DB). |

---

## Global Functions

For quick inline logging, the top-level functions `jdRepoConsole()` and `jdRepoConsol()` are available:

```dart
jdRepoConsole('Simple debug message');
jdRepoConsole(exceptionObject, context: LogContext(module: 'Auth'));
```

---

## Example Usage in `matger front logic`

```dart
import 'package:JoDija_reposatory/utilis/functions/jd_repo_console.dart';

class ProductRepository {
  Future<void> fetchProducts() async {
    final stopwatch = Stopwatch()..start();
    JDRepoConsole.operation('FetchProducts', 'started');

    try {
      // Perform network request...
      stopwatch.stop();
      JDRepoConsole.performance('FetchProducts', stopwatch.elapsedMilliseconds);
      JDRepoConsole.operation('FetchProducts', 'completed');
    } catch (e) {
      JDRepoConsole.error('FetchProducts error: $e', context: LogContext(
        module: 'Products',
        method: 'fetchProducts',
      ));
    }
  }
}
```

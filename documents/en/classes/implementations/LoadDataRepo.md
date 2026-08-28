# LoadDataRepo & LoadDataHttpSources

`LoadDataRepo` is a repository implementation dedicated to loading lists or collections of data entities from remote HTTP endpoints or data sources.

---

## Architecture Overview

- **Interface**: `IBaseLoadSource<T>` (`lib/interface/sources/i_load_source.dart`)
- **HTTP Source**: `LoadDataHttpSources<T>` (`lib/source/http/load_http_sources.dart`)
- **Repository**: `LoadDataRepo<T>` (`lib/reposetory/load_data_reposatory.dart`)

Where `T` must extend `BaseEntityDataModel`.

---

## `LoadDataHttpSources<T>`

`LoadDataHttpSources` handles HTTP GET requests to fetch datasets from API endpoints.

### Constructors:
```dart
LoadDataHttpSources({
  required String url,
  required T Function(Map<String, dynamic> json) fromJson,
  Map<String, dynamic>? queryParameters,
  bool userToken = false,
});
```

---

## `LoadDataRepo<T>`

### Constructors:
```dart
LoadDataRepo({required IBaseLoadSource<T> source});
```

### Methods:

#### `loadData()`
Fetches data from the configured source and returns a list of items wrapped in a `Result`.

```dart
Future<Result<RemoteBaseModel, List<T>>> loadData() async
```

---

## Usage Example

```dart
import 'package:JoDija_reposatory/reposetory/load_data_reposatory.dart';
import 'package:JoDija_reposatory/source/http/load_http_sources.dart';
import 'package:JoDija_reposatory/utilis/models/base_data_model.dart';

class ProductModel extends BaseEntityDataModel {
  final String id;
  final String title;

  ProductModel({required this.id, required this.title});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
  );
}

void fetchProducts() async {
  // 1. Create source
  final source = LoadDataHttpSources<ProductModel>(
    url: 'products',
    fromJson: (json) => ProductModel.fromJson(json),
    userToken: true,
  );

  // 2. Create repo
  final repo = LoadDataRepo<ProductModel>(source: source);

  // 3. Load data
  final result = await repo.loadData();
  if (result.data != null) {
    print('Products fetched: ${result.data?.length}');
  }
}
```

---

## Related Classes

- [`DataSourceRepo`](DataSourceRepo.md): Repository for CRUD operations (add, edit, delete, get).
- [`BaseEntityDataModel`](../base_model/base_data_model.md): Base model for entities.
- [`Result`](../results/result.md): Result wrapper for operation data.

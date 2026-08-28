# Cell & Grid Table Data Models

The `cell_models` subsystem provides structured wrappers for tabular data, dynamic spreadsheets, rows, and cells used in dashboards and data grids.

---

## Classes Overview

### 1. `Cell<T>`
Represents an individual unit or cell with a typed value and metadata.

```dart
class Cell<T> {
  final T? value;
  final String? key;
  final bool isEditable;

  Cell({this.value, this.key, this.isEditable = false});
}
```

### 2. `RowofCells<T>`
Represents a structured row containing multiple `Cell` instances.

```dart
class RowofCells<T extends Model> {
  final List<Cell> cells;
  final String? rowId;

  RowofCells({required this.cells, this.rowId});
}
```

### 3. `TableOfCells<T>`
Represents a collection of rows providing table-level operations.

```dart
class TableOfCells<T extends Model> {
  final List<RowofCells<T>> rows;

  TableOfCells({required this.rows});
}
```

---

## Related Classes

- [`BaseEntityDataModel`](base_data_model.md): Base entity model.

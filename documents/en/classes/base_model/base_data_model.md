## BaseDataModel Class

The `BaseDataModel` class is a base data model class that represents a data entity with an optional ID. 


### Properties

- `id`: A `String?` that represents the unique identifier for the data entity.
- `map`: A `Map<String, dynamic>?` that holds additional data for the model.

### Constructor

- `BaseDataModel({String? id})`: Constructs a `BaseDataModel` instance with an optional `id`.

### Factory Constructor

- `BaseDataModel.fromJson(Map<String, dynamic> json, String? id)`: Creates a `BaseDataModel` instance from a JSON map and an optional `id`.
  - `json`: A map containing the data to initialize the model.
  - `id`: An optional identifier for the model.

### Methods

- `toJson()`: Converts the `BaseDataModel` instance to a JSON map and returns a map containing the data of the model.
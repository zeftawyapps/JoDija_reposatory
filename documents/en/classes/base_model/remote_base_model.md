### RemoteBaseModel Class

A generic class that represents a remote data model. This class is used to encapsulate the data, status, message, and error information retrieved from a remote source.

#### Constructor

##### `RemoteBaseModel({this.status, this.message, this.data, this.error})`

Constructs a `RemoteBaseModel` instance with optional parameters.

- **Parameters:**
    - `status`: The status of the remote operation.
    - `message`: An optional message associated with the remote operation.
    - `data`: The data retrieved from the remote source.
    - `error`: An optional error object if the remote operation failed.

#### Properties

- **`StatusModel? status`**
    - The status of the remote operation.

- **`String? message`**
    - An optional message associated with the remote operation.

- **`T? data`**
    - The data retrieved from the remote source.

- **`Object? error`**
    - An optional error object if the remote operation failed.

#### Methods

##### `factory RemoteBaseModel.fromJson(Map<String, dynamic> json)`

Creates a `RemoteBaseModel` instance from a JSON map.

- **Parameters:**
    - `json`: A map containing the data to initialize the model.
- **Returns:** A `RemoteBaseModel` instance with the data from the JSON map.

##### `Map<String, dynamic> toJson()`

Converts the `RemoteBaseModel` instance to a JSON map.

- **Returns:** A map containing the data of the model.
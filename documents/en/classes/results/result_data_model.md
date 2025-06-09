## ResultDataHelper Class

This class is used to help you get the data from the result object. It is a generic class that takes `T`, which must extend from the `BaseDataModel` class.

#### Why do we need this class?

If you work in a multi-solution project and use the repository pattern, you will need to get the data from the result object. You will need to check if the data source is of the same type as `T` and return the data from the result object.

**Methods**

### `RemoteBaseModel getResulInput(Result result)`

Retrieves a list of data from a `RemoteBaseModel` result object.

This method processes the result object to extract a list of data items of type `T`. It uses a builder function to convert each item in the list to the desired type `T`.

Throws a `RemoteBaseModel` with an error status if the result contains an error.

- **Parameters:**
  - `result`: The `RemoteBaseModel` result object containing the data.
  - `builder`: A function that converts a `BaseDataModel` item to type `T`.
- **Returns:** A `RemoteBaseModel` containing a list of data items of type `T` and a success status.

### `RemoteBaseModel<List<T>> getResultOfListData(RemoteBaseModel result, T? Function(BaseDataModel? data) builder)`

Retrieves a list of data from a `RemoteBaseModel` result object.

This method processes the result object to extract a list of data items of type `T`. It uses a builder function to convert each item in the list to the desired type `T`.

Throws a `RemoteBaseModel` with an error status if the result contains an error.

- **Parameters:**
  - `result`: The `RemoteBaseModel` result object containing the data.
  - `builder`: A function that converts a `BaseDataModel` item to type `T`.
- **Returns:** A `RemoteBaseModel` containing a list of data items of type `T` and a success status.

### `RemoteBaseModel<T> getResultOfData(Result result, T? Function(Map<String, dynamic>? data) builder)`

Retrieves a single data item from a `Result` object.

This method processes the `Result` object to extract a single data item of type `T`. It uses a builder function to convert the data map to the desired type `T`.

Throws a `RemoteBaseModel` with an error status if the result contains an error.

- **Parameters:**
  - `result`: The `Result` object containing the data.
  - `builder`: A function that converts a `Map<String, dynamic>` item to type `T`.
- **Returns:** A `RemoteBaseModel` containing a data item of type `T` and a success status.
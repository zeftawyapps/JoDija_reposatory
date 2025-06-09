## UserResult Class

The `UserResult` class is a generic class designed to handle the result of an operation that can either succeed with data or fail with an error. It is parameterized with `Error` and `Data` types, where `Error` extends `RemoteBaseModel`.

### Why do we need this class?

 when using the repository pattern, it is common to handle results that can either be successful or erroneous. The `UserResult` class provides a structured way to manage these outcomes, ensuring that either data or an error is always present.

### Properties

- `data`: The data of type `Data` if the operation was successful.
- `error`: The error of type `Error` if the operation failed.

### Methods

#### `UserResult({this.data, this.error})`

Constructor that initializes the `UserResult` with either data or an error. It asserts that at least one of them is non-null.

#### `bool get hasDataOnly`

Checks whether only data is available (i.e., no error).

#### `bool get hasErrorOnly`

Checks whether only an error is present (i.e., no data).

#### `bool get hasDataAndError`

Checks whether both data and error are present.

#### `factory UserResult.error(Error error)`

Creates an instance of `UserResult` with an error.

- **Parameters:**
  - `error`: The error to be set.
- **Returns:** A `UserResult` instance with the error.

#### `factory UserResult.data(Data? data)`

Creates an instance of `UserResult` with data.

- **Parameters:**
  - `data`: The data to be set.
- **Returns:** A `UserResult` instance with the data.

#### `factory UserResult.dataWithError(Data? data, Error error)`

Creates an instance of `UserResult` with both data and error.

- **Parameters:**
  - `data`: The data to be set.
  - `error`: The error to be set.
- **Returns:** A `UserResult` instance with both data and error.

#### `factory UserResult.forward(UserResult _result, Data? data)`

Forwards the error if present, else forwards the data.

- **Parameters:**
  - `_result`: The `UserResult` instance to forward.
  - `data`: The data to be set if no error is present.
- **Returns:** A `UserResult` instance with either the forwarded error or data.

#### `fold({required UserResult Function(Error error) onError, required UserResult Function(Data data) onData})`

Executes the appropriate function based on the presence of data or error.

- **Parameters:**
  - `onError`: Function to execute if an error is present.
  - `onData`: Function to execute if data is present.

#### `void pick<T>({T Function(Error error)? onError, T Function(Data data)? onData, T Function(Data data, Error error)? onErrorWithData})`

Cherry-picks values based on the presence of data and/or error.

- **Parameters:**
  - `onError`: Function to execute if an error is present.
  - `onData`: Function to execute if data is present.
  - `onErrorWithData`: Function to execute if both data and error are present.
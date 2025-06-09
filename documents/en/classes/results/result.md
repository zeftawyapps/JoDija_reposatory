## Result Class

The `Result` class is a generic class that represents the result of an operation. It contains the data and error that result from the operation.
it has 2 generic types `error` and `data` that represent the data and error types respectively. 
`error` is the type of the error that can be returned from the operation. and the type must be a  
extende from `RemoteBaseModel` class.
and the `data` is the type of the data that can be returned from the operation. 


**Constructors**
* **Result({this.data, this.error});**
* this constructor is used to create a result object with the data and error that result from the operation.
* **Result.fromError(this.error);**
* this constructor is used to create a result object with the error that result from the operation.
* **Result.fromData(this.data);**
* this constructor is used to create a result object with the data that result from the operation.
**Methods**
  `void pick<T>({
  T Function(Error error)? onError,
  T Function(Data data)? onData,
  T Function(Data data, Error error)? onErrorWithData,
  })` 
* this method is used to pick the data or the error that result from the operation.
* **Parameters**
  * **onError:** a function that takes an error and return a value of type T.
  * **onData:** a function that takes a data and return a value of type T.
  * **onErrorWithData:** a function that takes a data and an error and return a value of type T.
    **Property**
 
    `bool get hasDataOnly`
    checks whether data is available
 
  `bool get hasErrorOnly`
   checks whether an error is present

 `bool get hasDataAndError`
  checks whether data and error is present
  error from network data source and data from cache data source

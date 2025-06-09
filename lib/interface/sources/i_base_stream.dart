
/// An abstract class that defines a stream of data items of type `T`.
///
/// This class provides a method to retrieve a stream of data items.
/// The type parameter `T` represents the type of data items.
abstract class IBaseStream<T> {
/// Retrieves a stream of data items.
///
/// \returns A `Stream` that emits lists of data items of type `T`.
Stream<List<T>> streamData();
}

import 'dart:typed_data';

/// Web/Wasm-safe stub for `dart:io` types when `dart.library.io` is unavailable.
class File {
  final String path;

  const File(this.path);

  Future<Uint8List> readAsBytes() {
    throw UnsupportedError('dart:io File.readAsBytes is not supported on Web.');
  }
}

class SocketException implements Exception {
  final String message;

  const SocketException([this.message = '']);

  @override
  String toString() => 'SocketException: $message';
}

class HttpException implements Exception {
  final String message;

  const HttpException([this.message = '']);

  @override
  String toString() => 'HttpException: $message';
}

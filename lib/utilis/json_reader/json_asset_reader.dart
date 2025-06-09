import 'dart:convert';

import 'package:flutter/services.dart';


/// A class to read JSON data from an asset file.
///
/// This class provides functionality to read and parse JSON data from a specified
/// asset file path. It uses the `rootBundle` to load the file and `dart:convert`
/// to decode the JSON data.
class JsonAssetReader {
  /// The parsed JSON data.
  Map<String, dynamic>? _data;

  /// The path to the asset file.
  String _path = '';

  /// Indicates whether the file exists.
  bool fileExists = false;

  /// Creates an instance of [JsonAssetReader] with the given asset file path.
  ///
  /// The [path] parameter specifies the path to the asset file.
  JsonAssetReader({required String path}) {
    this._path = path;
  }

  /// Asynchronously gets the parsed JSON data.
  ///
  /// This getter reads the file from the asset and decodes the JSON data.
  /// Returns a [Map] containing the JSON data.
  get data async {
    _data = await _readFileFromAsset(_path) as Map<String, dynamic>;
    return _data;
  }

  /// Reads the file from the asset and decodes the JSON data.
  ///
  /// The [path] parameter specifies the path to the asset file.
  /// Returns the decoded JSON data.
  Future<dynamic> _readFileFromAsset(String path) async {
    var response = await rootBundle.loadString(path);
    return json.decode(response);
  }
}
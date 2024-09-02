import 'dart:convert';

import 'package:flutter/services.dart';


class JsonAssetReader {
  Map<String, dynamic>? _data;
  String _path = '';
  bool fileExists = false;
  JsonAssetReader({required String path})  {
    this._path = path;
     }
  get data   async{
    _data = await _readFileFromAsset(_path) as Map<String, dynamic>;
    return _data;
  }
  Future<dynamic> _readFileFromAsset(String path) async {
    var response = await rootBundle.loadString(path);
    return json.decode(response);
  }
}

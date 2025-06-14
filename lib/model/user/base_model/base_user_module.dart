import 'package:freezed_annotation/freezed_annotation.dart';

import 'interface_userModel.dart';
/// A base model class for user data.
///
/// This class implements `IuserModel` and provides basic fields
/// such as `uid`, `name`, `email`, and `token`. It also includes
/// methods for JSON serialization and deserialization.
class UsersBaseModel implements IuserModel {
  static const String idKey = "uid";
  static const String? nameKey = "name";
  static const String? emailKey = "email";
  static const String? tokenKey = "token";

  String? uid;
  String? name;
  String? email;
  String? token;

  /// Constructs a `UsersBaseModel` instance.
  ///
  /// \param uid The unique identifier of the user.
  /// \param name The name of the user.
  /// \param email The email address of the user.
  /// \param token The token of the user.
  UsersBaseModel({this.name, this.uid, this.email, this.token});

  /// Constructs a `UsersBaseModel` instance from a JSON map.
  ///
  /// \param json A map containing the JSON data.
  UsersBaseModel.formJson(Map<String, dynamic> json) {
    uid = json['uid'] == null ? null : json['uid'];
    name = json['name'] == null ? null : json['name'];
    email = json['email'] == null ? null : json['email'];
    token = json['token'] == null ? "" : json['token'];
    map = json;
  }

  /// Converts the `UsersBaseModel` instance to a JSON map.
  ///
  /// \returns A map containing the JSON data.
  @mustBeOverridden
  Map<String, dynamic> toJson() {
    final _data = map;
    _data['uid'] = uid;
    _data['name'] = name;
    _data['email'] = email;
    _data['token'] = token;
    return _data;
  }

  @override
  Map<String, dynamic> map = Map();
}
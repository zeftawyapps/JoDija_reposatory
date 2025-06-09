import '../base_user_module.dart';

/// A model class representing a user module.
///
/// This class extends `UsersBaseModel` and includes additional fields
/// such as address, phone, and type. It provides methods for JSON
/// serialization and deserialization.
class UserModule extends UsersBaseModel {
  static const String addressKey = "address";
  static const String phoneKey = "phone";
  static String typeKey = "type";

  String? address;
  String? phone;
  int? type = 0;

  /// Constructs a `UserModule` instance.
  ///
  /// \param address The address of the user.
  /// \param phone The phone number of the user.
  /// \param type The type of the user.
  /// \param id The unique identifier of the user.
  /// \param name The name of the user.
  /// \param token The token of the user.
  /// \param email The email address of the user.
  UserModule({
    this.address = "",
    this.phone,
    this.type = 0,
    String? id,
    String? name,
    String? token = "",
    String? email,
  }) : super(email: email, uid: id, name: name, token: token);

  /// Constructs a `UserModule` instance from a JSON map.
  ///
  /// \param json A map containing the JSON data.
  UserModule.formJson(Map<String, dynamic> json) {
    uid = json['uid'] == null ? null : json['uid'];
    name = json['name'] == null ? null : json['name'];
    email = json['email'] == null ? null : json['email'];
    address = json['address'] == null ? null : json['address'];
    phone = json['phone'] == null ? null : json['phone'];
    type = json['type'] == null ? 0 : json['type'];
    token = json['token'] == null ? "" : json['token'];
  }

  /// Converts the `UserModule` instance to a JSON map.
  ///
  /// \returns A map containing the JSON data.
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['name'] = name;
    _data['email'] = email;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['type'] = type ?? 0;
    _data['token'] = token;

    return _data;
  }
}
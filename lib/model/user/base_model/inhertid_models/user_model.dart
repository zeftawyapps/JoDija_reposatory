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
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    type = json['type'] ?? 0;
    token = json['token'] ?? "";
  }

  /// Converts the `UserModule` instance to a JSON map.
  ///
  /// \returns A map containing the JSON data.
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['type'] = type ?? 0;
    data['token'] = token;

    return data;
  }
}
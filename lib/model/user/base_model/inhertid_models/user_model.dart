
import '../base_user_module.dart';

class UserModule extends UsersBaseModel {
  static const String addressKey = "address";
  static const String phoneKey = "phone";
  static String typeKey = "type";
  String? address;
  String? phone;
  int? type = 0;
  UserModule(
      {this.address =  "",

      this.phone,
      this.type = 0,
      String? id,
      String? name,
      String? email})
      : super(email: email, uid: id, name: name);

  UserModule.formJson(Map<String, dynamic> json) {
    uid = json['uid'] == null ? null : json['uid'];
    name = json['name'] == null ? null : json['name'];
    email = json['email'] == null ? null : json['email'];
    address = json['address'] == null ? null : json['address'];
    phone = json['phone'] == null ? null : json['phone'];
    type = json['type'] == null ? 0 : json['type'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['name'] = name;
    _data['email'] = email;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['type'] = type ?? 0;

    return _data;
  }
}

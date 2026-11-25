import 'package:jodija_repository/utilis/models/base_data_model.dart';
import 'package:meta/meta.dart';

import 'interface_userModel.dart';
/// A base model class for user data.
///
/// This class implements `IuserModel` and provides basic fields
/// such as `uid`, `name`, `email`, and `token`. It also includes
/// methods for JSON serialization and deserialization.
class UsersBaseModel implements IuserModel  , BaseEntityDataModel{
  static const String idKey = "uid";
  static const String nameKey = "name";
  static const String emailKey = "email";
  static const String tokenKey = "token";

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
  UsersBaseModel({this.name, this.uid, this.email, this.token}) {
    id = uid;
    uMap =  toJson();
    map =  toJson() ;
  }

  /// Constructs a `UsersBaseModel` instance from a JSON map.
  ///
  /// \param json A map containing the JSON data.
  UsersBaseModel.formJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    token = json['token'] ?? "";
   id = uid; 
    uMap = json;
    map = json; 
  }
 //  formJson With MetaData 
  UsersBaseModel.formJsonWithMetaData(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    token = json['token'] ?? "";
    id = uid; 
    uMap = json;
    map = json; 
    isArchived =   json['isArchived'] ?? false;
    createdAt = DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now();
    updatedAt = DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now();
  }


  /// Converts the `UsersBaseModel` instance to a JSON map.
  ///
  /// \returns A map containing the JSON data.
  @override
  @mustBeOverridden
  Map<String, dynamic> toJson() {
    final data = uMap;
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    map =data ; 
    return data;
  }
  // tojson With metaData
  Map<String, dynamic> toJsonWithMetaData() {
    final data = toJson();
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['isArchived'] = isArchived;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
     map =data ; 
    return data;
  }

  @override
  Map<String, dynamic> uMap = {};
  
  @override
  String? id;
  
  @override
  Map<String, dynamic>? map;

  @override
  bool? isArchived;
  
  @override
  DateTime? createdAt;
  
  @override
  DateTime? updatedAt;
}
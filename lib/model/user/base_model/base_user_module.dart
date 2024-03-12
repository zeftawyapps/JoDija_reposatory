import 'package:freezed_annotation/freezed_annotation.dart';

import 'interface_userModel.dart';

  class UsersBaseModel implements IuserModel {
 static const  String idKey ="uid" ;
 static const  String? nameKey = "name";
 static   const  String? emailKey ="email";
 static const  String? tokenKey ="token";

  String? uid ;
  String? name;
  String? email;
  String? token;
UsersBaseModel ({this.name , this.uid , this.email  , this.token});


 UsersBaseModel.  formJson(Map<String , dynamic> json ){
  uid = json['uid']== null ? null  : json['uid'] ;
  name = json['name']== null ? null  : json['name'] ;
  email = json['email']== null ? null  : json['email'] ;
  token = json['token']== null ? ""  : json['token'] ;
 map = json ;
 }
 @mustBeOverridden
  Map<String, dynamic> toJson() {
    final _data =   map ;
    _data['uid'] = uid ;
    _data['name'] = name ;
    _data['email'] = email ;
    _data['token'] = token ;
    return _data ;
  }

  @override
  Map<String, dynamic>  map = Map();
}
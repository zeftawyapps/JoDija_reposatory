import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IBaseAccountActions{
  Future createProfileData({ required  String id,required  Map<String, dynamic> data});
  Future<Map<String , dynamic>> updateProfileData({ required  String id  , Map<String , dynamic >?mapData
  , Object? file
  });
  Future<Map<String , dynamic>>getData(String id );
}

abstract class IProfileSubDataActions{
  Future createProfileData({   required  String path     , required  Map<String, dynamic> data , Object? file});
  Future updateProfileData({ required String id ,  required  String path  , required  Map<String, dynamic> data });
  Future deleteProfileData({ required  String path  });
  Future<List<Map<String , dynamic>>>getData({ required  String path, Query Function(Query query)? queryBuilder});
}
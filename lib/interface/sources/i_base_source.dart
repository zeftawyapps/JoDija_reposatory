import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utilis/models/base_data_model.dart';


abstract class IEductionalBaseSource<T  extends BaseDataModel> {
  T? data;
  Future   addDataItem(  );
  Future   updateDataItem(   String id  );
  Future   deleteDataItem(String  id);
  Future<  List<T>>  getAllDataList();
  Future<  T >   getDataItem(String id);
  Future<  List<T> >  getData(  Query Function(Query query)?   query);

}
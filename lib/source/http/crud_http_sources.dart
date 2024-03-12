import 'package:dio/dio.dart';
import '../../constes/api_urls.dart';
import '../../https/http_urls.dart';
import '../../interface/sources/i_json_base_source.dart';
import '../../utilis/http_remotes/http_client.dart';
import '../../utilis/http_remotes/http_methos_enum.dart';
import '../../utilis/models/base_data_model.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';
import '../../utilis/result/result.dart';


class AppCategoryHttpSources extends ICommerceResultBaseCRUDSource<BaseDataModel>   {
  BaseDataModel? data;
  MultipartFile? file;
  String imagfileld="image";
  // factory
  factory AppCategoryHttpSources.inputs(
      BaseDataModel dataModyle, MultipartFile? file) {
    return AppCategoryHttpSources()
      ..data = dataModyle
      ..file = file
      .. imagfileld = "image";
  }
  AppCategoryHttpSources();

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<String>  >>
  addDataItem() async {
    if (file == null) {
      var result = await JoDijaHttpClient(userToken: true)
          .sendRequest(
          method: HttpMethod.POST,
          url: "ApiUrls.category",
          body: data!.toJson(),
          cancelToken: CancelToken());
 if (result.data!.status == StatusModel.success) {
   var resultdata = result.data!.data! ["data"] as String;
   return Result<RemoteBaseModel, RemoteBaseModel<String>>(
       data: RemoteBaseModel(data: resultdata));
 }else {
    return Result<RemoteBaseModel, RemoteBaseModel<String>>(
        error: RemoteBaseModel(message: result.data!.message, status: result.data!.status));
 } } else {

      String key = HttpHeader().tokenKey;
      var result = await JoDijaHttpClient(userToken: true).uploadMapResult(
          fileKey: imagfileld,
          file: file!,
          headers: {
            "Content-Type": "multipart/form-data",
            "Accept": "*/*",
            key:HttpHeader().usertoken
          },
          url: "ApiUrls.category",
          data: data!.toJson(),
          cancelToken: CancelToken());
      if (result.data!.status == StatusModel.success) {
        var resultdata = result.data!.data! ["data"] as String;
        return Result<RemoteBaseModel, RemoteBaseModel<String>>(
            data: RemoteBaseModel(data: resultdata));
      }else {
        return Result<RemoteBaseModel, RemoteBaseModel<String>>(
            error: RemoteBaseModel(message: result.data!.message, status: result.data!.status));
      }
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel >>
  deleteDataItem(String id) async {
    var result = await JoDijaHttpClient(userToken: true). sendRequest(
        method: HttpMethod.DELETE,
        url:" ApiUrls.category +  + id," ,
        cancelToken: CancelToken());
    if (result.data!.status == StatusModel.success) {
      return Result<RemoteBaseModel, RemoteBaseModel>(
          data: RemoteBaseModel());
    }else {
      return Result<RemoteBaseModel, RemoteBaseModel>(
          error: RemoteBaseModel(message: result.data!.message, status: result.data!.status));

    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<BaseDataModel>>  >>
  getDataList() async {
      var result = await JoDijaHttpClient(userToken: true).sendRequest(
          method: HttpMethod.GET,
          url: "ApiUrls .category",
          cancelToken: CancelToken());
      var resultdata = result.data!.data["data"]  as List<dynamic> ;
      List<BaseDataModel> listData = [];
      resultdata.map((e) => {
        listData.add(BaseDataModel.fromJson(e))
      }).toList();
      return  Result<RemoteBaseModel, RemoteBaseModel<List<BaseDataModel>>>    (data: RemoteBaseModel(data: listData));
  }
  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<BaseDataModel>>  > getSingleData(
      String id)async {
    var result = await JoDijaHttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET, url: "", cancelToken: CancelToken());
    if (result.data!.status == StatusModel.success) {
      var resultdata = result.data!.data! ["data"] as BaseDataModel;
      return Result<RemoteBaseModel, RemoteBaseModel<BaseDataModel>>(
          data: RemoteBaseModel(data: resultdata));
    }else {
      return Result<RemoteBaseModel, RemoteBaseModel<BaseDataModel>>(
          error: RemoteBaseModel(message: result.data!.message, status: result.data!.status));
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>>
  updateDataItem(String id) {
    var result = JoDijaHttpClient(userToken: true).sendRequest(
        method: HttpMethod.PUT,
        url: "ApiUrls.category  id",
        cancelToken: CancelToken());
    return result;
  }
}

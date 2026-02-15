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

/// A Dio-based implementation of [IBaseDataActionsSource] for HTTP endpoints.
///
/// This class handles remote data actions by making HTTP requests to a backend API.
class DataSourceDataActionsHttpSources
    extends IBaseDataActionsSource<BaseEntityDataModel> {
  /// The data model to be sent in the request body.
  BaseEntityDataModel? data;

  /// Optional file to be uploaded in a multipart request.
  MultipartFile? file;

  /// The field name for the file in a multipart request.
  String imagfileld = "image";

  /// The base URL for all requests.
  String baseUrl = "";

  /// The specific endpoint path relative to the base URL.
  String url = "";

  /// Query parameters to be included in the request URL.
  Map<String, dynamic>? query;

  /// Additional parameters.
  Map<String, dynamic>? params;

  /// Factory constructor to create an instance with initial data.
  factory DataSourceDataActionsHttpSources.inputs(
      {String? baseUrl = "",
      required String url,
      required BaseEntityDataModel dataModyle,
      Map<String, dynamic>? query,
      Map<String, dynamic>? params,
      MultipartFile? file}) {
    return DataSourceDataActionsHttpSources(
        baseUrl: baseUrl, url: url, query: query, params: params)
      ..data = dataModyle
      ..file = file
      ..imagfileld = "image";
  }

  /// Standard constructor for [DataSourceDataActionsHttpSources].
  DataSourceDataActionsHttpSources(
      {String? baseUrl = "", required String url, this.query, this.params}) {
    this.baseUrl =
        (baseUrl == null || baseUrl.isEmpty) ? ApiUrls.BASE_URL : baseUrl;
    this.url = url;
  }

  /// Helper method to build the request URL with an optional ID.
  String _buildUrl(String? id) {
    if (id == null || id.isEmpty || id == "") {
      return "$baseUrl/$url";
    }
    return "$baseUrl/$url/$id";
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<String>>> addDataItem(
      {String? id}) async {
    String requestUrl = _buildUrl(id);
    if (file == null) {
      var body = data!.toJson();
      var result = await HttpClient(userToken: true).sendRequest(
          method: HttpMethod.POST,
          url: requestUrl,
          body: body,
          queryParameters: query,
          cancelToken: CancelToken());
      if (result.data!.status == StatusModel.success) {
        var resultdata = result.data!.data!["data"] as String;
        return Result<RemoteBaseModel, RemoteBaseModel<String>>(
            data: RemoteBaseModel(data: resultdata));
      } else {
        return Result<RemoteBaseModel, RemoteBaseModel<String>>(
            error: RemoteBaseModel(
                message: result.data!.message, status: result.data!.status));
      }
    } else {
      String key = HttpHeader().tokenKey;
      var result = await HttpClient(userToken: true).uploadMapResult(
          fileKey: imagfileld,
          file: file!,
          headers: {
            "Content-Type": "multipart/form-data",
            "Accept": "*/*",
            key: HttpHeader().usertoken
          },
          url: requestUrl,
          data: data!.toJson(),
          cancelToken: CancelToken());
      if (result.data!.status == StatusModel.success) {
        var resultdata = result.data!.data!["data"] as String;
        return Result<RemoteBaseModel, RemoteBaseModel<String>>(
            data: RemoteBaseModel(data: resultdata));
      } else {
        return Result<RemoteBaseModel, RemoteBaseModel<String>>(
            error: RemoteBaseModel(
                message: result.data!.message, status: result.data!.status));
      }
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>> deleteDataItem(
      String id) async {
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.DELETE,
        url: _buildUrl(id),
        queryParameters: query,
        cancelToken: CancelToken());
    if (result.data!.status == StatusModel.success) {
      return Result<RemoteBaseModel, RemoteBaseModel>(data: RemoteBaseModel());
    } else {
      return Result<RemoteBaseModel, RemoteBaseModel>(
          error: RemoteBaseModel(
              message: result.data!.message, status: result.data!.status));
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<BaseEntityDataModel>>>>
      getDataList() async {
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET,
        url: _buildUrl(null),
        queryParameters: query,
        cancelToken: CancelToken());
    var resultdata = result.data!.data["data"] as List<dynamic>;
    List<BaseEntityDataModel> listData = [];
    resultdata
        .map((e) => {listData.add(BaseEntityDataModel.fromJson(e, e["id"]))})
        .toList();
    return Result<RemoteBaseModel, RemoteBaseModel<List<BaseEntityDataModel>>>(
        data: RemoteBaseModel(data: listData));
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<BaseEntityDataModel>>>
      getSingleData(String id) async {
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET,
        url: _buildUrl(id),
        queryParameters: query,
        cancelToken: CancelToken());
    if (result.data!.status == StatusModel.success) {
      var resultdata = result.data!.data!["data"] as BaseEntityDataModel;
      return Result<RemoteBaseModel, RemoteBaseModel<BaseEntityDataModel>>(
          data: RemoteBaseModel(data: resultdata));
    } else {
      return Result<RemoteBaseModel, RemoteBaseModel<BaseEntityDataModel>>(
          error: RemoteBaseModel(
              message: result.data!.message, status: result.data!.status));
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel>> editeDataItem(String id) {
    var result = HttpClient(userToken: true).sendRequest(
        method: HttpMethod.PUT,
        url: _buildUrl(id),
        queryParameters: query,
        cancelToken: CancelToken());
    return result;
  }
}

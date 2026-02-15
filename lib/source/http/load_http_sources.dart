import 'package:dio/dio.dart';
import '../../constes/api_urls.dart';
import '../../interface/sources/i_load_source.dart';
import '../../utilis/http_remotes/http_client.dart';
import '../../utilis/http_remotes/http_methos_enum.dart';
import '../../utilis/models/base_data_model.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';
import '../../utilis/result/result.dart';

/// A Dio-based implementation of [IBaseLoadSource] for HTTP endpoints.
///
/// This class handles remote data loading by making GET requests to a backend API.
/// It supports query parameters, path parameters, and identifiers.
class LoadDataHttpSources<T extends BaseEntityDataModel>
    implements IBaseLoadSource<T> {
  /// The base URL for the HTTP requests.
  String baseUrl = "";

  /// The endpoint path relative to the base URL.
  String url = "";

  /// Query parameters to be included in the request URL.
  Map<String, dynamic>? query;

  /// Additional parameters or path parameters.
  Map<String, dynamic>? params;

  /// The unique identifier of a single item to fetch.
  String? id;

  /// Optional builder function to construct the data model from JSON.
  T Function(Map<String, dynamic> jsondata, String? docId)? dataBuilder;

  /// Standard constructor for [LoadDataHttpSources].
  LoadDataHttpSources({
    this.baseUrl = "",
    required this.url,
    this.query,
    this.params,
    this.id,
    this.dataBuilder,
  }) {
    if (this.baseUrl.isEmpty) {
      this.baseUrl = ApiUrls.BASE_URL;
    }
  }

  /// Factory for creating a [LoadDataHttpSources] instance for list data loading.
  factory LoadDataHttpSources.list({
    String? baseUrl = "",
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? params,
    T Function(Map<String, dynamic> jsondata, String? docId)? dataBuilder,
  }) {
    return LoadDataHttpSources<T>(
      baseUrl: baseUrl ?? "",
      url: url,
      query: query,
      params: params,
      dataBuilder: dataBuilder,
    );
  }

  /// Factory for creating a [LoadDataHttpSources] instance for single data loading.
  factory LoadDataHttpSources.single({
    String? baseUrl = "",
    required String url,
    required String id,
    Map<String, dynamic>? query,
    Map<String, dynamic>? params,
    T Function(Map<String, dynamic> jsondata, String? docId)? dataBuilder,
  }) {
    return LoadDataHttpSources<T>(
      baseUrl: baseUrl ?? "",
      url: url,
      id: id,
      query: query,
      params: params,
      dataBuilder: dataBuilder,
    );
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<List<T>>>>
      getDataList() async {
    try {
      var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET,
        url: "$baseUrl/$url",
        queryParameters: query,
        cancelToken: CancelToken(),
      );

      if (result.data!.status == StatusModel.success) {
        var resultdata = result.data!.data["data"] as List<dynamic>;
        List<T> listData = [];
        for (var e in resultdata) {
          if (dataBuilder != null) {
            listData.add(
                dataBuilder!(e as Map<String, dynamic>, e["id"]?.toString()));
          } else {
            listData
                .add(BaseEntityDataModel.fromJson(e, e["id"]?.toString()) as T);
          }
        }
        return Result<RemoteBaseModel, RemoteBaseModel<List<T>>>(
          data: RemoteBaseModel(data: listData, status: StatusModel.success),
        );
      } else {
        return Result<RemoteBaseModel, RemoteBaseModel<List<T>>>(
          error: RemoteBaseModel(
            message: result.data!.message,
            status: result.data!.status,
          ),
        );
      }
    } catch (e) {
      return Result<RemoteBaseModel, RemoteBaseModel<List<T>>>(
        error:
            RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  @override
  Future<Result<RemoteBaseModel, RemoteBaseModel<T>>> getSingleData(
      {String? id}) async {
    try {
      String? targetId = id ?? this.id;
      String requestUrl = "$baseUrl/$url";
      if (targetId != null && targetId.isNotEmpty) {
        requestUrl = "$requestUrl/$targetId";
      }

      var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET,
        url: requestUrl,
        queryParameters: query,
        cancelToken: CancelToken(),
      );

      if (result.data!.status == StatusModel.success) {
        var resultdata = result.data!.data["data"];
        T dataItem;
        if (dataBuilder != null) {
          dataItem = dataBuilder!(resultdata as Map<String, dynamic>, targetId);
        } else {
          dataItem = BaseEntityDataModel.fromJson(
              resultdata as Map<String, dynamic>, targetId) as T;
        }
        return Result<RemoteBaseModel, RemoteBaseModel<T>>(
          data: RemoteBaseModel(data: dataItem, status: StatusModel.success),
        );
      } else {
        return Result<RemoteBaseModel, RemoteBaseModel<T>>(
          error: RemoteBaseModel(
            message: result.data!.message,
            status: result.data!.status,
          ),
        );
      }
    } catch (e) {
      return Result<RemoteBaseModel, RemoteBaseModel<T>>(
        error:
            RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }
}

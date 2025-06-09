import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../https/http_urls.dart';
import '../errors/http_errors/errors/connection_error.dart';
import '../errors/http_errors/errors/forbidden_error.dart';
import '../errors/http_errors/errors/format_error.dart';
import '../errors/http_errors/errors/internal_server_error.dart';
import '../errors/http_errors/errors/not_found_error.dart';
import '../errors/http_errors/errors/socket_error.dart';
import '../errors/http_errors/errors/timeout_error.dart';
import '../errors/http_errors/errors/unauthorized_error.dart';
import '../errors/http_errors/errors/unknown_error.dart';
import '../models/remote_base_model.dart';
import '../models/staus_model.dart';
import '../result/result.dart';
import 'http_methos_enum.dart';

/// A class that handles HTTP client operations using the Dio package.
class HttpClient {
  static late Dio _client;

  /// Returns the Dio instance.
  Dio get instance => _client;

  String? baseUrl;
  bool? userToken;

  /// Constructor for HttpClient.
  ///
  /// [baseUrl] is the base URL for the HTTP client.
  /// [userToken] indicates whether to use a user token for authorization.
  HttpClient({this.baseUrl, userToken = false}) {
    baseUrl = HttpUrlsEnveiroment().baseUrl!;
    BaseOptions _options = BaseOptions(
      connectTimeout: Duration(milliseconds: 60000),
      receiveTimeout: Duration(milliseconds: 60000),
      sendTimeout: Duration(milliseconds: 60000),
      responseType: ResponseType.json,
      baseUrl: baseUrl!,
    );
    _client = Dio(_options);
    _client.interceptors.add(PrettyDioLogger());
    if (userToken) {
      var headderAuth = HttpHeader();
      String authorizationHeader = headderAuth.usertoken;
      _client.options.headers["Authorization"] = authorizationHeader;
      _client.options.headers["Content-Type"] = "application/json";
    }
  }

  /// Sends an HTTP request and returns the response data.
  ///
  /// [method] is the HTTP method to use.
  /// [url] is the endpoint URL.
  /// [headers] are the request headers.
  /// [queryParameters] are the query parameters.
  /// [body] is the request body.
  /// [cancelToken] is the cancel token for the request.
  Future<T> sendRequestValue<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    Response response;
    if (headers == null) {
      headers = _client.options.headers ?? {};
    }
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }

      return response.data;
    } catch (e) {
      throw e;
    }
  }

  /// Sends an HTTP request and returns a result with a map.
  ///
  /// [method] is the HTTP method to use.
  /// [url] is the endpoint URL.
  /// [headers] are the request headers.
  /// [queryParameters] are the query parameters.
  /// [body] is the request body.
  /// [cancelToken] is the cancel token for the request.
  Future<Result<RemoteBaseModel, Map<String, dynamic>>> sendRequestResultWithMap({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    Response<Map<String, dynamic>> response;
    if (headers == null) {
      headers = _client.options.headers ?? {};
    }
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }
      try {
        print("response.data ${response.data} ");
        Map<String, dynamic> data = {"status": "success", "data": response.data ?? ""};
        return Result.data(data);
      } on FormatException catch (e) {
        debugPrint(e.toString());
        return Result.error(RemoteBaseModel(message: e.message));
      } catch (e) {
        debugPrint(e.toString());
        return Result.error(RemoteBaseModel(error: e, message: e.toString(), status: StatusModel.error, data: null));
      }
    } on DioError catch (e) {
      print("e.response ${e}");
      var error = {"massage": e};
      return Result.error(RemoteBaseModel(message: error["massage"]!.message, status: StatusModel.error, data: "null"));
    } on SocketException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      print('catch error s$s');
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Sends an HTTP request and returns a result with a RemoteBaseModel.
  ///
  /// [method] is the HTTP method to use.
  /// [url] is the endpoint URL.
  /// [headers] are the request headers.
  /// [queryParameters] are the query parameters.
  /// [body] is the request body.
  /// [cancelToken] is the cancel token for the request.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> sendRequest({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    Response response;
    if (headers == null) {
      headers = _client.options.headers ?? {};
    }
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }
      try {
        var data = RemoteBaseModel(data: response.data ?? "", status: StatusModel.success, message: "");
        return Result.data(data);
      } on FormatException catch (e) {
        debugPrint(e.toString());
        return Result.error(RemoteBaseModel(message: e.message));
      } catch (e) {
        debugPrint(e.toString());
        return Result.error(RemoteBaseModel(error: e, message: e.toString(), status: StatusModel.error, data: null));
      }
    } on DioError catch (e) {
      print("e.response ${e}");
      var error = {"massage": e};
      return Result.error(RemoteBaseModel(message: error["massage"]!.message, status: StatusModel.error, data: "null"));
    } on SocketException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      print('catch error s$s');
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Sends an HTTP request and returns the response data as a JSON map.
  ///
  /// [method] is the HTTP method to use.
  /// [url] is the endpoint URL.
  /// [headers] are the request headers.
  /// [queryParameters] are the query parameters.
  /// [body] is the request body.
  /// [cancelToken] is the cancel token for the request.
  Future<Map<String, dynamic>> sendRequestJsonMap({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    Response<Map<String, dynamic>> response;
    if (headers == null) {
      headers = _client.options.headers ?? {};
    }
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }
      try {
        return response.data! as Map<String, dynamic>;
      } on FormatException catch (e) {
        debugPrint(e.toString());
        throw e;
      } catch (e) {
        debugPrint(e.toString());
        throw e;
      }
    } on DioError catch (e) {
      print("e.response ${e.error}");
      throw e;
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } catch (e, s) {
      print('catch error s$s');
      throw e;
    }
  }

  /// Uploads a file and returns the result.
  ///
  /// [url] is the endpoint URL.
  /// [fileKey] is the key for the file in the form data.
  /// [filePath] is the path to the file.
  /// [fileName] is the name of the file.
  /// [mediaType] is the media type of the file.
  /// [data] is additional form data.
  /// [headers] are the request headers.
  /// [onSendProgress] is the callback for send progress.
  /// [onReceiveProgress] is the callback for receive progress.
  /// [cancelToken] is the cancel token for the request.
  Future<Result<RemoteBaseModel, T>> upload<T>({
    required String url,
    required String fileKey,
    required String filePath,
    required String fileName,
    required MediaType mediaType,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    dataMap.addAll({
      fileKey: await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: mediaType,
      )
    });
    try {
      if (headers == null) {
        headers = _client.options.headers ?? {};
      }
      Response<T> response = await _client.post(
        url,
        data: FormData.fromMap(dataMap),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      try {
        return Result.data(response.data!);
      } on FormatException {
        return Result.error(RemoteBaseModel(message: FormatError().toString()));
      } catch (e) {
        return Result.error(RemoteBaseModel(message: e.toString()));
      }
    } on DioError catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on SocketException {
      return Result.error(RemoteBaseModel(message: SocketError().toString()));
    } on HttpException {
      return Result.error(RemoteBaseModel(message: ConnectionError().toString()));
    } catch (e, s) {
      print('catch error s$s');
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Uploads a file and returns the result with a map.
  ///
  /// [url] is the endpoint URL.
  /// [fileKey] is the key for the file in the form data.
  /// [file] is the MultipartFile object.
  /// [data] is additional form data.
  /// [headers] are the request headers.
  /// [onSendProgress] is the callback for send progress.
  /// [onReceiveProgress] is the callback for receive progress.
  /// [cancelToken] is the cancel token for the request.
  Future<Result<RemoteBaseModel, Map<String, dynamic>>> uploadMapResultWithMap<T>({
    required String url,
    required String fileKey,
    required MultipartFile file,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    dataMap.addAll({fileKey: file});
    try {
      if (headers == null) {
        headers = _client.options.headers ?? {};
      }

      Response<Map<String, dynamic>> response = await _client.post(
        url,
        data: FormData.fromMap(dataMap),
        onSendProgress: onSendProgress ?? (int sent, int total) {
          print("send $sent $total");
        },
        onReceiveProgress: onReceiveProgress ?? (int sent, int total) {
          print("rece $sent $total");
        },
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return Result.data(response.data!);
    } on FormatException {
      return Result.error(RemoteBaseModel(message: FormatError().toString()));
    } catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    } on DioError catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on SocketException {
      return Result.error(RemoteBaseModel(message: SocketError().toString()));
    } on HttpException {
      return Result.error(RemoteBaseModel(message: ConnectionError().toString()));
    } catch (e, s) {
      print('catch error s$s');
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }

  /// Uploads a file and returns the result with a RemoteBaseModel.
  ///
  /// [url] is the endpoint URL.
  /// [fileKey] is the key for the file in the form data.
  /// [file] is the MultipartFile object.
  /// [data] is additional form data.
  /// [headers] are the request headers.
  /// [onSendProgress] is the callback for send progress.
  /// [onReceiveProgress] is the callback for receive progress.
  /// [cancelToken] is the cancel token for the request.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> uploadMapResult<T>({
    required String url,
    required String fileKey,
    required MultipartFile file,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    if (headers == null) {
      headers = _client.options.headers ?? {};
    }
    dataMap.addAll({fileKey: file});
    try {
      Response<Map<String, dynamic>> response = await _client.post(
        url,
        data: FormData.fromMap(dataMap),
        onSendProgress: onSendProgress ?? (int sent, int total) {
          print("send $sent $total");
        },
        onReceiveProgress: onReceiveProgress ?? (int sent, int total) {
          print("rece $sent $total");
        },
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return Result.data(RemoteBaseModel(data: response.data!, status: StatusModel.success, message: response.data!["message"]));
    } on FormatException {
      return Result.error(RemoteBaseModel(message: FormatError().toString()));
    } catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    } on DioError catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on SocketException {
      return Result.error(RemoteBaseModel(message: SocketError().toString()));
    } on HttpException {
      return Result.error(RemoteBaseModel(message: ConnectionError().toString()));
    } catch (e, s) {
      print('catch error s$s');
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }
}
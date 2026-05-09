import 'dart:io';
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
import '../functions/jd_repo_console.dart';

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
  HttpClient({String? baseUrl, this.userToken = false}) {
    this.baseUrl = baseUrl ?? HttpUrlsEnveiroment().baseUrl;
    BaseOptions _options = BaseOptions(
      connectTimeout: Duration(milliseconds: 60000),
      receiveTimeout: Duration(milliseconds: 60000),
      sendTimeout: kIsWeb ? null : Duration(milliseconds: 60000),
      responseType: ResponseType.json,
      baseUrl: this.baseUrl ?? "",
    );
    _client = Dio(_options);
    _client.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));
    var headderAuth = HttpHeader();
    if (headderAuth.langValue != null) {
      _client.options.headers[headderAuth.langKey] = headderAuth.langValue;
    }
    if (userToken!) {
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
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
        case HttpMethod.PATCH:
          response = await _client.patch(
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
  Future<Result<RemoteBaseModel, Map<String, dynamic>>>
      sendRequestResultWithMap({
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
        case HttpMethod.PATCH:
          response = await _client.patch(
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
        final responseData = response.data;
        jdRepoConsole("response.data $responseData ");

        // التحقق من حالة النجاح من داخل الـ JSON
        if (responseData != null && responseData['success'] == false) {
          final errorMessage = responseData['message'] ?? "Unknown API Error";
          // لوج للمطورين فقط
          JDRepoConsole.error("API Error Response: $errorMessage",
              context:
                  LogContext(module: 'HttpClient', metadata: responseData));

          return Result.error(RemoteBaseModel(
            message: errorMessage,
            status: StatusModel.error,
            data: responseData,
          ));
        }

        Map<String, dynamic> data = {
          "status": "success",
          "data": responseData ?? ""
        };
        return Result.data(data);
      } on FormatException catch (e) {
        JDRepoConsole.error("Format Error: ${e.message}",
            context: LogContext(module: 'HttpClient', metadata: e));
        return Result.error(RemoteBaseModel(message: e.message));
      } catch (e) {
        JDRepoConsole.error("Unexpected Error: $e",
            context: LogContext(module: 'HttpClient', metadata: e));
        return Result.error(RemoteBaseModel(
            error: e,
            message: e.toString(),
            status: StatusModel.error,
            data: null));
      }
    } on DioError catch (e) {
      // استخراج رسالة الخطأ العربية من الـ Response إذا وجدت
      String message = e.message ?? "Unknown Error";
      if (e.response?.data != null && e.response?.data is Map) {
        message = e.response?.data['message'] ?? message;
      }

      // لوج مفصل للمطور فقط يشمل الـ Response بالكامل
      JDRepoConsole.error("DioError [${e.response?.statusCode}]: ${e.message}",
          context:
              LogContext(module: 'HttpClient', metadata: e.response?.data));

      return Result.error(RemoteBaseModel(
          message: message,
          status: StatusModel.error,
          data: e.response?.data,
          error: e));
    } on SocketException catch (e) {
      JDRepoConsole.error("SocketException: ${e.message}");
      return Result.error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      JDRepoConsole.error("HttpException: ${e.message}");
      return Result.error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      JDRepoConsole.error('Critical Error: $e',
          context: LogContext(module: 'HttpClient', metadata: s));
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
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
        case HttpMethod.PATCH:
          response = await _client.patch(
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
        final responseData = response.data;

        // التحقق من حالة النجاح من داخل الـ JSON
        if (responseData is Map && responseData['success'] == false) {
          final errorMessage = responseData['message'] ?? "Unknown API Error";
          JDRepoConsole.error("API Error Response: $errorMessage",
              context:
                  LogContext(module: 'HttpClient', metadata: responseData));

          return Result.error(RemoteBaseModel(
            message: errorMessage,
            status: StatusModel.error,
            data: responseData,
          ));
        }

        var data = RemoteBaseModel(
            data: responseData ?? "",
            status: StatusModel.success,
            message:
                responseData is Map ? (responseData['message'] ?? "") : "");
        return Result.data(data);
      } on FormatException catch (e) {
        JDRepoConsole.error("Format Error: ${e.message}");
        return Result.error(RemoteBaseModel(message: e.message));
      } catch (e) {
        JDRepoConsole.error("Unexpected Error: $e");
        return Result.error(RemoteBaseModel(
            error: e,
            message: e.toString(),
            status: StatusModel.error,
            data: null));
      }
    } on DioError catch (e) {
      String message = e.message ?? "Unknown Error";
      if (e.response?.data != null && e.response?.data is Map) {
        message = e.response?.data['message'] ?? message;
      }

      JDRepoConsole.error("DioError: ${e.message}",
          context:
              LogContext(module: 'HttpClient', metadata: e.response?.data));

      return Result.error(RemoteBaseModel(
          message: message,
          status: StatusModel.error,
          data: e.response?.data,
          error: e));
    } on SocketException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      JDRepoConsole.error('Critical Error: $e',
          context: LogContext(module: 'HttpClient', metadata: s));
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
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
        case HttpMethod.PATCH:
          response = await _client.patch(
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
      JDRepoConsole.error("DioError JsonMap: ${e.message}",
          context:
              LogContext(module: 'HttpClient', metadata: e.response?.data));
      throw e;
    } on SocketException catch (e) {
      JDRepoConsole.error("SocketException JsonMap: ${e.message}");
      throw e;
    } on HttpException catch (e) {
      JDRepoConsole.error("HttpException JsonMap: ${e.message}");
      throw e;
    } catch (e, s) {
      JDRepoConsole.error('Critical JsonMap Error: $e',
          context: LogContext(module: 'HttpClient', metadata: s));
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
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
    bool isUpdate = false,
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
      Response<T> response;
      if (isUpdate) {
        response = await _client.put(
          url,
          data: FormData.fromMap(dataMap),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          options: Options(headers: headers),
          cancelToken: cancelToken,
        );
      } else {
        response = await _client.post(
          url,
          data: FormData.fromMap(dataMap),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          options: Options(headers: headers),
          cancelToken: cancelToken,
        );
      }

      try {
        return Result.data(response.data!);
      } on FormatException {
        return Result.error(RemoteBaseModel(message: FormatError().toString()));
      } catch (e) {
        return Result.error(RemoteBaseModel(message: e.toString()));
      }
    } on DioError catch (e) {
      String message = e.message ?? "Unknown Error";
      if (e.response?.data != null && e.response?.data is Map) {
        message = e.response?.data['message'] ?? message;
      }
      JDRepoConsole.error("DioError [Upload]: ${e.message}",
          context:
              LogContext(module: 'HttpClient', metadata: e.response?.data));
      return Result.error(RemoteBaseModel(message: message));
    } on SocketException {
      return Result.error(RemoteBaseModel(message: SocketError().toString()));
    } on HttpException {
      return Result.error(
          RemoteBaseModel(message: ConnectionError().toString()));
    } catch (e, s) {
      JDRepoConsole.error('Critical Upload Error: $e',
          context: LogContext(module: 'HttpClient', metadata: s));
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
  Future<Result<RemoteBaseModel, Map<String, dynamic>>>
      uploadMapResultWithMap<T>({
    required String url,
    required String fileKey,
    required MultipartFile file,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required CancelToken cancelToken,
    bool isUpdate = false,
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

      Response<Map<String, dynamic>> response;
      if (isUpdate) {
        response = await _client.put(
          url,
          data: FormData.fromMap(dataMap),
          onSendProgress: onSendProgress ??
              (int sent, int total) {
                jdRepoConsole("send $sent $total");
              },
          onReceiveProgress: onReceiveProgress ??
              (int sent, int total) {
                jdRepoConsole("rece $sent $total");
              },
          options: Options(headers: headers),
          cancelToken: cancelToken,
        );
      } else {
        response = await _client.post(
          url,
          data: FormData.fromMap(dataMap),
          onSendProgress: onSendProgress ??
              (int sent, int total) {
                jdRepoConsole("send $sent $total");
              },
          onReceiveProgress: onReceiveProgress ??
              (int sent, int total) {
                jdRepoConsole("rece $sent $total");
              },
          options: Options(headers: headers),
          cancelToken: cancelToken,
        );
      }

      return Result.data(response.data!);
    } on FormatException {
      return Result.error(RemoteBaseModel(message: FormatError().toString()));
    } catch (e) {
      return Result.error(RemoteBaseModel(message: e.toString()));
    } on DioError catch (e) {
      String message = e.message ?? "Unknown Error";
      if (e.response?.data != null && e.response?.data is Map) {
        message = e.response?.data['message'] ?? message;
      }
      JDRepoConsole.error("DioError [Upload]: ${e.message}",
          context:
              LogContext(module: 'HttpClient', metadata: e.response?.data));
      return Result.error(RemoteBaseModel(message: message));
    } on SocketException {
      return Result.error(RemoteBaseModel(message: SocketError().toString()));
    } on HttpException {
      return Result.error(
          RemoteBaseModel(message: ConnectionError().toString()));
    } catch (e, s) {
      JDRepoConsole.error('Critical Upload Error: $e',
          context: LogContext(module: 'HttpClient', metadata: s));
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
  ///
  /// The response should follow the format: { "success": bool, "message": string, "data": Any, "timestamp": string }
  /// or be compatible with jodija server.
  Future<Result<RemoteBaseModel, RemoteBaseModel>> uploadMapResult<T>({
    required String url,
    required String fileKey,
    required MultipartFile file,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required CancelToken cancelToken,
    bool isUpdate = false,
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
      Response<Map<String, dynamic>> response;
      if (isUpdate) {
        response = await _client.put(
          url,
          data: FormData.fromMap(dataMap),
          onSendProgress: onSendProgress ??
              (int sent, int total) {
                jdRepoConsole("send $sent $total");
              },
          onReceiveProgress: onReceiveProgress ??
              (int sent, int total) {
                jdRepoConsole("rece $sent $total");
              },
          options: Options(headers: headers),
          cancelToken: cancelToken,
        );
      } else {
        response = await _client.post(
          url,
          data: FormData.fromMap(dataMap),
          onSendProgress: onSendProgress ??
              (int sent, int total) {
                jdRepoConsole("send $sent $total");
              },
          onReceiveProgress: onReceiveProgress ??
              (int sent, int total) {
                jdRepoConsole("rece $sent $total");
              },
          options: Options(headers: headers),
          cancelToken: cancelToken,
        );
      }

      try {
        final responseData = response.data;

        // التحقق من حالة النجاح من داخل الـ JSON
        if (responseData is Map && responseData!['success'] == false) {
          final errorMessage = responseData!['message'] ?? "Unknown API Error";
          JDRepoConsole.error("API Error Response: $errorMessage",
              context:
                  LogContext(module: 'HttpClient', metadata: responseData));

          return Result.error(RemoteBaseModel(
            message: errorMessage,
            status: StatusModel.error,
            data: responseData,
          ));
        }

        var data = RemoteBaseModel(
            data: responseData ?? "",
            status: StatusModel.success,
            message:
                responseData is Map ? (responseData!['message'] ?? "") : "");
        return Result.data(data);
      } on FormatException catch (e) {
        JDRepoConsole.error("Format Error: ${e.message}");
        return Result.error(RemoteBaseModel(message: e.message));
      } catch (e) {
        JDRepoConsole.error("Unexpected Error: $e");
        return Result.error(RemoteBaseModel(
            error: e,
            message: e.toString(),
            status: StatusModel.error,
            data: null));
      }
    } on DioError catch (e) {
      String message = e.message ?? "Unknown Error";
      if (e.response?.data != null && e.response?.data is Map) {
        message = e.response?.data['message'] ?? message;
      }

      JDRepoConsole.error("DioError: ${e.message}",
          context:
              LogContext(module: 'HttpClient', metadata: e.response?.data));

      return Result.error(RemoteBaseModel(
          message: message,
          status: StatusModel.error,
          data: e.response?.data,
          error: e));
    } on SocketException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      return Result.error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      JDRepoConsole.error('Critical Error: $e',
          context: LogContext(module: 'HttpClient', metadata: s));
      return Result.error(RemoteBaseModel(message: e.toString()));
    }
  }
}

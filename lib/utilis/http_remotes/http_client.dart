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

class JoDijaHttpClient {
  static late Dio _client;

  Dio get instance => _client;
  String? baseUrl;
  bool? userToken;

  JoDijaHttpClient({this.baseUrl   , userToken = false}) {
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
      String authorizationHeader =
          headderAuth.usertoken;
      _client.options.headers["Authorization"] = authorizationHeader;
      _client.options.headers["Content-Type"] = "application/json";
    }


  }

  Future< T  >  sendRequestValue<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response response;
    if (headers == null) {
      headers = _client.options.headers??{};
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
    }  catch (e) {

      throw e ;
    }
  }


  Future<Result<RemoteBaseModel, Map<String , dynamic> >> sendRequestResultWithMap ({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response<Map<String , dynamic>> response;
    if (headers == null) {
      headers = _client.options.headers??{};
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
        /// dismiss progress dialog

        // Get the decoded json
        print("response.data ${response.data} ");
        Map<String ,dynamic> data = { "status" : "success" , "data": response.data??"" } ;
        return Result.data ( data );
      } on FormatException catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return  Result. error (RemoteBaseModel(message: e.message));
      } catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return Result. error(RemoteBaseModel(error: e , message: e.toString() , status:  StatusModel.error  , data:  null ));
      }
    }
    // Handling errors
    on DioError catch (e) {
      /// dismiss progress dialog

      print("e.response ${e}");
      var error = {"massage": e };
      return Result. error(RemoteBaseModel(message: error["massage"]!.message , status: StatusModel.error , data:  "null"));
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      /// dismiss progress dialog

      return Result. error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      /// dismiss progress dialog

      return Result. error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      /// dismiss progress dialog

      print('catch error s$s');
      return Result. error(RemoteBaseModel(message: e.toString()));
    }
  }
  Future<Result<RemoteBaseModel,  RemoteBaseModel >> sendRequest ({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response response;
    if (headers == null) {
      headers = _client.options.headers??{};
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
       var data = RemoteBaseModel(data: response.data??"" , status: StatusModel.success ,message: "" );
        return Result.data ( data );
      } on FormatException catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return  Result. error (RemoteBaseModel(message: e.message));
      } catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return Result. error(RemoteBaseModel(error: e , message: e.toString() , status: StatusModel.error  , data:  null ));
      }
    }
    // Handling errors
    on DioError catch (e) {
      /// dismiss progress dialog

      print("e.response ${e}");
      var error = {"massage": e };
      return Result. error(RemoteBaseModel(message: error["massage"]!.message , status: StatusModel.error , data:  "null"));
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      /// dismiss progress dialog

      return Result. error(RemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      /// dismiss progress dialog

      return Result. error(RemoteBaseModel(message: e.message));
    } catch (e, s) {
      /// dismiss progress dialog

      print('catch error s$s');
      return Result. error(RemoteBaseModel(message: e.toString()));
    }
  }


  Future< Map<String ,dynamic >> sendRequestJsonMap({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response<Map<String , dynamic >> response;
    if (headers == null) {
      headers = _client.options.headers??{};
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

        return response.data!  as Map<String ,dynamic >;
      } on FormatException catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        throw e ;
      } catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        throw e ;
      }
    }
    // Handling errors
    on DioError catch (e) {
      /// dismiss progress dialog

      print("e.response ${e.error}");
      throw e ;
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      /// dismiss progress dialog

      throw e ;
    } on HttpException catch (e) {
      /// dismiss progress dialog

      throw e ;
    } catch (e, s) {
      /// dismiss progress dialog

      print('catch error s$s');
      throw e ;
    }
  }
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
        headers = _client.options.headers??{};
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
        // Get the decoded json
        return  Result.data(response.data!);
      } on FormatException {
        return Result.error( RemoteBaseModel(message: FormatError().toString() ,));
      } catch (e) {
        return  Result.error( RemoteBaseModel(message: e.toString() ,));
      }
    }
    // Handling errors
    on DioError catch (e) {
    return Result.error( RemoteBaseModel (message: e.message));
    }
    //  return Left(_handleDioError(e));


    // Couldn't reach out the server
    on SocketException {
      return  Result.error( RemoteBaseModel(message: SocketError().toString() ,));
    } on HttpException {
      return  Result.error( RemoteBaseModel(message: ConnectionError().toString() ,));
    } catch (e, s) {
      print('catch error s$s');
      return  Result.error( RemoteBaseModel(message: e.toString() ,));
    }
  }
  Future<Result<RemoteBaseModel, Map<String ,dynamic> >> uploadMapResultWithMap<  T >({
    required String url,
    required String fileKey,
     required MultipartFile  file  ,
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
      fileKey:   file});
    try {
      if (headers == null) {
        headers = _client.options.headers??{};
      }

      Response<Map<String , dynamic >> response = await _client.post(
        url,
         data: FormData.fromMap(dataMap),

        onSendProgress: onSendProgress?? (int sent, int total) {
          print("send $sent $total");
        } ,
        onReceiveProgress: onReceiveProgress?? (int sent, int total) {
          print(" rece $sent $total");
        } ,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );


        // Get the decoded json
        return  Result.data(response.data!);
      } on FormatException {
        return Result.error( RemoteBaseModel(message: FormatError().toString() ,));
      } catch (e) {
        return  Result.error( RemoteBaseModel(message: e.toString() ,));
      }

    // Handling errors
    on DioError catch (e) {
      return Result.error( RemoteBaseModel (message: e.message));
    }

    on SocketException {
      return  Result.error( RemoteBaseModel(message: SocketError().toString() ,));
    } on HttpException {
      return  Result.error( RemoteBaseModel(message: ConnectionError().toString() ,));
    } catch (e, s) {
      print('catch error s$s');
      return  Result.error( RemoteBaseModel(message: e.toString() ,));
    }
  }

  Future<Result<RemoteBaseModel, RemoteBaseModel >> uploadMapResult<  T >({
    required String url,
    required String fileKey,
    required MultipartFile  file  ,
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
      headers = _client.options.headers??{};
    }
    dataMap.addAll({
      fileKey:   file});
    try {
      Response<Map<String , dynamic >> response = await _client.post(
        url,
        data: FormData.fromMap(dataMap),

        onSendProgress: onSendProgress?? (int sent, int total) {
          print("send $sent $total");
        } ,
        onReceiveProgress: onReceiveProgress?? (int sent, int total) {
          print(" rece $sent $total");
        } ,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return  Result.data( RemoteBaseModel(data: response.data! , status: StatusModel.success , message: response.data!["message"] ));
    } on FormatException {
      return Result.error( RemoteBaseModel(message: FormatError().toString() ,));
    } catch (e) {
      return  Result.error( RemoteBaseModel(message: e.toString() ,));
    }

    // Handling errors
    on DioError catch (e) {
      return Result.error( RemoteBaseModel (message: e.message));
    }

    on SocketException {
      return  Result.error( RemoteBaseModel(message: SocketError().toString() ,));
    } on HttpException {
      return  Result.error( RemoteBaseModel(message: ConnectionError().toString() ,));
    } catch (e, s) {
      print('catch error s$s');
      return  Result.error( RemoteBaseModel(message: e.toString() ,));
    }
  }

}

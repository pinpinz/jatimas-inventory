import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class BaseApi {
  late Dio dio;

  BaseApi() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://gtm.myesign.id/api',
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(milliseconds: 15 * 1000),
        receiveTimeout: Duration(milliseconds: 15 * 1000),
      ),
    )..interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
      ));
  }

  String authToken() {
    Box box = Hive.box('dataBox');
    return box.get('authToken', defaultValue: '');
  }

  ErrorApi errorHandler(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return ErrorApi.fromJson(
        {'message': 'Connect timeout'},
      );
    }

    if (error.type == DioExceptionType.receiveTimeout) {
      return ErrorApi.fromJson(
        {'message': 'Receive timeout'},
      );
    }

    if (error.type == DioExceptionType.values) {
      return ErrorApi.fromJson(
        {'message': error.message},
      );
    }

    return ErrorApi.fromJson(json.decode(error.response.toString()));
  }
}

class RespApi {
  int? code;
  int? timestamp;
  String? message;
  dynamic data;
  bool? success;

  RespApi({
    this.code,
    this.timestamp,
    this.message,
    this.data,
    this.success,
  });

  RespApi.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    timestamp = json['timestamp'];
    message = json['message'];
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['timestamp'] = timestamp;
    data['message'] = message;
    data['data'] = this.data;
    data['success'] = success;
    return data;
  }
}

class ErrorApi {
  int? status;
  String? error;
  String? message;

  ErrorApi({this.status, this.error, this.message});

  ErrorApi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

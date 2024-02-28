import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'base_api.dart';

class ContactApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> getList(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/core/contact/list/0/9999',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> update(Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/contact/update', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> delete(Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/contact/delete', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> search(String name) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/core/user/searchuser/$name');
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }
}

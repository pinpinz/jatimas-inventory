import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'base_api.dart';

class CommentApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> getList(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/signing/document/getdiscussionall/0/9999',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getListComment(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/signing/document/getdiscussion',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> updateComment(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/signing/document/updatecomment',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }
}

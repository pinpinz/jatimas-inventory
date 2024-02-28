import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/document_model.dart';
import 'base_api.dart';

class DocumentApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> getList(
      Map<String, dynamic> payload, String status) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/signing/document/listuserpdf/0/9999/$status',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getDetail(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/signing/document/detailpdf',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = DocumentModel.fromJson(data.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> requestOtp(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/otp/requestotp', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> initSign(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/signing/initsign', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> userSign(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/signing/usersign', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> signType(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/core/masterdata/signtype',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> signRole(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/core/masterdata/signrole',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }
}

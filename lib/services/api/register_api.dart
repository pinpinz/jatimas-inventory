import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/auth_model.dart';
import 'base_api.dart';

class RegisterApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> register(
      Map<String, dynamic> payload) async {
    try {
      var resp =
          await dio.post('/register/register', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> verification(
      Map<String, dynamic> payload) async {
    try {
      var resp =
          await dio.post('/register/verification', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> validatePhone(
      Map<String, dynamic> payload) async {
    try {
      var resp =
          await dio.post('/otp/validatephone', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> changePassword(
      Map<String, dynamic> payload) async {
    try {
      var resp =
          await dio.post('/register/changepass', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = AuthModel.fromJson(data.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> registerUpdate(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/register/update', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }
}

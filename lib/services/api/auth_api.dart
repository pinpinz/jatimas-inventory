import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/auth_model.dart';
import '../../models/cert_model.dart';
import '../../models/user_model.dart';
import 'base_api.dart';

class AuthApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> login(Map<String, dynamic> payload) async {
    try {
      var resp = await dio.post('/auth/user', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = AuthModel.fromJson(data.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getCert(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/user/certdetail', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = CertModel.fromJson(data.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getQuota(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/user/getquota', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getAvatar(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/user/getavatar', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getNotif() async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.get('/core/user/getNotif/0/9999');
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> getUser(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/user/getdetail', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = UserModel.fromJson(data.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> changePassword(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/core/user/changepassword',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> changePhone(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp =
          await dio.post('/core/user/changephone', data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }

  Future<Either<ErrorApi, RespApi>> updateToken(
      Map<String, dynamic> payload) async {
    dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

    try {
      var resp = await dio.post('/auth/firebase/updatetoken',
          data: json.encode(payload));
      var data = RespApi.fromJson(resp.data);

      return Right(data);
    } on DioError catch (error) {
      return Left(errorHandler(error));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/auth/model/Login_response.dart';
import 'package:e_commerce/util/auth_header.dart';

import '../model/register_response.dart';
import '../../util/dio_exception.dart';
import '../../util/failure.dart';

class LoginRegisterService {
  final Dio _dio;

  LoginRegisterService(this._dio);

  Future<Either<Failure, RegisterResponse>> register(
      {required String userName,
      required String email,
      required String password}) async {
    final formData = {
      "username": userName,
      "email": email,
      "password": password
    };
    try {
      final result = await _dio.post('/customers', data: formData);
      return right(RegisterResponse.fromJson(result.data));
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, LoginResponse>> login(
      {required String userName, required String password}) async {
    final formData = {"username": userName, "password": password};
    try {
      final result =
          await _dio.post('/wp-json/jwt-auth/v1/token', data: formData);
      return right(LoginResponse.fromJson(result.data));
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, bool>> validateLogin(String token) async {
    try {
      final result = await _dio.post('/wp-json/jwt-auth/v1/token/validate',
          options: Options(headers: authHeader(token)));
      bool isSuccess = result.statusCode == 200 ? true : false;
      return right(isSuccess);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}

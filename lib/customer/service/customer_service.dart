import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/auth/model/register_response.dart';

import '../../util/dio_exception.dart';
import '../../util/failure.dart';

class CustomerService {
  final Dio _dio;

  CustomerService(this._dio);

  Future<Either<Failure, RegisterResponse>> createCustomer(
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
}

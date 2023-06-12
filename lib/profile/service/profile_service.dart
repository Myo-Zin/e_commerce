import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/auth/model/register_response.dart';
import 'package:e_commerce/profile/model/profile_data_response.dart';

import '../../util/dio_exception.dart';
import '../../util/failure.dart';

class ProfileService {
  final Dio _dio;

  ProfileService(this._dio);

  Future<Either<Failure, ProfileDataResponse>> getProfile({
    required String email,
  }) async {
    final formData = {
      "email": email,
    };
    try {
      final result =
          await _dio.get('/wp-json/wc/v3/customers', queryParameters: formData);

      return right(ProfileDataResponse.fromJson(result.data[0]));
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/category/model/Product_category.dart';
import 'package:e_commerce/auth/model/register_response.dart';

import '../../util/dio_exception.dart';
import '../../util/failure.dart';

class CategoryService {
  final Dio _dio;

  CategoryService(this._dio);

  Future<Either<Failure,List<ProductCategory>>> getProductCategory() async {
    try {
      final result = await _dio.get('/wp-json/wc/v3/products/categories');
      final List<dynamic>? list = result.data;
      final categoryList = list?.map((e) => ProductCategory.fromJson(e)).toList();
      return right(categoryList??[]);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}

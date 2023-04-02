import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/order/model/Order_history_response.dart';

import '../../util/dio_exception.dart';
import '../../util/failure.dart';

class OrderService {
  final Dio _dio;

  OrderService(this._dio);

  Future<Either<Failure, List<OrderHistoryResponse>>> getOrderHistory(
      {required int customerId}) async {
    final queryParam = {
      "customer_id": customerId,
    };
    try {
      final result =
          await _dio.get('/wp-json/wc/v3/orders/', queryParameters: queryParam);
      final List<dynamic>? list = result.data;
      final orderHistoryList = list?.map((e) => OrderHistoryResponse.fromJson(e)).toList();
      return right(orderHistoryList??[]);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}

import 'package:e_commerce/order/controller/order_history_controller.dart';
import 'package:e_commerce/order/model/Order_history_response.dart';
import 'package:e_commerce/order/service/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network.dart';

final orderServiceProvider =
    Provider((ref) => OrderService(ref.read(dioProvider)));

final orderHistoryController = StateNotifierProvider.autoDispose
    .family<OrderHistoryNotifier, AsyncValue<List<OrderHistoryResponse>>, int>(
  (ref, customerId) =>
      OrderHistoryNotifier(ref.watch(orderServiceProvider), customerId),
);

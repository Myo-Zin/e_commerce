import 'package:e_commerce/order/model/Order_history_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/order_service.dart';

class OrderHistoryNotifier
    extends StateNotifier<AsyncValue<List<OrderHistoryResponse>>> {
  final OrderService _orderService;
  int customerId;

  OrderHistoryNotifier(this._orderService, this.customerId)
      : super(const AsyncLoading()) {
    getOrderHistory(customerId);
  }

  void getOrderHistory(int customerId) async {
    state = const AsyncLoading();
    final result = await _orderService.getOrderHistory(customerId: customerId);

    result.fold((l) {
      if (mounted) {
        state = AsyncError(l.message, StackTrace.empty);
      }
    }, (r) {
      if (mounted) {
        state = AsyncData(r);
      }
    });
  }
}

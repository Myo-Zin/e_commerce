import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/order.dart';

import '../../data/api_const.dart';

class OrderHistoryNotifier
    extends StateNotifier<AsyncValue<List<WooOrder>>> {
  int customerId;

  OrderHistoryNotifier( this.customerId)
      : super(const AsyncLoading()) {
    getOrderHistory(customerId);
  }

  void getOrderHistory(int customerId) async {
    state = const AsyncLoading();
    try{
      final result = await ApiHelper.wooCommerce.getOrders(customer: customerId);
      state = AsyncData(result);
    }catch(e){
      state = AsyncError(e, StackTrace.empty);
    }

    //final result = await _orderService.getOrderHistory(customerId: customerId);

    // result.fold((l) {
    //   if (mounted) {
    //     state = AsyncError(l.message, StackTrace.empty);
    //   }
    // }, (r) {
    //   if (mounted) {
    //     state = AsyncData(r);
    //   }
    // });
  }
}

final orderHistoryController = StateNotifierProvider.autoDispose
    .family<OrderHistoryNotifier, AsyncValue<List<WooOrder>>, int>(
      (ref, customerId) =>
      OrderHistoryNotifier( customerId),
);


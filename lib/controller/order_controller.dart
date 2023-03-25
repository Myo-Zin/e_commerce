
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/order.dart';
import '../repository/repository.dart';

// final orderController =  FutureProvider.family<Order,Order>((ref,order)  {
//   final repository = ref.watch(repositoryProvider);
//   return  repository.orderProduct(order);
// });

final orderStateProvider = StateProvider.autoDispose<Order?>((_)=> null);
final orderViewController = Provider((ref){
  return OrderViewController(ref);
});


class OrderViewController{
  final ProviderRef ref;

  OrderViewController(this.ref);
  Future order(Order order) async{
    final orderRepository = ref.watch(repositoryProvider);

    try{
      final result = orderRepository.orderProduct(order);
      result.then((value) => ref.read(orderStateProvider.notifier).state =value );

    }on DioError catch(e){
      final error = e.response== null
          ? "something went wrong!"
          : e.response?.data['message'] ?? "something went wrong!";
      ref.read(orderStateProvider.notifier).state = error;
    }

  }
}
import 'package:e_commerce/cart/model/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_list_controller.dart';

final totalPriceProvider = StateProvider<int>((ref) {
  final state = ref.watch(cartListController);
  final list =
      state.asData?.value.where((e) => e.isSelected == true).toList() ?? [];
  int totalPrice = 0;
  for (var element in list) {
    totalPrice += int.parse(element.prices!.price!) * element.quantity!;
  }
  return totalPrice;
});



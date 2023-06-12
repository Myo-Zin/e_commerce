import 'package:e_commerce/cart/model/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/auth_controller.dart';
import '../../data/api_const.dart';
import '../../data/network.dart';
import '../model/cart_item.dart';
import '../service/cart_service.dart';

class CartListNotifier extends StateNotifier<AsyncValue<List<CartItem>>> {
  final Ref ref;
  final CartService _cartService;

  CartListNotifier(this.ref, this._cartService)
      : super(const AsyncValue.loading()) {
    final authState = ref.watch(authControllerProvider);
    authState.maybeWhen(
      authenticated: () {
        getCart();
      },
      orElse: () {
        state = const AsyncValue.data([]);
      },
    );
  }

  getCart() async {
    try {
      const CartState.loading();
      final token = await ApiHelper.wooCommerce.getAuthTokenFromDb();
      final result = await _cartService.getMyCartItem(token);
      state = AsyncValue.data(result);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  void select(int id) {
    state.whenData((list) {
      state = AsyncData([
        for (final td in list)
          if (td.id == id) td.copyWith(isSelected: !td.isSelected!) else td
      ]);
    });
  }

  void selectAll(int id) {
    state.whenData((list) {
      state = AsyncData(
          [for (final td in list) td.copyWith(isSelected: !td.isSelected!)]);
    });
  }
}

final cartServiceProvider =
    Provider((ref) => CartService(ref.watch(dioProvider)));
final cartListController =
    StateNotifierProvider<CartListNotifier, AsyncValue<List<CartItem>>>((ref) {
  return CartListNotifier(ref, ref.watch(cartServiceProvider));
});

import 'package:e_commerce/cart/service/cart_service.dart';
import 'package:e_commerce/data/api_const.dart';
import 'package:e_commerce/data/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NonceNotifier extends StateNotifier<AsyncValue<String>> {
  final CartService _cartService;
  final Ref ref;

  NonceNotifier(this._cartService, this.ref)
      : super(const AsyncValue.loading());

  Future<void> getNonce() async {
    final token = await ApiHelper.wooCommerce.getAuthTokenFromDb();
    final result = await _cartService.getNonce(token);

    // result.fold((l) {
    //   if (mounted) {
    //     state = AsyncError(l.message, StackTrace.empty);
    //
    //   }
    // }, (r) {
    //   if (mounted) {
    //     state = AsyncData(r);
    //   }
    // });
  }
}

final cartServiceProvider =
Provider((ref) => CartService(ref.watch(dioProvider)));

final nonceController = StateNotifierProvider<NonceNotifier,
    AsyncValue<String>>((ref) =>
    NonceNotifier(ref.watch(cartServiceProvider), ref));

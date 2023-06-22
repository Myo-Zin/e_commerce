import 'package:e_commerce/cart/controller/cart_list_controller.dart';
import 'package:e_commerce/cart/controller/total_price_cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api_const.dart';
import '../../data/network.dart';
import '../service/cart_service.dart';

class CartNotifier extends StateNotifier<AsyncValue<void>> {
  final CartService _cartService;
  final Ref ref;

  CartNotifier(this._cartService, this.ref)
      : super(const AsyncValue.data(null));

  Future<String> getNonce() async {
    final token = await ApiHelper.wooCommerce.getAuthTokenFromDb();
    try {
      state = const AsyncLoading();
      final result = await _cartService.getNonce(token);
      state = const AsyncValue.data(null);
      return result;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
      return e.toString();
    }

    // return result.fold((l) {
    //   return l.message;
    // }, (r) {
    //   return r;
    // });
  }

  Future<bool> addToCart({required int itemId, required int quantity}) async {
    try {
      state = const AsyncLoading();
      final token = await ApiHelper.wooCommerce.getAuthTokenFromDb();
      final nonce = await getNonce();
      debugPrint("nonce $nonce");
      //await ApiHelper.wooCommerce.addToMyCart(itemId: itemId.toString(), quantity: quantity.toString());
      await _cartService.addToMyCart(
          token: token,
          nonce: nonce,
          itemId: itemId.toString(),
          quantity: quantity.toString());
      state = const AsyncValue.data(null);
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
      return false;
    }
    state = const AsyncLoading();

    // final result = await _cartService.addToMyCart(
    //     token: token, nonce: nonce, itemId: itemId, quantity: quantity);
    // return result.fold((l) {
    //   state = AsyncValue.error(l.message, StackTrace.empty);
    //   return false;
    // }, (r) {
    //   state = const AsyncValue.data(null);
    //   return true;
    // });
  }

  Future<bool> deleteCart({required String key}) async {
    try {
      state = const AsyncLoading();
      final token = await ApiHelper.wooCommerce.getAuthTokenFromDb();
      final nonce = await getNonce();
      await _cartService.delete(key: key, token: token, nonce: nonce);
      state = const AsyncValue.data(null);
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
      return false;
    }
  }

  Future<bool> updateCart(
      {required String key, required int id, required quantity}) async {
    try {
      state = const AsyncLoading();
      final token = await ApiHelper.wooCommerce.getAuthTokenFromDb();
      final nonce = await getNonce();
      await _cartService.updateMyCartItemByKey(
          key: key, id: id, quantity: quantity, token: token, nonce: nonce);
      state = const AsyncValue.data(null);
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
      return false;
    }
  }
}

final cartServiceProvider =
    Provider((ref) => CartService(ref.watch(dioProvider)));
final cartController =
    StateNotifierProvider.autoDispose<CartNotifier, AsyncValue<void>>((ref) {
  return CartNotifier(ref.watch(cartServiceProvider), ref);
});

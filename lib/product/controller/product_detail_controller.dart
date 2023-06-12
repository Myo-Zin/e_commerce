import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

import '../../data/api_const.dart';

class ProductDetailNotifier extends StateNotifier<AsyncValue<WooProduct>> {
  final int id;

  ProductDetailNotifier(this.id) : super(const AsyncLoading()) {
    getProductCategory();
  }

  void getProductCategory() async {
    state = const AsyncLoading();

    try {
      final result = await ApiHelper.wooCommerce.getProductById(id: id);
      state = AsyncData(result);
      //state = state.copyWith(
      // );
    } catch (e) {
      state = AsyncError(e, StackTrace.empty);
      //state = state.copyWith(error: e.toString());
    }
  }
}

final productDetailController = StateNotifierProvider.autoDispose
    .family<ProductDetailNotifier, AsyncValue<WooProduct>, int>(
  (ref, id) => ProductDetailNotifier(id),
);

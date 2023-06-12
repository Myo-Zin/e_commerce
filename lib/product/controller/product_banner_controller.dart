import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

import '../../data/api_const.dart';

class ProductBannerNotifier extends StateNotifier<AsyncValue<List<WooProduct>>> {
  ProductBannerNotifier() : super(const AsyncLoading()) {
    getProductCategory();
  }

  void getProductCategory() async {
    state = const AsyncLoading();

    try {
      final result = await ApiHelper.wooCommerce.getProducts(featured: true);
      state = AsyncData(result);
      //state = state.copyWith(
      // );
    } catch (e) {
      state = AsyncError(e, StackTrace.empty);
      //state = state.copyWith(error: e.toString());
    }
  }
}

final productBannerController = StateNotifierProvider.autoDispose<ProductBannerNotifier,
    AsyncValue<List<WooProduct>>>(
  (ref) => ProductBannerNotifier(),
);

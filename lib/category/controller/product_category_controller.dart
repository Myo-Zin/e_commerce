import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/product_category.dart';

import '../../data/api_const.dart';

class ProductCategoryNotifier
    extends StateNotifier<AsyncValue<List<WooProductCategory>>> {
  ProductCategoryNotifier() : super(const AsyncLoading()) {
    getProductCategory();
  }

  void getProductCategory() async {
    state = const AsyncLoading();

    try {
      final result = await ApiHelper.wooCommerce.getProductCategories();
      state = AsyncData(result);
      //state = state.copyWith(
      // );
    } catch (e) {
      state = AsyncError(e, StackTrace.empty);
      //state = state.copyWith(error: e.toString());
    }
  }
}

final productCategoryController = StateNotifierProvider.autoDispose<
    ProductCategoryNotifier, AsyncValue<List<WooProductCategory>>>(
  (ref) => ProductCategoryNotifier(),
);

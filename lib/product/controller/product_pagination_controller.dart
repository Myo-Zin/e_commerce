import 'package:e_commerce/data/api_const.dart';
import 'package:e_commerce/product/model/product_param.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/pagination_state.dart';

final productsProvider =
    StateNotifierProvider.family<ProductNotifier, PaginatedProductState,ProductParameter?>((ref,param) {
  return ProductNotifier(param);
});

class ProductNotifier extends StateNotifier<PaginatedProductState> {
  final ProductParameter? param;
  ProductNotifier(this.param) : super(const PaginatedProductState()) {
    _initProducts();
  }

  _initProducts([int? initPage]) async {
    final page = initPage ?? state.page;
    final products = await ApiHelper.wooCommerce.getProducts(page: page,search: param?.searchParam,category: param?.category);

    if (products.isEmpty) {
      state = state.copyWith(page: page, isLoading: false,);
      return;
    }

    state = state.copyWith(page: page, isLoading: false, products: products,isLoadMoreDone: true);
  }

  loadMoreProduct() async {
    if (state.isLoading) {
      return;
    }
    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);

    final products =
        await ApiHelper.wooCommerce.getProducts(page: state.page + 1,search: param?.searchParam,category: param?.category);

    // if (products.isEmpty) {
    //   // error
    //   state = state.copyWith(isLoadMoreError: true, isLoading: false);
    //   return;
    // }

    if (products.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: products.isEmpty,
          products: [...?state.products, ...products]);
    } else {
      // not increment page
      state = state.copyWith(
        isLoading: false,
        isLoadMoreDone: products.isEmpty,
      );
    }
  }

  Future<void> refresh() async {
    _initProducts(1);
  }
}

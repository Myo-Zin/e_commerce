
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/product.dart';
import 'dart:async';

import '../repository/repository.dart';

part 'product_controller.freezed.dart';

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState({
    @Default(1) int page,
    List<Product>? products,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _ProductState;

  const ProductState._();
}

final productsProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ref);
});

class ProductNotifier extends StateNotifier<ProductState> {
  Ref ref;
  ProductNotifier(this.ref) : super(const ProductState()) {
    _initProducts();
  }

  _initProducts([int? initPage]) async {
    final page = initPage?? state.page;
    final products = await ref.read(repositoryProvider).getAllProduct(page);

    if (products.isEmpty) {
      state = state.copyWith(page: page, isLoading: false);
      return;
    }

    print('get post is ${products.length}');
    state = state.copyWith(page: page, isLoading: false, products: products);
  }

  loadMoreProduct() async {
    StringBuffer bf = StringBuffer();

    bf.write('try to request loading ${state.isLoading} at ${state.page + 1}');
    if (state.isLoading) {
      bf.write(' fail');
      return;
    }
    bf.write(' success');
    print(bf.toString());
    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);
     final products = await ref.read(repositoryProvider).getAllProduct(state.page + 1);


    if (products == null) {
      // error
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    print('load more ${products.length} products at page ${state.page + 1}');
    if (products.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: products.isEmpty,
          products: [...state.products!, ...products]);
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
final productsBySearchProvider = StateNotifierProvider.family<ProductBySearchNotifier, ProductState,String>((ref,search) {
  return ProductBySearchNotifier(ref,search);
});

class ProductBySearchNotifier extends StateNotifier<ProductState> {
  Ref ref;
  String search;
  ProductBySearchNotifier(this.ref,this.search) : super(const ProductState()) {
    _initProducts();
  }

  _initProducts([int? initPage]) async {
    final page = initPage?? state.page;
    final products = await ref.read(repositoryProvider).getAllProductBySearch(page,search);

    if (products.isEmpty) {
      state = state.copyWith(page: page, isLoading: false);
      return;
    }

    print('get post is ${products.length}');
    state = state.copyWith(page: page, isLoading: false, products: products);
  }

  loadMoreProduct() async {
    StringBuffer bf = StringBuffer();

    bf.write('try to request loading ${state.isLoading} at ${state.page + 1}');
    if (state.isLoading) {
      bf.write(' fail');
      return;
    }
    bf.write(' success');
    print(bf.toString());
    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);
    final products = await ref.read(repositoryProvider).getAllProductBySearch(state.page + 1,search);


    if (products == null) {
      // error
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    print('load more ${products.length} products at page ${state.page + 1}');
    if (products.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: products.isEmpty,
          products: [...state.products!, ...products]);
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
final productsByCategoryIdProvider = StateNotifierProvider.family<ProductByCategoryIdNotifier, ProductState,int>((ref,categoryId) {
  return ProductByCategoryIdNotifier(ref,categoryId);
});

class ProductByCategoryIdNotifier extends StateNotifier<ProductState> {
  Ref ref;
  int categoryId;
  ProductByCategoryIdNotifier(this.ref, this.categoryId,) : super(const ProductState()) {
    _initProducts();
  }

  _initProducts([int? initPage]) async {
    final page = initPage?? state.page;
    final products = await ref.read(repositoryProvider).getAllProductByCategoryId(page,categoryId);

    if (products.isEmpty) {
      state = state.copyWith(page: page, isLoading: false);
      return;
    }

    print('get post is ${products.length}');
    state = state.copyWith(page: page, isLoading: false, products: products);
  }

  loadMoreProduct() async {
    StringBuffer bf = StringBuffer();

    bf.write('try to request loading ${state.isLoading} at ${state.page + 1}');
    if (state.isLoading) {
      bf.write(' fail');
      return;
    }
    bf.write(' success');
    print(bf.toString());
    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);
    final products = await ref.read(repositoryProvider).getAllProductByCategoryId(state.page + 1,categoryId);


    if (products == null) {
      // error
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    print('load more ${products.length} products at page ${state.page + 1}');
    if (products.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: products.isEmpty,
          products: [...state.products!, ...products]);
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


final getRelatedIdController = FutureProvider.family<List<Product>,String>((ref,ids) => ref.watch(repositoryProvider).getRelatedProducts(ids));
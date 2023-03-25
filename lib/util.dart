
import 'controller/product_controller.dart';
import 'model/product.dart';

void initFetch(List<Product> products, ProductState state, int page) {
  if (products.isEmpty) {
    state = state.copyWith(page: page, isLoading: false);
    return;
  }

  print('get post is ${products.length}');
  state = state.copyWith(page: page, isLoading: false, products: products);
}

void fetchMoreProducts(List<Product> products, ProductState state) {
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

void requestLoading(ProductState state) {
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
}



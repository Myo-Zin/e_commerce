import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/network.dart';
import '../model/Product_category.dart';
import '../service/category_service.dart';

class ProductCategoryNotifier
    extends StateNotifier<AsyncValue<List<ProductCategory>>> {
  final CategoryService _categoryService;

  ProductCategoryNotifier(this._categoryService) : super(const AsyncLoading()){
    getProductCategory();
  }

  void getProductCategory() async {
    state = const AsyncLoading();
    final result = await _categoryService.getProductCategory();

    result.fold((l) {
      if (mounted) {
        state = AsyncError(l.message, StackTrace.empty);
      }
    }, (r) {
      if (mounted) {
        state = AsyncData(r);
      }
    });
  }
}

final productCategoryServiceProvider =
    Provider((ref) => CategoryService(ref.read(dioProvider)));

final productCategoryController = StateNotifierProvider.autoDispose<
    ProductCategoryNotifier, AsyncValue<List<ProductCategory>>>(
  (ref) => ProductCategoryNotifier(
    ref.watch(productCategoryServiceProvider),
  ),
);

import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';
import '../repository/repository.dart';

final productBannerController = FutureProvider<List<Product>>((ref) async {
  final result = ref.read(repositoryProvider).getProductBanner();
  return result;
});

final allProductListController = FutureProvider<List<Product>>((ref) async {
  final result = ref.read(repositoryProvider).getAllProduct(1);
  return result;
});







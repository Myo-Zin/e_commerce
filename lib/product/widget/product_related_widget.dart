import 'package:e_commerce/product/widget/product_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

import '../../data/api_const.dart';
import '../../widget/loading.dart';

class ProductRelatedWidget extends ConsumerWidget {
  const ProductRelatedWidget(this.relatedIds, {Key? key}) : super(key: key);
  final List<int>? relatedIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<String> stringIds = relatedIds!.map((e) => e.toString()).toList();
    // stringIds.first = "";
    // stringIds.last = "";
    // String stringId = relatedIds.toString();
    final relatedProducts = ref.watch(getRelatedIdController(relatedIds));

    return relatedProducts.when(
        data: (data) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                //crossAxisCount: 2,
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.7,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductGridWidget(data[index]);
              });
        },
        error: (error, stack) {
          return const Text("Error");
        },
        loading: () => loading());
  }
}

final getRelatedIdController = FutureProvider.family<List<WooProduct>, List<int>?>(
    (ref, ids) => ApiHelper.wooCommerce.getProducts(include: ids));

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

import '../../model/product.dart';
import '../../util/asset_string.dart';
import '../../util/route.dart';
import '../page/product_detail_page.dart';

class ProductGridWidget extends ConsumerWidget {
  const ProductGridWidget(this.product, {Key? key}) : super(key: key);
  final WooProduct product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        goto(context, page: Scaffold(body: ProductDetailPage(product.id!)));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: '${product.images?.first.src}',
                placeholder: (context, url) => Image.asset(AssetString.logo),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${product.price}MMK",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14.0),
                  ),
                ],
              ),
            )
            //${product.images!.first.src}
          ],
        ),
      ),
    );
    // productsAsyncValue.when(
    //   loading: () => Center(child: loading()),
    //   data: (products) {
    //        return ;},
    //
    //   error: (error, stack) {
    //     return Text("$error");
    //   });
  }
}
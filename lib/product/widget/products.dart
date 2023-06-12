import 'package:e_commerce/product/widget/product_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
    required this.products,
    required this.isLoadMoreError,
    required this.isLoadMoreDone,
  });

  final List<WooProduct>? products;
  final bool isLoadMoreError;
  final bool isLoadMoreDone;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // controller: _controller,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.7,
        ),
        itemCount: products!.length + 1,
        itemBuilder: (ctx, index) {
          if (index == products?.length) {
            // load more and get error
            if (isLoadMoreError) {
              return const Center(
                child: Text('Error'),
              );
            }
            // load more but reached to the last element
            if (isLoadMoreDone) {
              return const Center(
                child: Text(
                  'Done!',
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
              );
            }
            return const LinearProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.grey,
            );
          }
          return ProductGridWidget(products![index]);
        });
  }
}
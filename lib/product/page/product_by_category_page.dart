import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widget/loading.dart';
import '../controller/product_pagination_controller.dart';
import '../model/product_param.dart';
import '../widget/products.dart';

class ProductByCategoryPage extends ConsumerStatefulWidget {
  const ProductByCategoryPage(this.categoryId,this.categoryName, {Key? key}) : super(key: key);
  final String categoryId;
  final String categoryName;

  @override
  ConsumerState<ProductByCategoryPage> createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends ConsumerState<ProductByCategoryPage> {
  final ScrollController scrollController = ScrollController();

  int oldLength = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 20;
      if (currentScroll > maxScroll - delta) {
        if (oldLength ==
            ref
                .read(productsProvider(
                ProductParameter(category: widget.categoryId)))
                .products!
                .length) {
          // make sure ListView has newest data after previous loadMore
          ref
              .read(
              productsProvider(ProductParameter(category: widget.categoryId))
                  .notifier)
              .loadMoreProduct();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
        ),
        body: Consumer(builder: (ctx, watch, child) {
          final isLoadMoreError = ref
              .watch(productsProvider(
              ProductParameter(category: widget.categoryId)))
              .isLoadMoreError;
          final isLoadMoreDone = ref
              .watch(productsProvider(
              ProductParameter(category: widget.categoryId)))
              .isLoadMoreDone;
          final isLoading = ref
              .watch(productsProvider(
              ProductParameter(category: widget.categoryId)))
              .isLoading;
          final products = ref
              .watch(productsProvider(
              ProductParameter(category: widget.categoryId)))
              .products;
          oldLength = products?.length ?? 0;
          // init data or error
          if (products == null) {
            // error case
            if (isLoading == false) {
              return const Center(
                child: Text('Not found'),
              );
            }
            return loading();
          }
          return SingleChildScrollView(
            controller: scrollController,
            child: ProductsWidget(
                products: products,
                isLoadMoreError: isLoadMoreError,
                isLoadMoreDone: isLoadMoreDone),
          );
        }));
  }
}
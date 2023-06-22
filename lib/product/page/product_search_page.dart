import 'package:e_commerce/product/model/product_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/app_color.dart';
import '../../widget/loading.dart';
import '../controller/product_pagination_controller.dart';
import '../widget/products.dart';

class ProductSearchPage extends ConsumerStatefulWidget {
  const ProductSearchPage(this.search, {Key? key}) : super(key: key);
  final String search;

  @override
  ConsumerState<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends ConsumerState<ProductSearchPage> {
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
                    ProductParameter(searchParam: widget.search)))
                .products!
                .length) {
          // make sure ListView has newest data after previous loadMore
          ref
              .read(
                  productsProvider(ProductParameter(searchParam: widget.search))
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
          title: Text(widget.search,
              style: TextStyle(color: AppColor.primaryColor)),
        ),
        body: Consumer(builder: (ctx, watch, child) {
          final isLoadMoreError = ref
              .watch(productsProvider(
                  ProductParameter(searchParam: widget.search)))
              .isLoadMoreError;
          final isLoadMoreDone = ref
              .watch(productsProvider(
                  ProductParameter(searchParam: widget.search)))
              .isLoadMoreDone;
          final isLoading = ref
              .watch(productsProvider(
                  ProductParameter(searchParam: widget.search)))
              .isLoading;
          final products = ref
              .watch(productsProvider(
                  ProductParameter(searchParam: widget.search)))
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

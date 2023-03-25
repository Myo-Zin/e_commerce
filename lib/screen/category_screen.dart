import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/category_controller.dart';
import '../controller/product_controller.dart';
import '../model/category.dart';
import '../model/product.dart';
import '../widget/loading.dart';
import 'home_screen.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryController = ref.watch(allCategoriesListController);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: categoryController.when(
          data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryDetailScreen(category)));
                    },
                    child: Card(
                        child: SizedBox(
                            height: 50.0,
                            child: Center(child: Text("${category.name}")))),
                  );
                });
          },
          error: (error, stack) {
            return Text("Error");
          },
          loading: () => loading()),
    );
  }
}

class CategoryDetailScreen extends ConsumerWidget {
  CategoryDetailScreen(this.category, {Key? key}) : super(key: key);
  final Category category;
  final ScrollController scrollController = ScrollController();
  int oldLength = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 20;
      if (currentScroll > maxScroll - delta) {
        if (oldLength ==
            ref
                .read(productsByCategoryIdProvider(category.id!))
                .products!
                .length) {
          // make sure ListView has newest data after previous loadMore
          ref
              .read(productsByCategoryIdProvider(category.id!).notifier)
              .loadMoreProduct();
        }
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(category.name!),
        ),
        body: Consumer(builder: (ctx, watch, child) {
          final isLoadMoreError = ref
              .watch(productsByCategoryIdProvider(category.id!))
              .isLoadMoreError;
          final isLoadMoreDone = ref
              .watch(productsByCategoryIdProvider(category.id!))
              .isLoadMoreDone;
          final isLoading =
              ref.watch(productsByCategoryIdProvider(category.id!)).isLoading;
          final products =
              ref.watch(productsByCategoryIdProvider(category.id!)).products;

          // sync oldLength with post.length to make sure ListView has newest
          // data, so loadMore will work correctly
          oldLength = products?.length ?? 0;
          // init data or error
          if (products == null) {
            // error case
            if (isLoading == false) {
              return const Center(
                child: Text('error'),
              );
            }
            return loading();
          }
          return ProductGridViewWidget(scrollController: scrollController, products: products, isLoadMoreError: isLoadMoreError, isLoadMoreDone: isLoadMoreDone);
        }));
  }
}

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget({
    Key? key,
    required this.scrollController,
    required this.products,
    required this.isLoadMoreError,
    required this.isLoadMoreDone,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<Product> products;
  final bool isLoadMoreError;
  final bool isLoadMoreDone;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.7,
        ),
        controller: scrollController,
        itemCount: products.length == 1? products.length : products.length +1,
        itemBuilder: (context, index) {
          if (index == products.length) {
            // load more and get error
            print("index $index");
            print("length ${products.length}");
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
            return loading();
          }
          return ProductListWidget(products[index]);
        });
  }
}

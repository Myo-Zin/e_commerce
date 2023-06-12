import 'package:e_commerce/category/widget/category_widget.dart';
import 'package:e_commerce/product/controller/product_pagination_controller.dart';
import 'package:e_commerce/product/page/product_search_page.dart';
import 'package:e_commerce/product/widget/product_banner_widget.dart';
import 'package:e_commerce/util/route.dart';
import 'package:e_commerce/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

import '../../product/widget/product_grid_widget.dart';
import '../../product/widget/products.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final searchEditingController = TextEditingController();

  final ScrollController _controller = ScrollController();
  int oldLength = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() async {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent -
              MediaQuery.of(context).size.height) {
        if (oldLength == ref.read(productsProvider(null)).products!.length) {
          ref.read(productsProvider(null).notifier).loadMoreProduct();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            //height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: searchEditingController,
              // enabled: false,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.clear),
                  //   onPressed: () {
                  //     /* Clear the search field */
                  //   },
                  // ),
                  //hintStyle: TextStyle(fontSize: 11),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
          actions: [
            InkWell(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (searchEditingController.text.isEmpty) {
                    // Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Enter text')));
                  } else {
                    //searchEditingController.value.cl;
                    goto(context, page: ProductSearchPage(searchEditingController.text));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchDetailScreen(
                    //             searchEditingController.text)));
                  }
                },
                child: const Center(
                    child: Text(
                  "Search",
                ))),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final isLoadMoreError = ref.watch(productsProvider(null)).isLoadMoreError;
            final isLoadMoreDone = ref.watch(productsProvider(null)).isLoadMoreDone;
            final isLoading = ref.watch(productsProvider(null)).isLoading;
            final products = ref.watch(productsProvider(null)).products;

            oldLength = products?.length ?? 0;
            if (products == null) {
              if (isLoading == false) {
                return const Center(
                  child: Text('error'),
                );
              }
              return loading();
            }
            return RefreshIndicator(
              onRefresh: () {
                return ref.read(productsProvider(null).notifier).refresh();
              },
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: [
                    const BannerWidget(),
                    const CategoryWidget(),
                    ProductsWidget(
                        products: products,
                        isLoadMoreError: isLoadMoreError,
                        isLoadMoreDone: isLoadMoreDone),
                  ],
                ),
              ),
            );
          },
        ));
  }
}





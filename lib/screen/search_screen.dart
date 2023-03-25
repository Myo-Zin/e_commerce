import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/product_controller.dart';
import '../widget/loading.dart';
import 'category_screen.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();
  int oldLength = 0;

  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child:  Center(
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
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                if(searchEditingController.text.isEmpty){
                 // Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(backgroundColor: Colors.red,content: Text('Enter text')));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchDetailScreen(searchEditingController.text)));
                }
              },
              child: const Center(
                  child: Text(
                "Search",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}

class SearchDetailScreen extends ConsumerWidget {
  SearchDetailScreen(this.search, {Key? key}) : super(key: key);
  final String search;
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
                .read(productsBySearchProvider(search))
                .products!
                .length) {
          // make sure ListView has newest data after previous loadMore
          ref
              .read(productsBySearchProvider(search).notifier)
              .loadMoreProduct();
        }
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(search),
        ),
        body: Consumer(builder: (ctx, watch, child) {
          final isLoadMoreError = ref
              .watch(productsBySearchProvider(search))
              .isLoadMoreError;
          final isLoadMoreDone = ref
              .watch(productsBySearchProvider(search))
              .isLoadMoreDone;
          final isLoading =
              ref.watch(productsBySearchProvider(search)).isLoading;
          final products =
              ref.watch(productsBySearchProvider(search)).products;

          // sync oldLength with post.length to make sure ListView has newest
          // data, so loadMore will work correctly
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
          return ProductGridViewWidget(scrollController: scrollController, products: products, isLoadMoreError: isLoadMoreError, isLoadMoreDone: isLoadMoreDone);
        }));
  }
}

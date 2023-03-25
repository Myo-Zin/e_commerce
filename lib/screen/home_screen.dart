import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/screen/product_detail_screen.dart';
import 'package:e_commerce/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/category_controller.dart';
import '../controller/controller.dart';
import '../controller/network_dectector_notifier.dart';
import '../controller/product_controller.dart';
import '../model/category.dart';
import '../model/product.dart';
import '../widget/loading.dart';
import '../widget/loading_dialog.dart';
import 'category_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();
  int oldLength = 0;
  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final network = ref.watch(networkAwareProvider);

    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height;
      if (currentScroll > maxScroll - delta) {
        if (oldLength == ref.read(productsProvider).products!.length) {
          // make sure ListView has newest data after previous loadMore
          ref.read(productsProvider.notifier).loadMoreProduct();
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
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
                FocusManager.instance.primaryFocus?.unfocus();
                if (searchEditingController.text.isEmpty) {
                  // Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Enter text')));
                } else {
                  searchEditingController.value == "";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchDetailScreen(
                              searchEditingController.text)));
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(
          builder: (ctx, watch, child) {
            final isLoadMoreError = ref.watch(productsProvider).isLoadMoreError;
            final isLoadMoreDone = ref.watch(productsProvider).isLoadMoreDone;
            final isLoading = ref.watch(productsProvider).isLoading;
            final products = ref.watch(productsProvider).products;
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
              return Center(child: loading());
            }
            return RefreshIndicator(
              onRefresh: () {
                return ref.read(productsProvider.notifier).refresh();
              },
              child: CustomScrollView(
                  controller: scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  //shrinkWrap: true,
                  slivers: <Widget>[
                    const SliverToBoxAdapter(
                      child: BannerWidget(),
                    ),
                    const SliverToBoxAdapter(
                      child: CategoryWidget(),
                    ),
                    SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300.0,
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: 0.7,
                        ),
                        delegate: SliverChildBuilderDelegate(
                            childCount: products.length + 1, (ctx, index) {
                          print("index $index");
                          print("length ${products.length}");
                          if (index == products.length) {
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
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20),
                                ),
                              );
                            }
                            return loading();
                          }
                          // last element (progress bar, error or 'Done!' if reached to the last element)
                          return ProductListWidget(products[index]);
                        }))
                  ]),
            );
            // return
          },
        ),
      ),
      floatingActionButton:  CustomFab(scrollController)
    );
  }
}

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final productResponse = ref.watch(productBannerController);
    return productResponse.when(
        data: (products) {
          final imageList = [];
          // for(Product product in products){
          //   imageList.add(productList[i].productPhoto[0])
          // }
          for (var i = 0; i < products.length; i++) {
            imageList.add(products[i].images!.first.src);
          }
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(products[_current])));
            },
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: imageList
                      .map(
                        (item) => Container(
                            margin: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                child: CachedNetworkImage(
                                    imageUrl: item,
                                    placeholder: (context, url) => loading(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: 1000.0))),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.map((url) {
                    int index = imageList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? const Color.fromRGBO(0, 0, 0, 0.9)
                            : const Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          );
        },
        error: (error, stack) {
          print("$error");
          return const Text("error");
        },
        loading: () => loading());
  }
}

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<List<Category>>(slugIdStateProvider, (previous, next) async {
      print("click category ${next.first}");
      if (next == []) {
        return;
      }

      ///close loading
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryDetailScreen(next.first)));
    });
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                  child: _buildEachCategory("Bdsm",
                      () => gotoCategoryDetail(context, ref, "sex-accessory"))),
              Expanded(
                  child: _buildEachCategory("နောက်ပေါက်",
                      () => gotoCategoryDetail(context, ref, "anal"))),
              Expanded(
                  child: _buildEachCategory("ကွန်ဒုံ",
                      () => gotoCategoryDetail(context, ref, "condom"))),
              Expanded(
                  child: _buildEachCategory("ကျားတု",
                      () => gotoCategoryDetail(context, ref, "Dildo"))),
              Expanded(
                  child: _buildEachCategory("ချောဆီ",
                      () => gotoCategoryDetail(context, ref, "lubricant-gel"))),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                  child: _buildEachCategory(
                      "မတု",
                      () => gotoCategoryDetail(
                          context, ref, "masturbation-cup"))),
              Expanded(
                  child: _buildEachCategory("ဆေး",
                      () => gotoCategoryDetail(context, ref, "medicines"))),
              Expanded(
                  child: _buildEachCategory(
                      "ပြောင်း",
                      () => gotoCategoryDetail(
                          context, ref, "enlargement-pump "))),
              Expanded(
                  child: _buildEachCategory("တုန်ခါစက်",
                      () => gotoCategoryDetail(context, ref, "vibrator"))),
              Expanded(
                  child: _buildEachCategory("အားလုံး", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryScreen()));
              })),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  void gotoCategoryDetail(BuildContext context, WidgetRef ref, String slug) {
    FocusManager.instance.primaryFocus?.unfocus();
    loadingDialog(context);
    ref.read(slugIdController).getSlugId(slug);
  }

  Widget _buildEachCategory(String name, Function() onTap) {
    return InkWell(
        onTap: onTap,
        child: Center(
            child: Text(
          name,
          style: const TextStyle(
              fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),
        )));
  }
}

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget(this.product, {Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailPage(product)),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: '${product.images?.first.src}',
                placeholder: (context, url) => Image.asset('assets/logo.png'),
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

class CustomFab extends StatefulWidget {
  const CustomFab(this.controller, {Key? key}) : super(key: key);

  final ScrollController controller;

  @override
  State<CustomFab> createState() => _CustomFabState();
}
bool isVisible = true;
class _CustomFabState extends State<CustomFab> {
  @override
  void initState() {
    widget.controller.addListener(() {
      debugPrint("user scroller");
      if (widget.controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        debugPrint("scrolling reverse");
        if (isVisible != false) {
          setState(() {
            isVisible = false;
          });
        }
      } else {
        debugPrint("scrolling not reverse");
        if (isVisible != true) {
          setState(() {
            isVisible = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
          onTap: () async {
            final Uri launchUri = Uri.parse("https://m.me/MMonlineshoppingmed/");
            if (await canLaunchUrl(launchUri)) {
            await launchUrl(launchUri);
            } else {
            throw 'Could not launch $launchUri';
            }
          },
          child: Image.asset("assets/messenger.png")),
    );
  }
}

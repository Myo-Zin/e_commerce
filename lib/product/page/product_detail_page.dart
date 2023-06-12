import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/cart/controller/cart_controller.dart';
import 'package:e_commerce/cart/controller/cart_list_controller.dart';
import 'package:e_commerce/product/controller/product_detail_controller.dart';
import 'package:e_commerce/product/widget/product_related_widget.dart';
import 'package:e_commerce/util/async_value_ui.dart';
import 'package:e_commerce/util/extension.dart';
import 'package:e_commerce/widget/error_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:html/parser.dart';
import 'package:video_player/video_player.dart';

import '../../controller/quantity_controller.dart';
import '../../data/local/data_model.dart';
import '../../model/product.dart';
import '../../widget/loading.dart';
import '../widget/product_image_swipter_widget.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage(this.id, {Key? key}) : super(key: key);
  final int id;

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailController(widget.id));
    final cartState = ref.watch(cartController);
    ref.listen(
        cartController, (previous, next) => next.showSnackBarOnError(context));

    return state.when(
        data: (product) {
          /// for description
          var description =
              convertHtmlTagToString(product.shortDescription ?? "");

          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 400.0,
                    floating: true,
                    pinned: true,
                    stretch: true,
                    forceElevated: innerBoxIsScrolled,
                    // foregroundColor: Theme.of(context).colorScheme.primary,
                    title: Text(product.name ?? "",
                        style: TextStyle(
                          //color: Theme.of(context).colorScheme.primary,
                          fontSize: 16.0,
                        )),
                    flexibleSpace: FlexibleSpaceBar(
                        background: ImageSwipeWidget(product.images ?? [])),
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.price}MMK",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 17.0),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "${product.name}",
                      style: const TextStyle(fontSize: 17),
                    ),

                    const Divider(color: Colors.grey),
                    // const SizedBox(
                    //   height: 16.0,
                    // ),
                    // const Text(
                    //   "Phone",
                    //   style:
                    //       TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(
                    //   height: 8.0,
                    // ),
                    // InkWell(
                    //   onTap: () async {
                    //     final Uri launchUri = Uri.parse("tel:09799624930");
                    //     if (await canLaunchUrl(launchUri)) {
                    //       await launchUrl(launchUri);
                    //     } else {
                    //       throw 'Could not launch $launchUri';
                    //     }
                    //   },
                    //   child: const Text(
                    //     '09799624930',
                    //     style: TextStyle(
                    //       color: Colors.deepPurple,
                    //       fontSize: 17,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(
                      height: 16.0,
                    ),

                    const Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.black),
                    ),
                    // SamplePlayer("https://mmonlineshopping.co/wp-content/uploads/2022/08/Dildo-008720P_HD.mp4"),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (product.relatedIds != null)
                      const Text(
                        "Related Products",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (product.relatedIds != null)
                      ProductRelatedWidget(product.relatedIds)
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Row(
              children: [
                // const Expanded(child: Text("")),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // background
                      primary: Colors.orangeAccent,
                      // onPrimary: Colors.white, // foreground
                      //minimumSize: const Size(120, 40),
                      shape: const RoundedRectangleBorder(
                          //borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                    ),
                    onPressed: () {
                      List<LocalImage> imageList = [];
                      for (var element in product.images!) {
                        imageList.add(LocalImage(
                            id: element.id.toString(), src: element.src!));
                      }
                      // showModalBottomSheet<void>(
                      //     context: context,
                      //     builder: (_) {
                      //       return QuantityBottomSheetWidget(
                      //           product, description, imageList);
                      //     });
                    },
                    child: const Text("Buy Now"),
                  ),
                ),
                // const SizedBox(
                //   width: 8.0,
                // ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // background
                      // primary: Theme.of(context).colorScheme.secondary,
                      // onPrimary: Colors.white, // foreground
                      // minimumSize: const Size(120, 40),
                      shape: const RoundedRectangleBorder(
                          //borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                    ),
                    onPressed: cartState.isLoading
                        ? () {}
                        : () async {
                            final isSuccess = await ref
                                .read(cartController.notifier)
                                .addToCart(itemId: product.id!, quantity: 1);
                            if (isSuccess && mounted) {
                              ref.invalidate(cartListController);
                              context.showSuccessSnackBar("Successfully Added");
                            }
                          },
                    child: cartState.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Add to Cart"),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, _) => AppErrorWidget(
            error: error,
            onRetry: () => ref.invalidate(productDetailController)),
        loading: () => Scaffold(body: loading()));
  }

  String convertHtmlTagToString(String tag) {
    var document = parse(tag);
    var result = parse(document.body?.text).documentElement?.text;
    return result.toString();
  }
}

class QuantityBottomSheetWidget extends ConsumerWidget {
  const QuantityBottomSheetWidget(
      this.product, this.description, this.imageList,
      {Key? key})
      : super(key: key);
  final Product product;
  final List<WooProductImage> imageList;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityController);
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 150.0,
                      width: 150.0,
                      child: CachedNetworkImage(
                          imageUrl: product.images!.first.src.toString(),
                          placeholder: (context, url) => loading(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: 1000.0)),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name.toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${product.price}MMK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // ref.read(quantityController.notifier).dispose();
                    },
                    child: const Icon(Icons.close_sharp)),
              )
            ]),
            const SizedBox(
              width: 16.0,
            ),
            const Divider(color: Colors.grey),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Quantity',
                    style: TextStyle(fontSize: 20.0),
                  )),
                  InkWell(
                      onTap: () {
                        ref.read(quantityController.notifier).decrement();
                      },
                      child: const Icon(
                        Icons.remove_circle_outline,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text("$quantity"),
                  const SizedBox(
                    width: 16.0,
                  ),
                  InkWell(
                      onTap: () {
                        ref.read(quantityController.notifier).increment();
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 30,
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // background
                    primary: Colors.orangeAccent,
                    onPrimary: Colors.white, // foreground
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    print("click home");
                    // List<LocalImage> imageList = [];
                    // final selectedCart = [
                    //   DataModel(
                    //       id: product.id.toString(),
                    //       name: product.name ?? "",
                    //       price: product.price ?? "",
                    //       description: description,
                    //       quantity: quantity.toString(),
                    //       images: imageList,
                    //       isCheck: false,
                    //       subtotal: quantity * int.parse(product.price!))
                    // ];
                    // final grandTotal =
                    //     int.parse(product.price.toString()) * quantity;
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CheckOutScreen(
                    //             grandTotal.toString(), selectedCart)));
                  },
                  child: const Text("Buy Now")),
            ),
            const SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}

class SamplePlayer extends StatefulWidget {
  const SamplePlayer(this.url, {Key? key}) : super(key: key);
  final String url;

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    //String url = widget.url.toString();
    String url = widget.url;
    String t1 = '"';
    String t2 = '?raw=true"';
    String result = t1 + url + t2;

    print(result);

    try {
      print("$url");
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
            formatHint: VideoFormat.other, "$url"),
      );
    } catch (e) {
      print("$e");
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: const FlickVideoWithControls(
            closedCaptionTextStyle: TextStyle(fontSize: 8),
            controls: FlickPortraitControls(),
          ),
          flickVideoWithControlsFullscreen: const FlickVideoWithControls(
            controls: FlickLandscapeControls(),
          ),
        ),
      ],
    );
  }
}

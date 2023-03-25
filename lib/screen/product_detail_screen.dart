import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/cart_controller_provider.dart';
import '../controller/product_controller.dart';
import '../controller/quantity_controller.dart';
import '../data/local/data_model.dart';
import '../model/product.dart';
import '../widget/loading.dart';
import 'checkout_screen.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

import 'home_screen.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage(this.product, {Key? key}) : super(key: key);
  final Product product;

  String convertHtmlTagToString(String tag) {
    var document = parse(tag);
    var result = parse(document.body?.text).documentElement?.text;
    return result.toString();
  }

  String getVideoUrl(String str) {
    print(str);
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String d = product.description ?? "";
    String s = d.replaceAll(exp, '');
    String url = "";
    if (s.contains(";")) {
      var r = s.split(";");
      url = (r[1]).trim();
    } else {
      url = s.trim();
    }

    print(d[1]);
    print("product.description > ${product.description} ");
    print("url > $url ");

    return url;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartList = ref.watch(cartControllerProvider);

    /// for video Url
    final videoUrl = product.description ?? "";
    bool isHasVideo = videoUrl.isNotEmpty ? true : false;

    /// for description
    var description = convertHtmlTagToString(product.shortDescription ?? "");

    /// Check cart is add or not
    bool isAddedCart = false;
    List<DataModel> carts = cartList;
    for (var element in carts) {
      if (element.id.toString() == product.id.toString()) {
        isAddedCart = true;
        break;
      }
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 476.0,
              floating: true,
              pinned: true,
              stretch: true,
              forceElevated: innerBoxIsScrolled,
              foregroundColor: Theme.of(context).colorScheme.primary,
              title: Text("",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16.0,
                  )),
              flexibleSpace: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xfff4f6f8),
                      Color(0xfff6f9fa),
                      Color(0xfff7fbfd),
                    ],
                  ),
                ),
                child: FlexibleSpaceBar(
                    background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 500.0,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     fit: BoxFit.fill,
                      //     image: NetworkImage('${product.images?.first.src}'),
                      //   ),
                      // ),
                      child: ImageSwipeWidget(product.images ?? []),
                    ),
                  ],
                )),
              ),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: CircleAvatar(
              //       radius: 28.0,
              //       backgroundImage: NetworkImage(
              //           'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
              //     ),
              //   )
              // ],
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(
                height: 16.0,
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "Phone",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8.0,
              ),
              InkWell(
                onTap: () async {
                  final Uri launchUri = Uri.parse("tel:09799624930");
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  } else {
                    throw 'Could not launch $launchUri';
                  }
                },
                child: const Text(
                  '09799624930',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),

              const Text(
                "Description",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              if (isHasVideo) SamplePlayer(getVideoUrl(videoUrl)),
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
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              const SizedBox(
                height: 16.0,
              ),
              if (product.relatedIds != null)
                RelatedProductsWidget(product.relatedIds)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        height: 70.0,
        child: Row(
          children: [
            const Expanded(child: Text("")),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // background
                  primary: Colors.orangeAccent,
                  // onPrimary: Colors.white, // foreground
                  minimumSize: const Size(120, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                onPressed: () {
                  List<LocalImage> imageList = [];
                  for (var element in product.images!) {
                    imageList.add(LocalImage(
                        id: element.id.toString(), src: element.src!));
                  }
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (_) {
                        return QuantityBottomSheetWidget(
                            product, description, imageList);
                      });
                },
                child: const Text("Buy Now"),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // background
                // primary: Theme.of(context).colorScheme.secondary,
                // onPrimary: Colors.white, // foreground
                minimumSize: const Size(120, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () async {
                List<LocalImage> imageList = [];
                for (var element in product.images!) {
                  imageList.add(
                      LocalImage(id: element.id.toString(), src: element.src!));
                }
                DataModel dataModel = DataModel(
                    id: product.id.toString(),
                    name: product.name ?? "",
                    price: product.price ?? "",
                    description: description ?? "",
                    quantity: "1",
                    images: imageList,
                    isCheck: false,
                    subtotal: 1 * int.parse(product.price!));

                // if(product.id.toString() != cartBox.getCart(dataModel)?.id){
                //
                // }
                print("is added Cart ${isAddedCart}");
                if (!isAddedCart) {
                  //ref.refresh(cartController);
                  ref.read(cartControllerProvider.notifier).addCart(dataModel);
                  //cartBox.refreshCart();
                }
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Successfully added')));
              },
              child: const Text("Add to Cart"),
            ),
            const SizedBox(
              width: 16.0,
            )
          ],
        ),
      ),
    );
  }
}

class QuantityBottomSheetWidget extends ConsumerWidget {
  const QuantityBottomSheetWidget(
      this.product, this.description, this.imageList,
      {Key? key})
      : super(key: key);
  final Product product;
  final List<LocalImage> imageList;
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
                    final selectedCart = [
                      DataModel(
                          id: product.id.toString(),
                          name: product.name ?? "",
                          price: product.price ?? "",
                          description: description,
                          quantity: quantity.toString(),
                          images: imageList,
                          isCheck: false,
                          subtotal: quantity * int.parse(product.price!))
                    ];
                    final grandTotal =
                        int.parse(product.price.toString()) * quantity;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutScreen(
                                grandTotal.toString(), selectedCart)));
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

class ImageSwipeWidget extends StatefulWidget {
  const ImageSwipeWidget(this.imageList, {Key? key}) : super(key: key);
  final List<Images> imageList;

  @override
  State<ImageSwipeWidget> createState() => _ImageSwipeWidgetState();
}

class _ImageSwipeWidgetState extends State<ImageSwipeWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.expand,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            // autoPlay: true,
            aspectRatio: 1,
            enlargeCenterPage: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.imageList
              .map(
                (item) => Container(
                    margin: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: CachedNetworkImage(
                            imageUrl: item.src ?? "",
                            placeholder: (context, url) => loading(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fill,
                            width: 1000.0))),
              )
              .toList(),
        ),
        Positioned(
          bottom: 0.0,
          right: 5.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black45,
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromARGB(200, 0, 0, 0),
              //     Color.fromARGB(0, 0, 0, 0)
              //   ],
              //   begin: Alignment.bottomCenter,
              //   end: Alignment.topCenter,
              // ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              '${_current + 1}/${widget.imageList.length}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: imageList.map((url) {
        //     int index = imageList.indexOf(url);
        //     return Container(
        //       width: 8.0,
        //       height: 8.0,
        //       margin: const EdgeInsets.symmetric(
        //           vertical: 10.0, horizontal: 2.0),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: _current == index
        //             ? const Color.fromRGBO(0, 0, 0, 0.9)
        //             : const Color.fromRGBO(0, 0, 0, 0.4),
        //       ),
        //     );
        //   }).toList(),
        // )
      ],
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

class RelatedProductsWidget extends ConsumerWidget {
  const RelatedProductsWidget(this.relatedIds, {Key? key}) : super(key: key);
  final List<int>? relatedIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("related ids $relatedIds");
    List<String> stringIds = relatedIds!.map((e) => e.toString()).toList();
    stringIds.first = "";
    stringIds.last = "";
    print(stringIds);
    String stringId = relatedIds.toString();
    print(stringId);
    final relatedProducts = ref.watch(getRelatedIdController(stringId));

    // var result = stringIds.split(RegExp(r'*'));
    // print("split $result");
    return relatedProducts.when(
        data: (data) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductListWidget(data[index]);
              });
        },
        error: (error, stack) {
          return const Text("Error");
        },
        loading: () => loading());
  }
}

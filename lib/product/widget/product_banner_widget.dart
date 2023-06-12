import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widget/loading.dart';
import '../controller/product_banner_controller.dart';
import '../page/product_detail_page.dart';

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
                          ProductDetailPage(products[_current].id!)));
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
                        (item) => Card(
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: CachedNetworkImage(
                                  imageUrl: item,
                                  placeholder: (context, url) => loading(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                  width: 1000.0)),
                        ),
                      )
                      .toList(),
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

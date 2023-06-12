
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/product/widget/product_photo_detail_widget.dart';
import 'package:e_commerce/util/list_extension.dart';
import 'package:e_commerce/util/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';

import '../../widget/loading.dart';

class ImageSwipeWidget extends StatefulWidget {
  const ImageSwipeWidget(this.imageList, {Key? key}) : super(key: key);
  final List<WooProductImage> imageList;

  @override
  State<ImageSwipeWidget> createState() => _ImageSwipeWidgetState();
}

class _ImageSwipeWidgetState extends State<ImageSwipeWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      // fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: (){
            goto(context, page: PhotoDetailWidget(widget.imageList,PageController(initialPage: _current),_current));
          },
          child: CarouselSlider(
            options: CarouselOptions(
              // autoPlay: true,
              aspectRatio: 0.9,
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
                  (item) => ClipRRect(
                // borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  imageUrl: item.src ?? "",
                  placeholder: (context, url) => loading(),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                  fit: BoxFit.fill,
                  //width: 1000.0,
                ),
              ),
            )
                .toList(),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black45,
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
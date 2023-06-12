import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoDetailWidget extends ConsumerStatefulWidget {
  const PhotoDetailWidget(
      this.galleryItems, this.pageController, this.currentIndex,
      {Key? key})
      : super(key: key);
  final List<WooProductImage> galleryItems;
  final PageController pageController;
  final int currentIndex;

  @override
  ConsumerState<PhotoDetailWidget> createState() => _PhotoDetailWidgetState();
}

class _PhotoDetailWidgetState extends ConsumerState<PhotoDetailWidget> {
  int currentImage = 0;

  @override
  void initState() {
    currentImage = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.galleryItems.swap(0,widget.currentIndex);

    //final currentImage = ref.watch(currentPageProvider(widget.currentIndex));
    return Scaffold(
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.galleryItems[index].src ?? ''),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(
                tag: widget.galleryItems[index].id ?? ""),
          );
        },
        itemCount: widget.galleryItems.length,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        // backgroundDecoration: widget.backgroundDecoration,
        pageController: widget.pageController,
        onPageChanged: (index) {
          setState(() {
            currentImage = index;
          });
          //ref.read(currentPageProvider(widget.currentIndex).notifier).state = index;
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.galleryItems.map((url) {
          int index = widget.galleryItems.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentImage == index
                  ? const Color.fromRGBO(0, 0, 0, 0.9)
                  : const Color.fromRGBO(0, 0, 0, 0.1),
            ),
          );
        }).toList(),
      ),
    );
  }
}

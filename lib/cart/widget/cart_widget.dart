import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/page/product_detail_page.dart';
import '../../util/route.dart';
import '../../widget/loading.dart';
import '../controller/cart_list_controller.dart';
import '../model/cart_item.dart';

class ShoppingCartWidget extends ConsumerWidget {
  const ShoppingCartWidget( this.cart, {Key? key}) : super(key: key);
  final CartItem cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print("cart check value ${cart.isCheck}");
    return InkWell(
      onTap: () {
        //print("cart description ${cart.name}");
        goto(context, page: Scaffold(body: ProductDetailPage(cart.id!)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1,
                child: Checkbox(
                  shape: const CircleBorder(),
                  activeColor: Colors.red,
                  value: cart.isSelected,
                  onChanged: (bool? value) {
                    ref.read(cartListController.notifier).select(cart.id!);
                  },
                ),
              ),
              SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: CachedNetworkImage(
                    imageUrl: cart.images!.first.src!,
                    placeholder: (context, url) => loading(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cart.name ?? ""),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            "${cart.prices!.price ?? ""}MMK",
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              // _showQuantityDialog(
                              //     context, index, cart, ref);
                            },
                            child: Row(
                              children: [
                                Text("${cart.quantity ?? ""}"),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                const Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showQuantityDialog(
  //     BuildContext context, int index, DataModel cart, WidgetRef ref) {
  //   String quantity = cart.quantity;
  //   showModalBottomSheet(
  //     context: context,
  //     // color is applied to main screen when modal bottom screen is displayed
  //     // barrierColor: Colors.greenAccent,
  //     //background color for modal bottom screen
  //     //backgroundColor: Colors.yellow,
  //     //elevates modal bottom screen
  //     elevation: 10,
  //     // gives rounded corner to modal bottom screen
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     builder: (BuildContext context) {
  //       // UDE : SizedBox instead of Container for whitespaces
  //       return SizedBox(
  //         height: 700,
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   const Expanded(
  //                     child: Text(""),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.topRight,
  //                     child: InkWell(
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Icon(Icons.close_sharp)),
  //                   )
  //                 ],
  //               ),
  //               // const SizedBox(
  //               //   height: 16.0,
  //               // ),
  //               const Text(
  //                 "Quantity Options",
  //                 style: TextStyle(fontSize: 24.0),
  //               ),
  //               Expanded(
  //                 child: WheelChooser.integer(
  //                     onValueChanged: (i) {
  //                       quantity = i.toString();
  //                     },
  //                     maxValue: 100,
  //                     minValue: 1,
  //                     initValue: int.parse(quantity),
  //                     step: 1,
  //                     unSelectTextStyle: const TextStyle(color: Colors.grey)),
  //               ),
  //               ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     // background
  //                     primary: Theme.of(context).colorScheme.secondary,
  //                     onPrimary: Colors.white, // foreground
  //                     minimumSize: const Size.fromHeight(50),
  //                     shape: const RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     DataModel data = DataModel(
  //                         id: cart.id,
  //                         name: cart.name,
  //                         price: cart.price,
  //                         description: cart.description,
  //                         quantity: quantity,
  //                         images: cart.images,
  //                         isCheck: false,
  //                         subtotal:
  //                         int.parse(cart.quantity) * int.parse(cart.price));
  //                     // ref.refresh(cartControllerProvider.notifier).updateCart(
  //                     //     index, data);
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("Confirm")),
  //               const SizedBox(
  //                 height: 16.0,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
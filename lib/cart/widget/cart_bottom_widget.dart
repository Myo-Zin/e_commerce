import 'package:e_commerce/cart/controller/total_price_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartBottomWidget extends ConsumerWidget {
  const CartBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Total:",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  // "${cartList.n}",
                  "${ref.watch(totalPriceProvider)}MMK",
                  style: TextStyle(
                    fontSize: 17,
                   // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
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
             // minimumSize: const Size(120, 40),
              shape: const RoundedRectangleBorder(
               // borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: () async {
              // final selectedCart = getSelectedCart(cartList);
              // if (selectedCart.isEmpty) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Pleas select item')),
              //   );
              // } else {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               CheckOutScreen(
              //                   carttotal.toString(),
              //                   selectedCart)));
              // }
            },
            child: const Text("Check Out"),
          ),
          const SizedBox(
            width: 8.0,
          )
        ],
      ),
    );
  }
}
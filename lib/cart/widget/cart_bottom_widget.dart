import 'package:flutter/material.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // decoration: const BoxDecoration(
      //   border: Border(
      //     top: BorderSide(width: 0.5, color: Colors.grey),
      //   ),
      // ),
      height: 70.0,
      child: Row(
        children: [
          const Expanded(child: Text("")),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  // "${cartList.n}",
                  "${0}MMK",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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
              minimumSize: const Size(120, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
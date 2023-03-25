
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screen/product_detail_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../controller/cart_controller_provider.dart';
import '../controller/firebase_controller.dart';
import '../data/local/data_model.dart';
import '../model/product.dart';
import '../widget/loading.dart';
import 'checkout_screen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartList = ref.watch(cartControllerProvider);

    /// Get for Grand Total
     int total = 0;
     for (var element in cartList) {
       if (element.isCheck) {
         total += int.parse(element.subtotal.toString());
       }
     }
    final database = FirebaseDatabase.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("MyCart(${cartList.length})"),
        actions:  [
          TextButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Delete"),
                      content: const Text(
                        "Do you want to delete all item ?",
                      ),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: const Text("No"),
                          onPressed: () =>
                              Navigator.of(context).pop(),
                        ),
                        CupertinoDialogAction(
                          child: Text("Yes"),
                          onPressed: () async {
                            ref.read(cartControllerProvider.notifier).deleteAllCart();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });

            },
            child:  const Text("Delete All",style: TextStyle(color: Colors.white),),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: cartList.isEmpty
          ? const Center(
        child: Text("No Carts"),
      )
          : ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          DataModel cart = cartList[index];
          return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (_) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text("Delete"),
                              content: const Text(
                                "Do you want to delete this item ?",
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: const Text("No"),
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                ),
                                CupertinoDialogAction(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    print("$index");
                                    // cartBox.refreshCart();
                                    // cartBox.deleteCart(index);
                                    ref.read(cartControllerProvider.notifier).deleteCart(index);
                                    // cartBox.refreshCart();
                                    Navigator.of(context).pop();

                                  },
                                ),
                              ],
                            );
                          });
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ShoppingCartWidget(index, cart));
          // });
        },
      ),
      bottomNavigationBar: SizedBox(
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
                    "${total}MMK",
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
                final selectedCart = getSelectedCart(cartList);
                if (selectedCart.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pleas select item')),
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOutScreen(
                             total.toString(),
                              selectedCart)));
                }
              },
              child: const Text("Check Out"),
            ),
            const SizedBox(
              width: 8.0,
            )
          ],
        ),
      ),
    );
  }

  List<DataModel> getSelectedCart( List<DataModel> cartList) {
    List<DataModel> list = [];
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].isCheck) {
        list.add(cartList[i]);
      }
    }
    return list;
  }
}

class ShoppingCartWidget extends ConsumerWidget {
  const ShoppingCartWidget(this.index, this.cart, {Key? key})
      : super(key: key);
  final int index;
  final DataModel cart;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("cart check value ${cart.isCheck}");
    return InkWell(
      onTap: () {
        List<Images> imageList = [];
        for (var element in cart.images) {
          imageList.add(
              Images(id: int.parse(element.id), src: element.src));
        }
        print("cart description ${cart.description}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(Product(
              id: int.parse(cart.id),
              name: cart.name,
              price: cart.price,
              shortDescription: cart.description,
              images: imageList,
            )),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  shape: const CircleBorder(),
                  // splashRadius: 30,
                  activeColor: Colors.red,

                  // tristate: false,
                  value: cart.isCheck,
                  onChanged: (bool? value) {
                    print("defalut value ${cart.isCheck}");
                    print("checking value ${value}");
                    DataModel  data =  DataModel(
                        id: cart.id,
                        name: cart.name,
                        price: cart.price,
                        description: cart.description,
                        quantity: cart.quantity,
                        images: cart.images,
                        isCheck: value == false ? false : true,
                        subtotal:
                        int.parse(cart.quantity) * int.parse(cart.price));
                    ref.read(cartControllerProvider.notifier).updateCart(index, data);


                  },
                ),
              ),
              SizedBox(
                  height: 120.0,
                  width: 120.0,
                  child: CachedNetworkImage(
                      imageUrl: cart.images.first.src,
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
                    Text(cart.name),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            "${cart.price}MMK",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 17.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              _showQuantityDialog(
                                  context, index, cart, ref);
                            },
                            child: Row(
                              children: [
                                Text(cart.quantity),
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

  void _showQuantityDialog(
      BuildContext context, int index, DataModel cart, WidgetRef ref) {
    String quantity = cart.quantity;
    showModalBottomSheet(
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      // barrierColor: Colors.greenAccent,
      //background color for modal bottom screen
      //backgroundColor: Colors.yellow,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return SizedBox(
          height: 700,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(""),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close_sharp)),
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 16.0,
                // ),
                const Text(
                  "Quantity Options",
                  style: TextStyle(fontSize: 24.0),
                ),
                Expanded(
                  child: WheelChooser.integer(
                      onValueChanged: (i) {
                        quantity = i.toString();
                      },
                      maxValue: 100,
                      minValue: 1,
                      initValue: int.parse(quantity),
                      step: 1,
                      unSelectTextStyle: const TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // background
                      primary: Theme.of(context).colorScheme.secondary,
                      onPrimary: Colors.white, // foreground
                      minimumSize: const Size.fromHeight(50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      DataModel data =  DataModel(
                          id: cart.id,
                          name: cart.name,
                          price: cart.price,
                          description: cart.description,
                          quantity: quantity,
                          images: cart.images,
                          isCheck: false,
                          subtotal: int.parse(cart.quantity) *
                              int.parse(cart.price));
                      ref.refresh(cartControllerProvider.notifier).updateCart(index, data);
                      Navigator.pop(context);
                    },
                    child: const Text("Confirm")),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

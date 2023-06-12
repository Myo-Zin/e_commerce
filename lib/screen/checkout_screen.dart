import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/order_controller.dart';
import '../controller/shared_preference_controller.dart';
import '../data/local/data_model.dart';
import '../model/order.dart';
import '../model/user.dart';
import '../widget/loading.dart';
import '../widget/loading_dialog.dart';

class CheckOutScreen extends ConsumerWidget {
   CheckOutScreen(this.grandTotal, this.cartList, {Key? key})
      : super(key: key);
  final List<DataModel> cartList;
  final String grandTotal;

   final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<LineItems> lineItems = [];
    for (var element in cartList) {
      lineItems.add(LineItems(
          productId: int.parse(element.id),
          quantity: int.parse(element.quantity)));
    }
    ref.listen<Order?>(orderStateProvider, (previous, next) async {
      if (next == null) {
        return;
      }

      ///close loading
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Successfully Order"),
      ));
      /// colose page
     // Navigator.pop(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(

          children: [
             Card(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Add Note ',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (BuildContext context, int index) {
                  final cart = cartList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 120.0,
                                width: 120.0,
                                child: CachedNetworkImage(
                                    imageUrl: cart.images.first.src,
                                    placeholder: (context, url) => loading(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: 1000.0),
                              ),
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 17.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("Qty: ${cart.quantity}"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(color: Colors.grey),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(child: const Text("")),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Text("${cart.quantity}Item(s). Subtotal: "),
                                    Text(
                                      "${cart.subtotal}MMK ",
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
                    "${grandTotal}MMK",
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
                final authSate =
                await ref.watch(sharedPreferencesProvider).getAuthState();
                if(authSate != null){
                  if(authSate){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text("အော်ဒါတင်မည်"),
                            content: const Text(
                              "ရန်ကုန်မှလွှဲပြီး နယ်မြို့များဆိုရင် ငွေကို(၁)ရက်ကြိုလွှဲရပါတယ် ငွေလွှဲပြီးနောက်နေ့ကားဂိတ်ကနေတင်ပေးပါတယ်",
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text("ပယ်ဖျက်မည်"),
                                onPressed: () =>
                                    Navigator.of(context).pop(),
                              ),
                              CupertinoDialogAction(
                                child: const Text("အော်ဒါတင်မည်"),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  loadingDialog(context);
                                 // LoginUser loginUser =
                                  // await ref.watch(firebaseController).getUser();
                                  // Order order = Order(
                                  //     paymentMethod: "cod",
                                  //     paymentMethodTitle: "Cash on delivery",
                                  //     customerNote: _controller.text,
                                  //     setPaid: true,
                                  //     billing: Billing(
                                  //         firstName: loginUser.name,
                                  //         lastName: loginUser.name,
                                  //         company: loginUser.name,
                                  //         address1: loginUser.address,
                                  //         address2: loginUser.address,
                                  //         city: loginUser.city,
                                  //         state: loginUser.state,
                                  //         postcode: "11111",
                                  //         country: "Myanmar",
                                  //         email: "example@gmail.com",
                                  //         phone: loginUser.phone),
                                  //     shipping: Shipping(
                                  //         firstName: loginUser.name,
                                  //         lastName: loginUser.name,
                                  //         company: loginUser.name,
                                  //         address1: loginUser.address,
                                  //         address2: loginUser.address,
                                  //         city: loginUser.city,
                                  //         state: loginUser.state,
                                  //         postcode: "11111",
                                  //         country: "Myanmar",
                                  //         phone: loginUser.phone),
                                  //     lineItems: lineItems);
                                  // ref.read(orderViewController).order(order);
                                },
                              ),
                            ],
                          );
                        });
                  }
                }else{
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("Create Profile"),
                          content: const Text(
                            "Please create  profile first",
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text("Cancel"),
                              onPressed: () =>
                                  Navigator.of(context).pop(),
                            ),
                            CupertinoDialogAction(
                              child: const Text("Ok"),
                              onPressed: ()  {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen("create",null)));
                              },
                            ),
                          ],
                        );
                      });
                }


              },
              child: const Text("Place Order"),
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

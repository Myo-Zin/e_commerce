import 'package:e_commerce/cart/controller/cart_controller.dart';
import 'package:e_commerce/util/async_value_ui.dart';
import 'package:e_commerce/util/confirm_dialog.dart';
import 'package:e_commerce/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../widget/loading.dart';
import '../controller/cart_list_controller.dart';
import '../widget/cart_bottom_widget.dart';
import '../widget/cart_widget.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cartListController);
    ref.listen(
        cartController, (previous, next) => next.showSnackBarOnError(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          TextButton(
            onPressed: () {
              showConfirmDialog(
                  context, "Are you sure to delete all items?", () {});
            },
            child: const Text(
              "Delete All",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: state.when(
          loading: () => loading(),
          data: (data) {
            final list = data;
            return list.isEmpty
                ? const Center(child: Center(child: Text("No Cart")))
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final cart = list[index];
                      return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 2,
                                onPressed: (_) {
                                  showConfirmDialog(
                                      context,
                                      'Do you want to delete this item ?',
                                      () => null);
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ShoppingCartWidget( cart));
                      // });
                    },
                  );
          },
          error: (e, _) {
            return AppErrorWidget(
                error: e.toString(),
                onRetry: () => ref.refresh(cartListController));
          }),
      bottomNavigationBar: const CartBottomWidget(),
    );
  }
}





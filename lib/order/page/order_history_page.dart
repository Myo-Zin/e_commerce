import 'package:e_commerce/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controller/order_history_controller.dart';

class OrderHistoryPage extends ConsumerWidget {
  const OrderHistoryPage(this.customerId, {Key? key}) : super(key: key);
  final int customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderHistoryState = ref.watch(orderHistoryController(customerId));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: orderHistoryState.when(
          data: (data) {
            return data.isEmpty
                ? const Center(
                    child: Text("No Order history"),
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final orderHis = data[index];
                      var f = DateFormat('E, d MMM yyyy');

                      return Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text("#${orderHis.id}"),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Text(f.format(DateTime.parse(
                                      "${orderHis.dateCreatedGmt}")))),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: orderHis.status == "processing"
                                        ? Colors.blue
                                        : null,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${orderHis.status}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
          },
          error: (error, stack) => Text("$error"),
          loading: () => loading()),
    );
  }
}

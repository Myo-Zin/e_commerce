import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network.dart';
import '../model/customer.dart';
import '../service/customer_service.dart';

class CustomerNotifier extends StateNotifier<AsyncValue<Customer?>> {
  final CustomerService _customerService;

  CustomerNotifier(this._customerService) : super(const AsyncData(null));

  void createCustomer(
      {required String userName,
      required String email,
      required String password}) async {
    state = const AsyncLoading();
    final result = await _customerService.createCustomer(
        userName: userName, email: email, password: password);

    result.fold((l) {
      if (mounted) {
        state = AsyncError(l.message, StackTrace.empty);
      }
    }, (r) {
      if (mounted) {
        state = AsyncData(r);
      }
    });
  }
}

final customerServiceProvider =
    Provider((ref) => CustomerService(ref.read(dioProvider)));

final customerController =
    StateNotifierProvider.autoDispose<CustomerNotifier, AsyncValue<Customer>>(
  (ref) => CustomerNotifier(
    ref.watch(customerServiceProvider),
  ),
);

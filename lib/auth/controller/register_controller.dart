import 'package:e_commerce/auth/service/login_register_service.dart';
import 'package:e_commerce/auth/service/login_register_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network.dart';
import '../model/register_response.dart';
import '../../customer/service/customer_service.dart';

class RegisterNotifier extends StateNotifier<AsyncValue<RegisterResponse?>> {
  final LoginRegisterService _loginRegisterService;

  RegisterNotifier(this._loginRegisterService) : super(const AsyncData(null));

  void createCustomer(
      {required String userName,
      required String email,
      required String password}) async {
    state = const AsyncLoading();
    final result = await _loginRegisterService.register(
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


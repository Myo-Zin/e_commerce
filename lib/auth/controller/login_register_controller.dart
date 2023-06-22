import 'package:e_commerce/auth/controller/auth_controller.dart';
import 'package:e_commerce/data/api_const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

class LoginRegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  LoginRegisterNotifier(
    this.ref,
  ) : super(const AsyncData(null));

  Future<bool> login(
      {required String userName, required String password}) async {
    state = const AsyncLoading();
    try {
      await ApiHelper.wooCommerce
          .authenticateViaJWT(username: userName, password: password);
      state = const AsyncValue.data(null);
      ref.watch(authControllerProvider.notifier). changeAuthState();
      return true;
    } on WooCommerceError catch (e) {
      state = AsyncValue.error(e.message ?? "", StackTrace.empty);
      return false;
    }
  }

  Future<bool> register(
      {required String email,
      required String userName,
      required String password}) async {
    state = const AsyncLoading();
    try {
      await ApiHelper.wooCommerce.createCustomer(
          WooCustomer(username: userName, email: email, password: password));
      state = const AsyncValue.data(null);
      //ref.watch(authControllerProvider.notifier).changeAuthState();
      return true;
    } on Exception catch(error)  {
      print("error => $error}");
      state = AsyncValue.error(error ?? "Error", StackTrace.empty);
      return false;
    }
  }
}

final loginRegisterController =
    StateNotifierProvider.autoDispose<LoginRegisterNotifier, AsyncValue<void>>(
  (ref) => LoginRegisterNotifier(ref),
);

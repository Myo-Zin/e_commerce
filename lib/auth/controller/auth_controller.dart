import 'package:e_commerce/data/api_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wp_woocommerce/utilities/local_db.dart';
import '../model/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unAuthenticated());

  void getAuth() async {
    final isLogin = await ApiHelper.wooCommerce.isCustomerLoggedIn();
    //ApiHelper.wooCommerce.createOrder(orderPayload)
    if (isLogin) {
      state = const AuthState.authenticated();
    } else {
      state = const AuthState.unAuthenticated();
    }
  }

  Future<void> logout() async {
    state = const AuthState.unAuthenticated();
    await ApiHelper.wooCommerce.logUserOut();
  }

  void changeAuthState() {
    state = const AuthState.authenticated();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());

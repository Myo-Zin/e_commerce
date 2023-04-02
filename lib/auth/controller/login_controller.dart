import 'package:e_commerce/controller/shared_preference_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network.dart';
import '../model/auth_state.dart';
import '../service/login_register_service.dart';
import 'auth_controller.dart';

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final LoginRegisterService _loginRegisterService;
  final Ref ref;

  LoginNotifier(
    this._loginRegisterService,
    this.ref,
  ) : super(const AsyncData(null));

  Future<bool> createLogin(
      {required String userName, required String password}) async {
    state = const AsyncLoading();
    final result =
        await _loginRegisterService.login(userName: userName, password: password);

    return result.fold((l) {
      if (mounted) {
        state = AsyncError(l.message, StackTrace.empty);
      }
      ref
          .read(authControllerProvider.notifier)
          .changeAuth(const AuthState.unAuthenticated());
      return false;
    }, (r) {
      SharedPreferencesService.setAuth(r.token!);
      state = const AsyncData(null);
      ref
          .read(authControllerProvider.notifier)
          .changeAuth(AuthState.authenticated(r.token!));
      return true;
    });
  }
}



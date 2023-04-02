


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/shared_preference_controller.dart';
import '../model/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unAuthenticated());

  void getAuth() async {
    final token = await SharedPreferencesService.getAuth();
    if (token == null) {
      state = const AuthState.unAuthenticated();
    } else {
      state = AuthState.authenticated(token);
    }
  }

  void logout() {
    state = const AuthState.unAuthenticated();
    SharedPreferencesService.clear();
  }

  void changeAuth(AuthState authState) {
    state = authState;
  }
}
final authControllerProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
import 'package:e_commerce/controller/shared_preference_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthState { initialize, authenticated, unauthenticated }



class IsLoginOrLogoutController extends StateNotifier<AuthState> {
  final Ref ref;

  IsLoginOrLogoutController(this.ref) : super(AuthState.initialize) {
    init();
  }

  Future<void> refreshAllState() async {

  }

  Future<void> init() async {
    final shp = ref.read(sharedPreferencesProvider);
    final authState = await shp.getAuthState();
    if (authState == null) {
      //remove active people list when logout
      // ref.read(statusIdListConrollerProvider.notifier).removeListWhenLogout();
      state = AuthState.unauthenticated;
    } else if (authState) {
      refreshAllState();
      state = AuthState.authenticated;
    } else {
      state = AuthState.unauthenticated;
    }
  }
}

final appStartUpProvider =
StateNotifierProvider<IsLoginOrLogoutController, AuthState>(
        (ref) => IsLoginOrLogoutController(ref));
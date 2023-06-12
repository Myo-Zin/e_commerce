import 'package:e_commerce/auth/model/auth_state.dart';
import 'package:e_commerce/data/api_const.dart';
import 'package:e_commerce/profile/service/profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/auth_controller.dart';
import '../../util/failure.dart';
import '../model/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final Ref ref;
  final ProfileService _profileService;

  ProfileNotifier(
    this.ref,
    this._profileService,
  ) : super(const ProfileState.loading()) {
    final authState = ref.watch(authControllerProvider);
    authState.maybeWhen(
      authenticated: () {
        getProfile();
      },
      orElse: () {
        state = const ProfileState.unAuthenticated();
      },
    );
  }

  getProfile() async {
    try {
      final id = await ApiHelper.wooCommerce.fetchLoggedInUserId();
      final result = await ApiHelper.wooCommerce.getCustomerById(id: id);
      state = ProfileState.data(result);
    } catch (e) {
      ref.watch(authControllerProvider.notifier).logout();
      state = ProfileState.error(e.toString());
    }

    // final result = await _profileService.getProfile( email: email);
    // if (mounted) {
    //   result.fold(
    //     (l) {
    //       print(l.reason);
    //       if (l.reason == FailureReason.authError) {
    //         ref.read(authControllerProvider.notifier).logout();
    //       }
    //       if (l.reason == FailureReason.normalError) {
    //         ref.read(authControllerProvider.notifier).logout();
    //       }
    //       if (mounted) {
    //         state = ProfileState.error(l.message);
    //       }
    //     },
    //     (profile) {
    //       state = ProfileState.data(profile);
    //     },
    //   );
    // }
  }
}

import 'package:e_commerce/profile/controller/profile_controller.dart';
import 'package:e_commerce/profile/model/profile_state.dart';
import 'package:e_commerce/profile/service/profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network.dart';

final profileServiceProvider =
    Provider((ref) => ProfileService(ref.read(dioProvider)));

final profileController = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(
    ref,
    ref.watch(profileServiceProvider),
  ),
);

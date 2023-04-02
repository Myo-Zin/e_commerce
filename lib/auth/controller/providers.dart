import 'package:e_commerce/auth/controller/register_controller.dart';
import 'package:e_commerce/auth/model/register_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network.dart';
import '../service/login_register_service.dart';
import 'login_controller.dart';

final loginRegisterServiceProvider =
    Provider((ref) => LoginRegisterService(ref.read(dioProvider)));

final registerController =
    StateNotifierProvider.autoDispose<RegisterNotifier, AsyncValue<RegisterResponse>>(
  (ref) => RegisterNotifier(
    ref.watch(loginRegisterServiceProvider),
  ),
);
final customerController =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<void>>(
  (ref) => LoginNotifier(ref.watch(loginRegisterServiceProvider), ref),
);

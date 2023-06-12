import 'package:e_commerce/profile/model/profile_data_response.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';


@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading()=_Loading;
  const factory ProfileState.data(WooCustomer profileData) = _Data;
  const factory ProfileState.unAuthenticated() = _UnAuthenticated;
  const factory ProfileState.error(String message)=_Error;
}
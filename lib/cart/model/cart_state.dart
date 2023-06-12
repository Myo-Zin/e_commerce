import 'package:e_commerce/cart/model/cart_response.dart';
import 'package:flutter_wp_woocommerce/models/cart.dart';
import 'package:flutter_wp_woocommerce/models/cart_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item.dart';


part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.empty() = _Empty;

  const factory CartState.loading() = _Loading;

  const factory CartState.data(List<CartItem> cartItems) = _Data;

  const factory CartState.error(String message) = _Error;
}

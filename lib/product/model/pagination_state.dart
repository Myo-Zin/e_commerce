import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_state.freezed.dart';

@freezed
abstract class PaginatedProductState with _$PaginatedProductState {
  const factory PaginatedProductState({
    @Default(1) int page,
    List<WooProduct>? products,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _PaginatedProductState;

  const PaginatedProductState._();
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_param.freezed.dart';

@freezed
 class ProductParameter with _$ProductParameter {
  factory ProductParameter({
    String? searchParam,
    String? category,
  }) = _ProductParameter;
}
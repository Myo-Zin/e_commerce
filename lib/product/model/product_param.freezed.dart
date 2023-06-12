// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProductParameter {
  String? get searchParam => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductParameterCopyWith<ProductParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductParameterCopyWith<$Res> {
  factory $ProductParameterCopyWith(
          ProductParameter value, $Res Function(ProductParameter) then) =
      _$ProductParameterCopyWithImpl<$Res, ProductParameter>;
  @useResult
  $Res call({String? searchParam, String? category});
}

/// @nodoc
class _$ProductParameterCopyWithImpl<$Res, $Val extends ProductParameter>
    implements $ProductParameterCopyWith<$Res> {
  _$ProductParameterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchParam = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      searchParam: freezed == searchParam
          ? _value.searchParam
          : searchParam // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductParameterCopyWith<$Res>
    implements $ProductParameterCopyWith<$Res> {
  factory _$$_ProductParameterCopyWith(
          _$_ProductParameter value, $Res Function(_$_ProductParameter) then) =
      __$$_ProductParameterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? searchParam, String? category});
}

/// @nodoc
class __$$_ProductParameterCopyWithImpl<$Res>
    extends _$ProductParameterCopyWithImpl<$Res, _$_ProductParameter>
    implements _$$_ProductParameterCopyWith<$Res> {
  __$$_ProductParameterCopyWithImpl(
      _$_ProductParameter _value, $Res Function(_$_ProductParameter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchParam = freezed,
    Object? category = freezed,
  }) {
    return _then(_$_ProductParameter(
      searchParam: freezed == searchParam
          ? _value.searchParam
          : searchParam // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ProductParameter implements _ProductParameter {
  _$_ProductParameter({this.searchParam, this.category});

  @override
  final String? searchParam;
  @override
  final String? category;

  @override
  String toString() {
    return 'ProductParameter(searchParam: $searchParam, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductParameter &&
            (identical(other.searchParam, searchParam) ||
                other.searchParam == searchParam) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchParam, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductParameterCopyWith<_$_ProductParameter> get copyWith =>
      __$$_ProductParameterCopyWithImpl<_$_ProductParameter>(this, _$identity);
}

abstract class _ProductParameter implements ProductParameter {
  factory _ProductParameter(
      {final String? searchParam,
      final String? category}) = _$_ProductParameter;

  @override
  String? get searchParam;
  @override
  String? get category;
  @override
  @JsonKey(ignore: true)
  _$$_ProductParameterCopyWith<_$_ProductParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

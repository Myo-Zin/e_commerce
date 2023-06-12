// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaginatedProductState {
  int get page => throw _privateConstructorUsedError;
  List<WooProduct>? get products => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  bool get isLoadMoreDone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginatedProductStateCopyWith<PaginatedProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedProductStateCopyWith<$Res> {
  factory $PaginatedProductStateCopyWith(PaginatedProductState value,
          $Res Function(PaginatedProductState) then) =
      _$PaginatedProductStateCopyWithImpl<$Res, PaginatedProductState>;
  @useResult
  $Res call(
      {int page,
      List<WooProduct>? products,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone});
}

/// @nodoc
class _$PaginatedProductStateCopyWithImpl<$Res,
        $Val extends PaginatedProductState>
    implements $PaginatedProductStateCopyWith<$Res> {
  _$PaginatedProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? products = freezed,
    Object? isLoading = null,
    Object? isLoadMoreError = null,
    Object? isLoadMoreDone = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<WooProduct>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreError: null == isLoadMoreError
          ? _value.isLoadMoreError
          : isLoadMoreError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreDone: null == isLoadMoreDone
          ? _value.isLoadMoreDone
          : isLoadMoreDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaginatedProductStateCopyWith<$Res>
    implements $PaginatedProductStateCopyWith<$Res> {
  factory _$$_PaginatedProductStateCopyWith(_$_PaginatedProductState value,
          $Res Function(_$_PaginatedProductState) then) =
      __$$_PaginatedProductStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      List<WooProduct>? products,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone});
}

/// @nodoc
class __$$_PaginatedProductStateCopyWithImpl<$Res>
    extends _$PaginatedProductStateCopyWithImpl<$Res, _$_PaginatedProductState>
    implements _$$_PaginatedProductStateCopyWith<$Res> {
  __$$_PaginatedProductStateCopyWithImpl(_$_PaginatedProductState _value,
      $Res Function(_$_PaginatedProductState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? products = freezed,
    Object? isLoading = null,
    Object? isLoadMoreError = null,
    Object? isLoadMoreDone = null,
  }) {
    return _then(_$_PaginatedProductState(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<WooProduct>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreError: null == isLoadMoreError
          ? _value.isLoadMoreError
          : isLoadMoreError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreDone: null == isLoadMoreDone
          ? _value.isLoadMoreDone
          : isLoadMoreDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PaginatedProductState extends _PaginatedProductState {
  const _$_PaginatedProductState(
      {this.page = 1,
      final List<WooProduct>? products,
      this.isLoading = true,
      this.isLoadMoreError = false,
      this.isLoadMoreDone = false})
      : _products = products,
        super._();

  @override
  @JsonKey()
  final int page;
  final List<WooProduct>? _products;
  @override
  List<WooProduct>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadMoreError;
  @override
  @JsonKey()
  final bool isLoadMoreDone;

  @override
  String toString() {
    return 'PaginatedProductState(page: $page, products: $products, isLoading: $isLoading, isLoadMoreError: $isLoadMoreError, isLoadMoreDone: $isLoadMoreDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaginatedProductState &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadMoreError, isLoadMoreError) ||
                other.isLoadMoreError == isLoadMoreError) &&
            (identical(other.isLoadMoreDone, isLoadMoreDone) ||
                other.isLoadMoreDone == isLoadMoreDone));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      const DeepCollectionEquality().hash(_products),
      isLoading,
      isLoadMoreError,
      isLoadMoreDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaginatedProductStateCopyWith<_$_PaginatedProductState> get copyWith =>
      __$$_PaginatedProductStateCopyWithImpl<_$_PaginatedProductState>(
          this, _$identity);
}

abstract class _PaginatedProductState extends PaginatedProductState {
  const factory _PaginatedProductState(
      {final int page,
      final List<WooProduct>? products,
      final bool isLoading,
      final bool isLoadMoreError,
      final bool isLoadMoreDone}) = _$_PaginatedProductState;
  const _PaginatedProductState._() : super._();

  @override
  int get page;
  @override
  List<WooProduct>? get products;
  @override
  bool get isLoading;
  @override
  bool get isLoadMoreError;
  @override
  bool get isLoadMoreDone;
  @override
  @JsonKey(ignore: true)
  _$$_PaginatedProductStateCopyWith<_$_PaginatedProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActSearchWidgetEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String stockCode) searchStock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String stockCode)? searchStock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String stockCode)? searchStock,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnSearchStock value) searchStock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSearchStock value)? searchStock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSearchStock value)? searchStock,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActSearchWidgetEventCopyWith<$Res> {
  factory $ActSearchWidgetEventCopyWith(ActSearchWidgetEvent value,
          $Res Function(ActSearchWidgetEvent) then) =
      _$ActSearchWidgetEventCopyWithImpl<$Res, ActSearchWidgetEvent>;
}

/// @nodoc
class _$ActSearchWidgetEventCopyWithImpl<$Res,
        $Val extends ActSearchWidgetEvent>
    implements $ActSearchWidgetEventCopyWith<$Res> {
  _$ActSearchWidgetEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OnInitImplCopyWith<$Res> {
  factory _$$OnInitImplCopyWith(
          _$OnInitImpl value, $Res Function(_$OnInitImpl) then) =
      __$$OnInitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnInitImplCopyWithImpl<$Res>
    extends _$ActSearchWidgetEventCopyWithImpl<$Res, _$OnInitImpl>
    implements _$$OnInitImplCopyWith<$Res> {
  __$$OnInitImplCopyWithImpl(
      _$OnInitImpl _value, $Res Function(_$OnInitImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OnInitImpl implements _OnInit {
  const _$OnInitImpl();

  @override
  String toString() {
    return 'ActSearchWidgetEvent.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnInitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String stockCode) searchStock,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String stockCode)? searchStock,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String stockCode)? searchStock,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnSearchStock value) searchStock,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSearchStock value)? searchStock,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSearchStock value)? searchStock,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _OnInit implements ActSearchWidgetEvent {
  const factory _OnInit() = _$OnInitImpl;
}

/// @nodoc
abstract class _$$OnSearchStockImplCopyWith<$Res> {
  factory _$$OnSearchStockImplCopyWith(
          _$OnSearchStockImpl value, $Res Function(_$OnSearchStockImpl) then) =
      __$$OnSearchStockImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String stockCode});
}

/// @nodoc
class __$$OnSearchStockImplCopyWithImpl<$Res>
    extends _$ActSearchWidgetEventCopyWithImpl<$Res, _$OnSearchStockImpl>
    implements _$$OnSearchStockImplCopyWith<$Res> {
  __$$OnSearchStockImplCopyWithImpl(
      _$OnSearchStockImpl _value, $Res Function(_$OnSearchStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
  }) {
    return _then(_$OnSearchStockImpl(
      null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OnSearchStockImpl implements _OnSearchStock {
  const _$OnSearchStockImpl(this.stockCode);

  @override
  final String stockCode;

  @override
  String toString() {
    return 'ActSearchWidgetEvent.searchStock(stockCode: $stockCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnSearchStockImpl &&
            (identical(other.stockCode, stockCode) ||
                other.stockCode == stockCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stockCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnSearchStockImplCopyWith<_$OnSearchStockImpl> get copyWith =>
      __$$OnSearchStockImplCopyWithImpl<_$OnSearchStockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String stockCode) searchStock,
  }) {
    return searchStock(stockCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String stockCode)? searchStock,
  }) {
    return searchStock?.call(stockCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String stockCode)? searchStock,
    required TResult orElse(),
  }) {
    if (searchStock != null) {
      return searchStock(stockCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnSearchStock value) searchStock,
  }) {
    return searchStock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSearchStock value)? searchStock,
  }) {
    return searchStock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSearchStock value)? searchStock,
    required TResult orElse(),
  }) {
    if (searchStock != null) {
      return searchStock(this);
    }
    return orElse();
  }
}

abstract class _OnSearchStock implements ActSearchWidgetEvent {
  const factory _OnSearchStock(final String stockCode) = _$OnSearchStockImpl;

  String get stockCode;
  @JsonKey(ignore: true)
  _$$OnSearchStockImplCopyWith<_$OnSearchStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActSearchWidgetState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<BaseStock> get stocks => throw _privateConstructorUsedError;
  String? get errorToastMessage => throw _privateConstructorUsedError;
  String? get notiToastMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActSearchWidgetStateCopyWith<ActSearchWidgetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActSearchWidgetStateCopyWith<$Res> {
  factory $ActSearchWidgetStateCopyWith(ActSearchWidgetState value,
          $Res Function(ActSearchWidgetState) then) =
      _$ActSearchWidgetStateCopyWithImpl<$Res, ActSearchWidgetState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<BaseStock> stocks,
      String? errorToastMessage,
      String? notiToastMessage});
}

/// @nodoc
class _$ActSearchWidgetStateCopyWithImpl<$Res,
        $Val extends ActSearchWidgetState>
    implements $ActSearchWidgetStateCopyWith<$Res> {
  _$ActSearchWidgetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? stocks = null,
    Object? errorToastMessage = freezed,
    Object? notiToastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      stocks: null == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<BaseStock>,
      errorToastMessage: freezed == errorToastMessage
          ? _value.errorToastMessage
          : errorToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      notiToastMessage: freezed == notiToastMessage
          ? _value.notiToastMessage
          : notiToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActPostListWidgetStateImplCopyWith<$Res>
    implements $ActSearchWidgetStateCopyWith<$Res> {
  factory _$$ActPostListWidgetStateImplCopyWith(
          _$ActPostListWidgetStateImpl value,
          $Res Function(_$ActPostListWidgetStateImpl) then) =
      __$$ActPostListWidgetStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<BaseStock> stocks,
      String? errorToastMessage,
      String? notiToastMessage});
}

/// @nodoc
class __$$ActPostListWidgetStateImplCopyWithImpl<$Res>
    extends _$ActSearchWidgetStateCopyWithImpl<$Res,
        _$ActPostListWidgetStateImpl>
    implements _$$ActPostListWidgetStateImplCopyWith<$Res> {
  __$$ActPostListWidgetStateImplCopyWithImpl(
      _$ActPostListWidgetStateImpl _value,
      $Res Function(_$ActPostListWidgetStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? stocks = null,
    Object? errorToastMessage = freezed,
    Object? notiToastMessage = freezed,
  }) {
    return _then(_$ActPostListWidgetStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<BaseStock>,
      errorToastMessage: freezed == errorToastMessage
          ? _value.errorToastMessage
          : errorToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      notiToastMessage: freezed == notiToastMessage
          ? _value.notiToastMessage
          : notiToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ActPostListWidgetStateImpl extends _ActPostListWidgetState {
  const _$ActPostListWidgetStateImpl(
      {required this.isLoading,
      required final List<BaseStock> stocks,
      this.errorToastMessage = null,
      this.notiToastMessage = null})
      : _stocks = stocks,
        super._();

  @override
  final bool isLoading;
  final List<BaseStock> _stocks;
  @override
  List<BaseStock> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  @override
  @JsonKey()
  final String? errorToastMessage;
  @override
  @JsonKey()
  final String? notiToastMessage;

  @override
  String toString() {
    return 'ActSearchWidgetState(isLoading: $isLoading, stocks: $stocks, errorToastMessage: $errorToastMessage, notiToastMessage: $notiToastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActPostListWidgetStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._stocks, _stocks) &&
            (identical(other.errorToastMessage, errorToastMessage) ||
                other.errorToastMessage == errorToastMessage) &&
            (identical(other.notiToastMessage, notiToastMessage) ||
                other.notiToastMessage == notiToastMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_stocks),
      errorToastMessage,
      notiToastMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActPostListWidgetStateImplCopyWith<_$ActPostListWidgetStateImpl>
      get copyWith => __$$ActPostListWidgetStateImplCopyWithImpl<
          _$ActPostListWidgetStateImpl>(this, _$identity);
}

abstract class _ActPostListWidgetState extends ActSearchWidgetState {
  const factory _ActPostListWidgetState(
      {required final bool isLoading,
      required final List<BaseStock> stocks,
      final String? errorToastMessage,
      final String? notiToastMessage}) = _$ActPostListWidgetStateImpl;
  const _ActPostListWidgetState._() : super._();

  @override
  bool get isLoading;
  @override
  List<BaseStock> get stocks;
  @override
  String? get errorToastMessage;
  @override
  String? get notiToastMessage;
  @override
  @JsonKey(ignore: true)
  _$$ActPostListWidgetStateImplCopyWith<_$ActPostListWidgetStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

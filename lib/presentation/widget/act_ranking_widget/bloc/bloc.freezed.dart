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
mixin _$RankingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(RankingSortType selectedSortType) sort,
    required TResult Function(RankingSortType? selectedSortType) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(RankingSortType selectedSortType)? sort,
    TResult? Function(RankingSortType? selectedSortType)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(RankingSortType selectedSortType)? sort,
    TResult Function(RankingSortType? selectedSortType)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnSort value) sort,
    required TResult Function(_OnRefresh value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSort value)? sort,
    TResult? Function(_OnRefresh value)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSort value)? sort,
    TResult Function(_OnRefresh value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankingEventCopyWith<$Res> {
  factory $RankingEventCopyWith(
          RankingEvent value, $Res Function(RankingEvent) then) =
      _$RankingEventCopyWithImpl<$Res, RankingEvent>;
}

/// @nodoc
class _$RankingEventCopyWithImpl<$Res, $Val extends RankingEvent>
    implements $RankingEventCopyWith<$Res> {
  _$RankingEventCopyWithImpl(this._value, this._then);

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
    extends _$RankingEventCopyWithImpl<$Res, _$OnInitImpl>
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
    return 'RankingEvent.init()';
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
    required TResult Function(RankingSortType selectedSortType) sort,
    required TResult Function(RankingSortType? selectedSortType) refresh,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(RankingSortType selectedSortType)? sort,
    TResult? Function(RankingSortType? selectedSortType)? refresh,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(RankingSortType selectedSortType)? sort,
    TResult Function(RankingSortType? selectedSortType)? refresh,
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
    required TResult Function(_OnSort value) sort,
    required TResult Function(_OnRefresh value) refresh,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSort value)? sort,
    TResult? Function(_OnRefresh value)? refresh,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSort value)? sort,
    TResult Function(_OnRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _OnInit implements RankingEvent {
  const factory _OnInit() = _$OnInitImpl;
}

/// @nodoc
abstract class _$$OnSortImplCopyWith<$Res> {
  factory _$$OnSortImplCopyWith(
          _$OnSortImpl value, $Res Function(_$OnSortImpl) then) =
      __$$OnSortImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RankingSortType selectedSortType});
}

/// @nodoc
class __$$OnSortImplCopyWithImpl<$Res>
    extends _$RankingEventCopyWithImpl<$Res, _$OnSortImpl>
    implements _$$OnSortImplCopyWith<$Res> {
  __$$OnSortImplCopyWithImpl(
      _$OnSortImpl _value, $Res Function(_$OnSortImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSortType = null,
  }) {
    return _then(_$OnSortImpl(
      null == selectedSortType
          ? _value.selectedSortType
          : selectedSortType // ignore: cast_nullable_to_non_nullable
              as RankingSortType,
    ));
  }
}

/// @nodoc

class _$OnSortImpl implements _OnSort {
  const _$OnSortImpl(this.selectedSortType);

  @override
  final RankingSortType selectedSortType;

  @override
  String toString() {
    return 'RankingEvent.sort(selectedSortType: $selectedSortType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnSortImpl &&
            (identical(other.selectedSortType, selectedSortType) ||
                other.selectedSortType == selectedSortType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedSortType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnSortImplCopyWith<_$OnSortImpl> get copyWith =>
      __$$OnSortImplCopyWithImpl<_$OnSortImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(RankingSortType selectedSortType) sort,
    required TResult Function(RankingSortType? selectedSortType) refresh,
  }) {
    return sort(selectedSortType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(RankingSortType selectedSortType)? sort,
    TResult? Function(RankingSortType? selectedSortType)? refresh,
  }) {
    return sort?.call(selectedSortType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(RankingSortType selectedSortType)? sort,
    TResult Function(RankingSortType? selectedSortType)? refresh,
    required TResult orElse(),
  }) {
    if (sort != null) {
      return sort(selectedSortType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnSort value) sort,
    required TResult Function(_OnRefresh value) refresh,
  }) {
    return sort(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSort value)? sort,
    TResult? Function(_OnRefresh value)? refresh,
  }) {
    return sort?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSort value)? sort,
    TResult Function(_OnRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (sort != null) {
      return sort(this);
    }
    return orElse();
  }
}

abstract class _OnSort implements RankingEvent {
  const factory _OnSort(final RankingSortType selectedSortType) = _$OnSortImpl;

  RankingSortType get selectedSortType;
  @JsonKey(ignore: true)
  _$$OnSortImplCopyWith<_$OnSortImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnRefreshImplCopyWith<$Res> {
  factory _$$OnRefreshImplCopyWith(
          _$OnRefreshImpl value, $Res Function(_$OnRefreshImpl) then) =
      __$$OnRefreshImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RankingSortType? selectedSortType});
}

/// @nodoc
class __$$OnRefreshImplCopyWithImpl<$Res>
    extends _$RankingEventCopyWithImpl<$Res, _$OnRefreshImpl>
    implements _$$OnRefreshImplCopyWith<$Res> {
  __$$OnRefreshImplCopyWithImpl(
      _$OnRefreshImpl _value, $Res Function(_$OnRefreshImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSortType = freezed,
  }) {
    return _then(_$OnRefreshImpl(
      freezed == selectedSortType
          ? _value.selectedSortType
          : selectedSortType // ignore: cast_nullable_to_non_nullable
              as RankingSortType?,
    ));
  }
}

/// @nodoc

class _$OnRefreshImpl implements _OnRefresh {
  const _$OnRefreshImpl([this.selectedSortType]);

  @override
  final RankingSortType? selectedSortType;

  @override
  String toString() {
    return 'RankingEvent.refresh(selectedSortType: $selectedSortType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnRefreshImpl &&
            (identical(other.selectedSortType, selectedSortType) ||
                other.selectedSortType == selectedSortType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedSortType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnRefreshImplCopyWith<_$OnRefreshImpl> get copyWith =>
      __$$OnRefreshImplCopyWithImpl<_$OnRefreshImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(RankingSortType selectedSortType) sort,
    required TResult Function(RankingSortType? selectedSortType) refresh,
  }) {
    return refresh(selectedSortType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(RankingSortType selectedSortType)? sort,
    TResult? Function(RankingSortType? selectedSortType)? refresh,
  }) {
    return refresh?.call(selectedSortType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(RankingSortType selectedSortType)? sort,
    TResult Function(RankingSortType? selectedSortType)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(selectedSortType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnSort value) sort,
    required TResult Function(_OnRefresh value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnSort value)? sort,
    TResult? Function(_OnRefresh value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnSort value)? sort,
    TResult Function(_OnRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class _OnRefresh implements RankingEvent {
  const factory _OnRefresh([final RankingSortType? selectedSortType]) =
      _$OnRefreshImpl;

  RankingSortType? get selectedSortType;
  @JsonKey(ignore: true)
  _$$OnRefreshImplCopyWith<_$OnRefreshImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RankingState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<RankingStock> get rankingStockList => throw _privateConstructorUsedError;
  List<RankingSortType> get rankingSortTypeList =>
      throw _privateConstructorUsedError;
  RankingSortType get currentSortType => throw _privateConstructorUsedError;
  String? get errorToastMessage => throw _privateConstructorUsedError;
  String? get notiToastMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RankingStateCopyWith<RankingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankingStateCopyWith<$Res> {
  factory $RankingStateCopyWith(
          RankingState value, $Res Function(RankingState) then) =
      _$RankingStateCopyWithImpl<$Res, RankingState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<RankingStock> rankingStockList,
      List<RankingSortType> rankingSortTypeList,
      RankingSortType currentSortType,
      String? errorToastMessage,
      String? notiToastMessage});
}

/// @nodoc
class _$RankingStateCopyWithImpl<$Res, $Val extends RankingState>
    implements $RankingStateCopyWith<$Res> {
  _$RankingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rankingStockList = null,
    Object? rankingSortTypeList = null,
    Object? currentSortType = null,
    Object? errorToastMessage = freezed,
    Object? notiToastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      rankingStockList: null == rankingStockList
          ? _value.rankingStockList
          : rankingStockList // ignore: cast_nullable_to_non_nullable
              as List<RankingStock>,
      rankingSortTypeList: null == rankingSortTypeList
          ? _value.rankingSortTypeList
          : rankingSortTypeList // ignore: cast_nullable_to_non_nullable
              as List<RankingSortType>,
      currentSortType: null == currentSortType
          ? _value.currentSortType
          : currentSortType // ignore: cast_nullable_to_non_nullable
              as RankingSortType,
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
abstract class _$$RankingStateImplCopyWith<$Res>
    implements $RankingStateCopyWith<$Res> {
  factory _$$RankingStateImplCopyWith(
          _$RankingStateImpl value, $Res Function(_$RankingStateImpl) then) =
      __$$RankingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<RankingStock> rankingStockList,
      List<RankingSortType> rankingSortTypeList,
      RankingSortType currentSortType,
      String? errorToastMessage,
      String? notiToastMessage});
}

/// @nodoc
class __$$RankingStateImplCopyWithImpl<$Res>
    extends _$RankingStateCopyWithImpl<$Res, _$RankingStateImpl>
    implements _$$RankingStateImplCopyWith<$Res> {
  __$$RankingStateImplCopyWithImpl(
      _$RankingStateImpl _value, $Res Function(_$RankingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rankingStockList = null,
    Object? rankingSortTypeList = null,
    Object? currentSortType = null,
    Object? errorToastMessage = freezed,
    Object? notiToastMessage = freezed,
  }) {
    return _then(_$RankingStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      rankingStockList: null == rankingStockList
          ? _value._rankingStockList
          : rankingStockList // ignore: cast_nullable_to_non_nullable
              as List<RankingStock>,
      rankingSortTypeList: null == rankingSortTypeList
          ? _value._rankingSortTypeList
          : rankingSortTypeList // ignore: cast_nullable_to_non_nullable
              as List<RankingSortType>,
      currentSortType: null == currentSortType
          ? _value.currentSortType
          : currentSortType // ignore: cast_nullable_to_non_nullable
              as RankingSortType,
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

class _$RankingStateImpl implements _RankingState {
  _$RankingStateImpl(
      {required this.isLoading,
      required final List<RankingStock> rankingStockList,
      required final List<RankingSortType> rankingSortTypeList,
      required this.currentSortType,
      this.errorToastMessage = null,
      this.notiToastMessage = null})
      : _rankingStockList = rankingStockList,
        _rankingSortTypeList = rankingSortTypeList;

  @override
  final bool isLoading;
  final List<RankingStock> _rankingStockList;
  @override
  List<RankingStock> get rankingStockList {
    if (_rankingStockList is EqualUnmodifiableListView)
      return _rankingStockList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rankingStockList);
  }

  final List<RankingSortType> _rankingSortTypeList;
  @override
  List<RankingSortType> get rankingSortTypeList {
    if (_rankingSortTypeList is EqualUnmodifiableListView)
      return _rankingSortTypeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rankingSortTypeList);
  }

  @override
  final RankingSortType currentSortType;
  @override
  @JsonKey()
  final String? errorToastMessage;
  @override
  @JsonKey()
  final String? notiToastMessage;

  @override
  String toString() {
    return 'RankingState(isLoading: $isLoading, rankingStockList: $rankingStockList, rankingSortTypeList: $rankingSortTypeList, currentSortType: $currentSortType, errorToastMessage: $errorToastMessage, notiToastMessage: $notiToastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RankingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._rankingStockList, _rankingStockList) &&
            const DeepCollectionEquality()
                .equals(other._rankingSortTypeList, _rankingSortTypeList) &&
            (identical(other.currentSortType, currentSortType) ||
                other.currentSortType == currentSortType) &&
            (identical(other.errorToastMessage, errorToastMessage) ||
                other.errorToastMessage == errorToastMessage) &&
            (identical(other.notiToastMessage, notiToastMessage) ||
                other.notiToastMessage == notiToastMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_rankingStockList),
      const DeepCollectionEquality().hash(_rankingSortTypeList),
      currentSortType,
      errorToastMessage,
      notiToastMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RankingStateImplCopyWith<_$RankingStateImpl> get copyWith =>
      __$$RankingStateImplCopyWithImpl<_$RankingStateImpl>(this, _$identity);
}

abstract class _RankingState implements RankingState {
  factory _RankingState(
      {required final bool isLoading,
      required final List<RankingStock> rankingStockList,
      required final List<RankingSortType> rankingSortTypeList,
      required final RankingSortType currentSortType,
      final String? errorToastMessage,
      final String? notiToastMessage}) = _$RankingStateImpl;

  @override
  bool get isLoading;
  @override
  List<RankingStock> get rankingStockList;
  @override
  List<RankingSortType> get rankingSortTypeList;
  @override
  RankingSortType get currentSortType;
  @override
  String? get errorToastMessage;
  @override
  String? get notiToastMessage;
  @override
  @JsonKey(ignore: true)
  _$$RankingStateImplCopyWith<_$RankingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RankingStock _$RankingStockFromJson(Map<String, dynamic> json) {
  return _RankingStock.fromJson(json);
}

/// @nodoc
mixin _$RankingStock {
  String get stockCode => throw _privateConstructorUsedError;
  String get stockName => throw _privateConstructorUsedError;
  @JsonKey(name: 'stake')
  String get stakeString => throw _privateConstructorUsedError;
  @JsonKey(name: 'marketValue')
  String get marketValueString => throw _privateConstructorUsedError;
  int get stakeRank => throw _privateConstructorUsedError;
  int get stakeRankDelta => throw _privateConstructorUsedError;
  int get marketValueRank => throw _privateConstructorUsedError;
  int get marketValueRankDelta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RankingStockCopyWith<RankingStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankingStockCopyWith<$Res> {
  factory $RankingStockCopyWith(
          RankingStock value, $Res Function(RankingStock) then) =
      _$RankingStockCopyWithImpl<$Res, RankingStock>;
  @useResult
  $Res call(
      {String stockCode,
      String stockName,
      @JsonKey(name: 'stake') String stakeString,
      @JsonKey(name: 'marketValue') String marketValueString,
      int stakeRank,
      int stakeRankDelta,
      int marketValueRank,
      int marketValueRankDelta});
}

/// @nodoc
class _$RankingStockCopyWithImpl<$Res, $Val extends RankingStock>
    implements $RankingStockCopyWith<$Res> {
  _$RankingStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
    Object? stockName = null,
    Object? stakeString = null,
    Object? marketValueString = null,
    Object? stakeRank = null,
    Object? stakeRankDelta = null,
    Object? marketValueRank = null,
    Object? marketValueRankDelta = null,
  }) {
    return _then(_value.copyWith(
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      stockName: null == stockName
          ? _value.stockName
          : stockName // ignore: cast_nullable_to_non_nullable
              as String,
      stakeString: null == stakeString
          ? _value.stakeString
          : stakeString // ignore: cast_nullable_to_non_nullable
              as String,
      marketValueString: null == marketValueString
          ? _value.marketValueString
          : marketValueString // ignore: cast_nullable_to_non_nullable
              as String,
      stakeRank: null == stakeRank
          ? _value.stakeRank
          : stakeRank // ignore: cast_nullable_to_non_nullable
              as int,
      stakeRankDelta: null == stakeRankDelta
          ? _value.stakeRankDelta
          : stakeRankDelta // ignore: cast_nullable_to_non_nullable
              as int,
      marketValueRank: null == marketValueRank
          ? _value.marketValueRank
          : marketValueRank // ignore: cast_nullable_to_non_nullable
              as int,
      marketValueRankDelta: null == marketValueRankDelta
          ? _value.marketValueRankDelta
          : marketValueRankDelta // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RankingStockImplCopyWith<$Res>
    implements $RankingStockCopyWith<$Res> {
  factory _$$RankingStockImplCopyWith(
          _$RankingStockImpl value, $Res Function(_$RankingStockImpl) then) =
      __$$RankingStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stockCode,
      String stockName,
      @JsonKey(name: 'stake') String stakeString,
      @JsonKey(name: 'marketValue') String marketValueString,
      int stakeRank,
      int stakeRankDelta,
      int marketValueRank,
      int marketValueRankDelta});
}

/// @nodoc
class __$$RankingStockImplCopyWithImpl<$Res>
    extends _$RankingStockCopyWithImpl<$Res, _$RankingStockImpl>
    implements _$$RankingStockImplCopyWith<$Res> {
  __$$RankingStockImplCopyWithImpl(
      _$RankingStockImpl _value, $Res Function(_$RankingStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
    Object? stockName = null,
    Object? stakeString = null,
    Object? marketValueString = null,
    Object? stakeRank = null,
    Object? stakeRankDelta = null,
    Object? marketValueRank = null,
    Object? marketValueRankDelta = null,
  }) {
    return _then(_$RankingStockImpl(
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      stockName: null == stockName
          ? _value.stockName
          : stockName // ignore: cast_nullable_to_non_nullable
              as String,
      stakeString: null == stakeString
          ? _value.stakeString
          : stakeString // ignore: cast_nullable_to_non_nullable
              as String,
      marketValueString: null == marketValueString
          ? _value.marketValueString
          : marketValueString // ignore: cast_nullable_to_non_nullable
              as String,
      stakeRank: null == stakeRank
          ? _value.stakeRank
          : stakeRank // ignore: cast_nullable_to_non_nullable
              as int,
      stakeRankDelta: null == stakeRankDelta
          ? _value.stakeRankDelta
          : stakeRankDelta // ignore: cast_nullable_to_non_nullable
              as int,
      marketValueRank: null == marketValueRank
          ? _value.marketValueRank
          : marketValueRank // ignore: cast_nullable_to_non_nullable
              as int,
      marketValueRankDelta: null == marketValueRankDelta
          ? _value.marketValueRankDelta
          : marketValueRankDelta // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RankingStockImpl extends _RankingStock {
  const _$RankingStockImpl(
      {required this.stockCode,
      required this.stockName,
      @JsonKey(name: 'stake') required this.stakeString,
      @JsonKey(name: 'marketValue') required this.marketValueString,
      required this.stakeRank,
      required this.stakeRankDelta,
      required this.marketValueRank,
      required this.marketValueRankDelta})
      : super._();

  factory _$RankingStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$RankingStockImplFromJson(json);

  @override
  final String stockCode;
  @override
  final String stockName;
  @override
  @JsonKey(name: 'stake')
  final String stakeString;
  @override
  @JsonKey(name: 'marketValue')
  final String marketValueString;
  @override
  final int stakeRank;
  @override
  final int stakeRankDelta;
  @override
  final int marketValueRank;
  @override
  final int marketValueRankDelta;

  @override
  String toString() {
    return 'RankingStock(stockCode: $stockCode, stockName: $stockName, stakeString: $stakeString, marketValueString: $marketValueString, stakeRank: $stakeRank, stakeRankDelta: $stakeRankDelta, marketValueRank: $marketValueRank, marketValueRankDelta: $marketValueRankDelta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RankingStockImpl &&
            (identical(other.stockCode, stockCode) ||
                other.stockCode == stockCode) &&
            (identical(other.stockName, stockName) ||
                other.stockName == stockName) &&
            (identical(other.stakeString, stakeString) ||
                other.stakeString == stakeString) &&
            (identical(other.marketValueString, marketValueString) ||
                other.marketValueString == marketValueString) &&
            (identical(other.stakeRank, stakeRank) ||
                other.stakeRank == stakeRank) &&
            (identical(other.stakeRankDelta, stakeRankDelta) ||
                other.stakeRankDelta == stakeRankDelta) &&
            (identical(other.marketValueRank, marketValueRank) ||
                other.marketValueRank == marketValueRank) &&
            (identical(other.marketValueRankDelta, marketValueRankDelta) ||
                other.marketValueRankDelta == marketValueRankDelta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stockCode,
      stockName,
      stakeString,
      marketValueString,
      stakeRank,
      stakeRankDelta,
      marketValueRank,
      marketValueRankDelta);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RankingStockImplCopyWith<_$RankingStockImpl> get copyWith =>
      __$$RankingStockImplCopyWithImpl<_$RankingStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RankingStockImplToJson(
      this,
    );
  }
}

abstract class _RankingStock extends RankingStock {
  const factory _RankingStock(
      {required final String stockCode,
      required final String stockName,
      @JsonKey(name: 'stake') required final String stakeString,
      @JsonKey(name: 'marketValue') required final String marketValueString,
      required final int stakeRank,
      required final int stakeRankDelta,
      required final int marketValueRank,
      required final int marketValueRankDelta}) = _$RankingStockImpl;
  const _RankingStock._() : super._();

  factory _RankingStock.fromJson(Map<String, dynamic> json) =
      _$RankingStockImpl.fromJson;

  @override
  String get stockCode;
  @override
  String get stockName;
  @override
  @JsonKey(name: 'stake')
  String get stakeString;
  @override
  @JsonKey(name: 'marketValue')
  String get marketValueString;
  @override
  int get stakeRank;
  @override
  int get stakeRankDelta;
  @override
  int get marketValueRank;
  @override
  int get marketValueRankDelta;
  @override
  @JsonKey(ignore: true)
  _$$RankingStockImplCopyWith<_$RankingStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

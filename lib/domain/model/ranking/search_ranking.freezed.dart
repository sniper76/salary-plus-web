// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchRanking _$SearchRankingFromJson(Map<String, dynamic> json) {
  return _SearchRanking.fromJson(json);
}

/// @nodoc
mixin _$SearchRanking {
  String? get title => throw _privateConstructorUsedError;
  String? get baseDateTime => throw _privateConstructorUsedError;
  List<Stock>? get stocks => throw _privateConstructorUsedError;
  SearchRankingType? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchRankingCopyWith<SearchRanking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchRankingCopyWith<$Res> {
  factory $SearchRankingCopyWith(
          SearchRanking value, $Res Function(SearchRanking) then) =
      _$SearchRankingCopyWithImpl<$Res, SearchRanking>;
  @useResult
  $Res call(
      {String? title,
      String? baseDateTime,
      List<Stock>? stocks,
      SearchRankingType? type});
}

/// @nodoc
class _$SearchRankingCopyWithImpl<$Res, $Val extends SearchRanking>
    implements $SearchRankingCopyWith<$Res> {
  _$SearchRankingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? baseDateTime = freezed,
    Object? stocks = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      baseDateTime: freezed == baseDateTime
          ? _value.baseDateTime
          : baseDateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      stocks: freezed == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SearchRankingType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchRankingImplCopyWith<$Res>
    implements $SearchRankingCopyWith<$Res> {
  factory _$$SearchRankingImplCopyWith(
          _$SearchRankingImpl value, $Res Function(_$SearchRankingImpl) then) =
      __$$SearchRankingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? baseDateTime,
      List<Stock>? stocks,
      SearchRankingType? type});
}

/// @nodoc
class __$$SearchRankingImplCopyWithImpl<$Res>
    extends _$SearchRankingCopyWithImpl<$Res, _$SearchRankingImpl>
    implements _$$SearchRankingImplCopyWith<$Res> {
  __$$SearchRankingImplCopyWithImpl(
      _$SearchRankingImpl _value, $Res Function(_$SearchRankingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? baseDateTime = freezed,
    Object? stocks = freezed,
    Object? type = freezed,
  }) {
    return _then(_$SearchRankingImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      baseDateTime: freezed == baseDateTime
          ? _value.baseDateTime
          : baseDateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      stocks: freezed == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SearchRankingType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchRankingImpl implements _SearchRanking {
  const _$SearchRankingImpl(
      {this.title, this.baseDateTime, final List<Stock>? stocks, this.type})
      : _stocks = stocks;

  factory _$SearchRankingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchRankingImplFromJson(json);

  @override
  final String? title;
  @override
  final String? baseDateTime;
  final List<Stock>? _stocks;
  @override
  List<Stock>? get stocks {
    final value = _stocks;
    if (value == null) return null;
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SearchRankingType? type;

  @override
  String toString() {
    return 'SearchRanking(title: $title, baseDateTime: $baseDateTime, stocks: $stocks, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchRankingImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.baseDateTime, baseDateTime) ||
                other.baseDateTime == baseDateTime) &&
            const DeepCollectionEquality().equals(other._stocks, _stocks) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, baseDateTime,
      const DeepCollectionEquality().hash(_stocks), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchRankingImplCopyWith<_$SearchRankingImpl> get copyWith =>
      __$$SearchRankingImplCopyWithImpl<_$SearchRankingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchRankingImplToJson(
      this,
    );
  }
}

abstract class _SearchRanking implements SearchRanking {
  const factory _SearchRanking(
      {final String? title,
      final String? baseDateTime,
      final List<Stock>? stocks,
      final SearchRankingType? type}) = _$SearchRankingImpl;

  factory _SearchRanking.fromJson(Map<String, dynamic> json) =
      _$SearchRankingImpl.fromJson;

  @override
  String? get title;
  @override
  String? get baseDateTime;
  @override
  List<Stock>? get stocks;
  @override
  SearchRankingType? get type;
  @override
  @JsonKey(ignore: true)
  _$$SearchRankingImplCopyWith<_$SearchRankingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

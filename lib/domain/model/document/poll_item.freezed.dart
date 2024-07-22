// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PollItem _$PollItemFromJson(Map<String, dynamic> json) {
  return _PollItem.fromJson(json);
}

/// @nodoc
mixin _$PollItem {
  int get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get voteItemCount => throw _privateConstructorUsedError;
  int get voteItemStockSum => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollItemCopyWith<PollItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollItemCopyWith<$Res> {
  factory $PollItemCopyWith(PollItem value, $Res Function(PollItem) then) =
      _$PollItemCopyWithImpl<$Res, PollItem>;
  @useResult
  $Res call({int id, String text, int voteItemCount, int voteItemStockSum});
}

/// @nodoc
class _$PollItemCopyWithImpl<$Res, $Val extends PollItem>
    implements $PollItemCopyWith<$Res> {
  _$PollItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? voteItemCount = null,
    Object? voteItemStockSum = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voteItemCount: null == voteItemCount
          ? _value.voteItemCount
          : voteItemCount // ignore: cast_nullable_to_non_nullable
              as int,
      voteItemStockSum: null == voteItemStockSum
          ? _value.voteItemStockSum
          : voteItemStockSum // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollItemImplCopyWith<$Res>
    implements $PollItemCopyWith<$Res> {
  factory _$$PollItemImplCopyWith(
          _$PollItemImpl value, $Res Function(_$PollItemImpl) then) =
      __$$PollItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String text, int voteItemCount, int voteItemStockSum});
}

/// @nodoc
class __$$PollItemImplCopyWithImpl<$Res>
    extends _$PollItemCopyWithImpl<$Res, _$PollItemImpl>
    implements _$$PollItemImplCopyWith<$Res> {
  __$$PollItemImplCopyWithImpl(
      _$PollItemImpl _value, $Res Function(_$PollItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? voteItemCount = null,
    Object? voteItemStockSum = null,
  }) {
    return _then(_$PollItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voteItemCount: null == voteItemCount
          ? _value.voteItemCount
          : voteItemCount // ignore: cast_nullable_to_non_nullable
              as int,
      voteItemStockSum: null == voteItemStockSum
          ? _value.voteItemStockSum
          : voteItemStockSum // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollItemImpl implements _PollItem {
  const _$PollItemImpl(
      {required this.id,
      required this.text,
      this.voteItemCount = 0,
      this.voteItemStockSum = 0});

  factory _$PollItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollItemImplFromJson(json);

  @override
  final int id;
  @override
  final String text;
  @override
  @JsonKey()
  final int voteItemCount;
  @override
  @JsonKey()
  final int voteItemStockSum;

  @override
  String toString() {
    return 'PollItem(id: $id, text: $text, voteItemCount: $voteItemCount, voteItemStockSum: $voteItemStockSum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.voteItemCount, voteItemCount) ||
                other.voteItemCount == voteItemCount) &&
            (identical(other.voteItemStockSum, voteItemStockSum) ||
                other.voteItemStockSum == voteItemStockSum));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, text, voteItemCount, voteItemStockSum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollItemImplCopyWith<_$PollItemImpl> get copyWith =>
      __$$PollItemImplCopyWithImpl<_$PollItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollItemImplToJson(
      this,
    );
  }
}

abstract class _PollItem implements PollItem {
  const factory _PollItem(
      {required final int id,
      required final String text,
      final int voteItemCount,
      final int voteItemStockSum}) = _$PollItemImpl;

  factory _PollItem.fromJson(Map<String, dynamic> json) =
      _$PollItemImpl.fromJson;

  @override
  int get id;
  @override
  String get text;
  @override
  int get voteItemCount;
  @override
  int get voteItemStockSum;
  @override
  @JsonKey(ignore: true)
  _$$PollItemImplCopyWith<_$PollItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

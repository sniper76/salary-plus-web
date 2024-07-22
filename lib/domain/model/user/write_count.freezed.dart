// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'write_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WriteCount _$WriteCountFromJson(Map<String, dynamic> json) {
  return _WriteCount.fromJson(json);
}

/// @nodoc
mixin _$WriteCount {
  int get current => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WriteCountCopyWith<WriteCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WriteCountCopyWith<$Res> {
  factory $WriteCountCopyWith(
          WriteCount value, $Res Function(WriteCount) then) =
      _$WriteCountCopyWithImpl<$Res, WriteCount>;
  @useResult
  $Res call({int current, int max});
}

/// @nodoc
class _$WriteCountCopyWithImpl<$Res, $Val extends WriteCount>
    implements $WriteCountCopyWith<$Res> {
  _$WriteCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? max = null,
  }) {
    return _then(_value.copyWith(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WriteCountImplCopyWith<$Res>
    implements $WriteCountCopyWith<$Res> {
  factory _$$WriteCountImplCopyWith(
          _$WriteCountImpl value, $Res Function(_$WriteCountImpl) then) =
      __$$WriteCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int current, int max});
}

/// @nodoc
class __$$WriteCountImplCopyWithImpl<$Res>
    extends _$WriteCountCopyWithImpl<$Res, _$WriteCountImpl>
    implements _$$WriteCountImplCopyWith<$Res> {
  __$$WriteCountImplCopyWithImpl(
      _$WriteCountImpl _value, $Res Function(_$WriteCountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? max = null,
  }) {
    return _then(_$WriteCountImpl(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WriteCountImpl extends _WriteCount {
  const _$WriteCountImpl({required this.current, required this.max})
      : super._();

  factory _$WriteCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$WriteCountImplFromJson(json);

  @override
  final int current;
  @override
  final int max;

  @override
  String toString() {
    return 'WriteCount(current: $current, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WriteCountImpl &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, current, max);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WriteCountImplCopyWith<_$WriteCountImpl> get copyWith =>
      __$$WriteCountImplCopyWithImpl<_$WriteCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WriteCountImplToJson(
      this,
    );
  }
}

abstract class _WriteCount extends WriteCount {
  const factory _WriteCount(
      {required final int current, required final int max}) = _$WriteCountImpl;
  const _WriteCount._() : super._();

  factory _WriteCount.fromJson(Map<String, dynamic> json) =
      _$WriteCountImpl.fromJson;

  @override
  int get current;
  @override
  int get max;
  @override
  @JsonKey(ignore: true)
  _$$WriteCountImplCopyWith<_$WriteCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

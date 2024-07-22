// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leading_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeadingStock _$LeadingStockFromJson(Map<String, dynamic> json) {
  return _LeadingStock.fromJson(json);
}

/// @nodoc
mixin _$LeadingStock {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeadingStockCopyWith<LeadingStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeadingStockCopyWith<$Res> {
  factory $LeadingStockCopyWith(
          LeadingStock value, $Res Function(LeadingStock) then) =
      _$LeadingStockCopyWithImpl<$Res, LeadingStock>;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$LeadingStockCopyWithImpl<$Res, $Val extends LeadingStock>
    implements $LeadingStockCopyWith<$Res> {
  _$LeadingStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeadingStockImplCopyWith<$Res>
    implements $LeadingStockCopyWith<$Res> {
  factory _$$LeadingStockImplCopyWith(
          _$LeadingStockImpl value, $Res Function(_$LeadingStockImpl) then) =
      __$$LeadingStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$LeadingStockImplCopyWithImpl<$Res>
    extends _$LeadingStockCopyWithImpl<$Res, _$LeadingStockImpl>
    implements _$$LeadingStockImplCopyWith<$Res> {
  __$$LeadingStockImplCopyWithImpl(
      _$LeadingStockImpl _value, $Res Function(_$LeadingStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$LeadingStockImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeadingStockImpl implements _LeadingStock {
  const _$LeadingStockImpl({required this.code, required this.name});

  factory _$LeadingStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeadingStockImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'LeadingStock(code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeadingStockImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeadingStockImplCopyWith<_$LeadingStockImpl> get copyWith =>
      __$$LeadingStockImplCopyWithImpl<_$LeadingStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeadingStockImplToJson(
      this,
    );
  }
}

abstract class _LeadingStock implements LeadingStock {
  const factory _LeadingStock(
      {required final String code,
      required final String name}) = _$LeadingStockImpl;

  factory _LeadingStock.fromJson(Map<String, dynamic> json) =
      _$LeadingStockImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$LeadingStockImplCopyWith<_$LeadingStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

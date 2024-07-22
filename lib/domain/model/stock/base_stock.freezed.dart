// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BaseStock _$BaseStockFromJson(Map<String, dynamic> json) {
  return _BaseStock.fromJson(json);
}

/// @nodoc
mixin _$BaseStock {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get standardCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseStockCopyWith<BaseStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseStockCopyWith<$Res> {
  factory $BaseStockCopyWith(BaseStock value, $Res Function(BaseStock) then) =
      _$BaseStockCopyWithImpl<$Res, BaseStock>;
  @useResult
  $Res call({String code, String name, String? standardCode});
}

/// @nodoc
class _$BaseStockCopyWithImpl<$Res, $Val extends BaseStock>
    implements $BaseStockCopyWith<$Res> {
  _$BaseStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? standardCode = freezed,
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
      standardCode: freezed == standardCode
          ? _value.standardCode
          : standardCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseStockImplCopyWith<$Res>
    implements $BaseStockCopyWith<$Res> {
  factory _$$BaseStockImplCopyWith(
          _$BaseStockImpl value, $Res Function(_$BaseStockImpl) then) =
      __$$BaseStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name, String? standardCode});
}

/// @nodoc
class __$$BaseStockImplCopyWithImpl<$Res>
    extends _$BaseStockCopyWithImpl<$Res, _$BaseStockImpl>
    implements _$$BaseStockImplCopyWith<$Res> {
  __$$BaseStockImplCopyWithImpl(
      _$BaseStockImpl _value, $Res Function(_$BaseStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? standardCode = freezed,
  }) {
    return _then(_$BaseStockImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      standardCode: freezed == standardCode
          ? _value.standardCode
          : standardCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BaseStockImpl extends _BaseStock {
  const _$BaseStockImpl(
      {required this.code, required this.name, this.standardCode})
      : super._();

  factory _$BaseStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaseStockImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final String? standardCode;

  @override
  String toString() {
    return 'BaseStock(code: $code, name: $name, standardCode: $standardCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseStockImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.standardCode, standardCode) ||
                other.standardCode == standardCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, standardCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseStockImplCopyWith<_$BaseStockImpl> get copyWith =>
      __$$BaseStockImplCopyWithImpl<_$BaseStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaseStockImplToJson(
      this,
    );
  }
}

abstract class _BaseStock extends BaseStock {
  const factory _BaseStock(
      {required final String code,
      required final String name,
      final String? standardCode}) = _$BaseStockImpl;
  const _BaseStock._() : super._();

  factory _BaseStock.fromJson(Map<String, dynamic> json) =
      _$BaseStockImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  String? get standardCode;
  @override
  @JsonKey(ignore: true)
  _$$BaseStockImplCopyWith<_$BaseStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

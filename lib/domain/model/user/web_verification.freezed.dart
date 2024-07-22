// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebVerification _$WebVerificationFromJson(Map<String, dynamic> json) {
  return _WebVerification.fromJson(json);
}

/// @nodoc
mixin _$WebVerification {
  String get verificationCode => throw _privateConstructorUsedError;
  DateTime get expirationDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebVerificationCopyWith<WebVerification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebVerificationCopyWith<$Res> {
  factory $WebVerificationCopyWith(
          WebVerification value, $Res Function(WebVerification) then) =
      _$WebVerificationCopyWithImpl<$Res, WebVerification>;
  @useResult
  $Res call({String verificationCode, DateTime expirationDateTime});
}

/// @nodoc
class _$WebVerificationCopyWithImpl<$Res, $Val extends WebVerification>
    implements $WebVerificationCopyWith<$Res> {
  _$WebVerificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationCode = null,
    Object? expirationDateTime = null,
  }) {
    return _then(_value.copyWith(
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
      expirationDateTime: null == expirationDateTime
          ? _value.expirationDateTime
          : expirationDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebVerificationImplCopyWith<$Res>
    implements $WebVerificationCopyWith<$Res> {
  factory _$$WebVerificationImplCopyWith(_$WebVerificationImpl value,
          $Res Function(_$WebVerificationImpl) then) =
      __$$WebVerificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String verificationCode, DateTime expirationDateTime});
}

/// @nodoc
class __$$WebVerificationImplCopyWithImpl<$Res>
    extends _$WebVerificationCopyWithImpl<$Res, _$WebVerificationImpl>
    implements _$$WebVerificationImplCopyWith<$Res> {
  __$$WebVerificationImplCopyWithImpl(
      _$WebVerificationImpl _value, $Res Function(_$WebVerificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationCode = null,
    Object? expirationDateTime = null,
  }) {
    return _then(_$WebVerificationImpl(
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
      expirationDateTime: null == expirationDateTime
          ? _value.expirationDateTime
          : expirationDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebVerificationImpl extends _WebVerification {
  const _$WebVerificationImpl(
      {required this.verificationCode, required this.expirationDateTime})
      : super._();

  factory _$WebVerificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebVerificationImplFromJson(json);

  @override
  final String verificationCode;
  @override
  final DateTime expirationDateTime;

  @override
  String toString() {
    return 'WebVerification(verificationCode: $verificationCode, expirationDateTime: $expirationDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebVerificationImpl &&
            (identical(other.verificationCode, verificationCode) ||
                other.verificationCode == verificationCode) &&
            (identical(other.expirationDateTime, expirationDateTime) ||
                other.expirationDateTime == expirationDateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, verificationCode, expirationDateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebVerificationImplCopyWith<_$WebVerificationImpl> get copyWith =>
      __$$WebVerificationImplCopyWithImpl<_$WebVerificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebVerificationImplToJson(
      this,
    );
  }
}

abstract class _WebVerification extends WebVerification {
  const factory _WebVerification(
      {required final String verificationCode,
      required final DateTime expirationDateTime}) = _$WebVerificationImpl;
  const _WebVerification._() : super._();

  factory _WebVerification.fromJson(Map<String, dynamic> json) =
      _$WebVerificationImpl.fromJson;

  @override
  String get verificationCode;
  @override
  DateTime get expirationDateTime;
  @override
  @JsonKey(ignore: true)
  _$$WebVerificationImplCopyWith<_$WebVerificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

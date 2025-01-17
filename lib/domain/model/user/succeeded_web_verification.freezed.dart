// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'succeeded_web_verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SucceededWebVerification _$SucceededWebVerificationFromJson(
    Map<String, dynamic> json) {
  return _SucceededWebVerification.fromJson(json);
}

/// @nodoc
mixin _$SucceededWebVerification {
  WebVerificationStatus get status => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SucceededWebVerificationCopyWith<SucceededWebVerification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SucceededWebVerificationCopyWith<$Res> {
  factory $SucceededWebVerificationCopyWith(SucceededWebVerification value,
          $Res Function(SucceededWebVerification) then) =
      _$SucceededWebVerificationCopyWithImpl<$Res, SucceededWebVerification>;
  @useResult
  $Res call({WebVerificationStatus status, String? token, User? user});
}

/// @nodoc
class _$SucceededWebVerificationCopyWithImpl<$Res,
        $Val extends SucceededWebVerification>
    implements $SucceededWebVerificationCopyWith<$Res> {
  _$SucceededWebVerificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? token = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WebVerificationStatus,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SucceededWebVerificationImplCopyWith<$Res>
    implements $SucceededWebVerificationCopyWith<$Res> {
  factory _$$SucceededWebVerificationImplCopyWith(
          _$SucceededWebVerificationImpl value,
          $Res Function(_$SucceededWebVerificationImpl) then) =
      __$$SucceededWebVerificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WebVerificationStatus status, String? token, User? user});
}

/// @nodoc
class __$$SucceededWebVerificationImplCopyWithImpl<$Res>
    extends _$SucceededWebVerificationCopyWithImpl<$Res,
        _$SucceededWebVerificationImpl>
    implements _$$SucceededWebVerificationImplCopyWith<$Res> {
  __$$SucceededWebVerificationImplCopyWithImpl(
      _$SucceededWebVerificationImpl _value,
      $Res Function(_$SucceededWebVerificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? token = freezed,
    Object? user = freezed,
  }) {
    return _then(_$SucceededWebVerificationImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WebVerificationStatus,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SucceededWebVerificationImpl implements _SucceededWebVerification {
  const _$SucceededWebVerificationImpl(
      {required this.status, this.token, this.user});

  factory _$SucceededWebVerificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SucceededWebVerificationImplFromJson(json);

  @override
  final WebVerificationStatus status;
  @override
  final String? token;
  @override
  final User? user;

  @override
  String toString() {
    return 'SucceededWebVerification(status: $status, token: $token, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SucceededWebVerificationImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, token, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SucceededWebVerificationImplCopyWith<_$SucceededWebVerificationImpl>
      get copyWith => __$$SucceededWebVerificationImplCopyWithImpl<
          _$SucceededWebVerificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SucceededWebVerificationImplToJson(
      this,
    );
  }
}

abstract class _SucceededWebVerification implements SucceededWebVerification {
  const factory _SucceededWebVerification(
      {required final WebVerificationStatus status,
      final String? token,
      final User? user}) = _$SucceededWebVerificationImpl;

  factory _SucceededWebVerification.fromJson(Map<String, dynamic> json) =
      _$SucceededWebVerificationImpl.fromJson;

  @override
  WebVerificationStatus get status;
  @override
  String? get token;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$SucceededWebVerificationImplCopyWith<_$SucceededWebVerificationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

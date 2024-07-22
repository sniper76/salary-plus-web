// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_proxy_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DigitalProxyResult {
  int get templateId => throw _privateConstructorUsedError;
  String get templateName => throw _privateConstructorUsedError;
  String get templateRole => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime get endedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DigitalProxyResultCopyWith<DigitalProxyResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalProxyResultCopyWith<$Res> {
  factory $DigitalProxyResultCopyWith(
          DigitalProxyResult value, $Res Function(DigitalProxyResult) then) =
      _$DigitalProxyResultCopyWithImpl<$Res, DigitalProxyResult>;
  @useResult
  $Res call(
      {int templateId,
      String templateName,
      String templateRole,
      DateTime startedAt,
      DateTime endedAt});
}

/// @nodoc
class _$DigitalProxyResultCopyWithImpl<$Res, $Val extends DigitalProxyResult>
    implements $DigitalProxyResultCopyWith<$Res> {
  _$DigitalProxyResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? templateName = null,
    Object? templateRole = null,
    Object? startedAt = null,
    Object? endedAt = null,
  }) {
    return _then(_value.copyWith(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int,
      templateName: null == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateRole: null == templateRole
          ? _value.templateRole
          : templateRole // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: null == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalProxyResultImplCopyWith<$Res>
    implements $DigitalProxyResultCopyWith<$Res> {
  factory _$$DigitalProxyResultImplCopyWith(_$DigitalProxyResultImpl value,
          $Res Function(_$DigitalProxyResultImpl) then) =
      __$$DigitalProxyResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int templateId,
      String templateName,
      String templateRole,
      DateTime startedAt,
      DateTime endedAt});
}

/// @nodoc
class __$$DigitalProxyResultImplCopyWithImpl<$Res>
    extends _$DigitalProxyResultCopyWithImpl<$Res, _$DigitalProxyResultImpl>
    implements _$$DigitalProxyResultImplCopyWith<$Res> {
  __$$DigitalProxyResultImplCopyWithImpl(_$DigitalProxyResultImpl _value,
      $Res Function(_$DigitalProxyResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? templateName = null,
    Object? templateRole = null,
    Object? startedAt = null,
    Object? endedAt = null,
  }) {
    return _then(_$DigitalProxyResultImpl(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int,
      templateName: null == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateRole: null == templateRole
          ? _value.templateRole
          : templateRole // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: null == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DigitalProxyResultImpl extends _DigitalProxyResult {
  const _$DigitalProxyResultImpl(
      {required this.templateId,
      required this.templateName,
      required this.templateRole,
      required this.startedAt,
      required this.endedAt})
      : super._();

  @override
  final int templateId;
  @override
  final String templateName;
  @override
  final String templateRole;
  @override
  final DateTime startedAt;
  @override
  final DateTime endedAt;

  @override
  String toString() {
    return 'DigitalProxyResult(templateId: $templateId, templateName: $templateName, templateRole: $templateRole, startedAt: $startedAt, endedAt: $endedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalProxyResultImpl &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.templateRole, templateRole) ||
                other.templateRole == templateRole) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, templateId, templateName, templateRole, startedAt, endedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalProxyResultImplCopyWith<_$DigitalProxyResultImpl> get copyWith =>
      __$$DigitalProxyResultImplCopyWithImpl<_$DigitalProxyResultImpl>(
          this, _$identity);
}

abstract class _DigitalProxyResult extends DigitalProxyResult {
  const factory _DigitalProxyResult(
      {required final int templateId,
      required final String templateName,
      required final String templateRole,
      required final DateTime startedAt,
      required final DateTime endedAt}) = _$DigitalProxyResultImpl;
  const _DigitalProxyResult._() : super._();

  @override
  int get templateId;
  @override
  String get templateName;
  @override
  String get templateRole;
  @override
  DateTime get startedAt;
  @override
  DateTime get endedAt;
  @override
  @JsonKey(ignore: true)
  _$$DigitalProxyResultImplCopyWith<_$DigitalProxyResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

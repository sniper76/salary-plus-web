// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solidarity_leader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolidarityLeader _$SolidarityLeaderFromJson(Map<String, dynamic> json) {
  return _SolidarityLeader.fromJson(json);
}

/// @nodoc
mixin _$SolidarityLeader {
  @JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
  SolidarityLeaderStatusType get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool? get applied => throw _privateConstructorUsedError;
  int? get solidarityId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SolidarityLeaderCopyWith<SolidarityLeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolidarityLeaderCopyWith<$Res> {
  factory $SolidarityLeaderCopyWith(
          SolidarityLeader value, $Res Function(SolidarityLeader) then) =
      _$SolidarityLeaderCopyWithImpl<$Res, SolidarityLeader>;
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
      SolidarityLeaderStatusType status,
      String? message,
      bool? applied,
      int? solidarityId});
}

/// @nodoc
class _$SolidarityLeaderCopyWithImpl<$Res, $Val extends SolidarityLeader>
    implements $SolidarityLeaderCopyWith<$Res> {
  _$SolidarityLeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? applied = freezed,
    Object? solidarityId = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SolidarityLeaderStatusType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      applied: freezed == applied
          ? _value.applied
          : applied // ignore: cast_nullable_to_non_nullable
              as bool?,
      solidarityId: freezed == solidarityId
          ? _value.solidarityId
          : solidarityId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolidarityLeaderImplCopyWith<$Res>
    implements $SolidarityLeaderCopyWith<$Res> {
  factory _$$SolidarityLeaderImplCopyWith(_$SolidarityLeaderImpl value,
          $Res Function(_$SolidarityLeaderImpl) then) =
      __$$SolidarityLeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
      SolidarityLeaderStatusType status,
      String? message,
      bool? applied,
      int? solidarityId});
}

/// @nodoc
class __$$SolidarityLeaderImplCopyWithImpl<$Res>
    extends _$SolidarityLeaderCopyWithImpl<$Res, _$SolidarityLeaderImpl>
    implements _$$SolidarityLeaderImplCopyWith<$Res> {
  __$$SolidarityLeaderImplCopyWithImpl(_$SolidarityLeaderImpl _value,
      $Res Function(_$SolidarityLeaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? applied = freezed,
    Object? solidarityId = freezed,
  }) {
    return _then(_$SolidarityLeaderImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SolidarityLeaderStatusType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      applied: freezed == applied
          ? _value.applied
          : applied // ignore: cast_nullable_to_non_nullable
              as bool?,
      solidarityId: freezed == solidarityId
          ? _value.solidarityId
          : solidarityId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolidarityLeaderImpl extends _SolidarityLeader {
  const _$SolidarityLeaderImpl(
      {@JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
      required this.status,
      this.message,
      this.applied,
      this.solidarityId})
      : super._();

  factory _$SolidarityLeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolidarityLeaderImplFromJson(json);

  @override
  @JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
  final SolidarityLeaderStatusType status;
  @override
  final String? message;
  @override
  final bool? applied;
  @override
  final int? solidarityId;

  @override
  String toString() {
    return 'SolidarityLeader(status: $status, message: $message, applied: $applied, solidarityId: $solidarityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolidarityLeaderImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.applied, applied) || other.applied == applied) &&
            (identical(other.solidarityId, solidarityId) ||
                other.solidarityId == solidarityId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, message, applied, solidarityId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SolidarityLeaderImplCopyWith<_$SolidarityLeaderImpl> get copyWith =>
      __$$SolidarityLeaderImplCopyWithImpl<_$SolidarityLeaderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolidarityLeaderImplToJson(
      this,
    );
  }
}

abstract class _SolidarityLeader extends SolidarityLeader {
  const factory _SolidarityLeader(
      {@JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
      required final SolidarityLeaderStatusType status,
      final String? message,
      final bool? applied,
      final int? solidarityId}) = _$SolidarityLeaderImpl;
  const _SolidarityLeader._() : super._();

  factory _SolidarityLeader.fromJson(Map<String, dynamic> json) =
      _$SolidarityLeaderImpl.fromJson;

  @override
  @JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown)
  SolidarityLeaderStatusType get status;
  @override
  String? get message;
  @override
  bool? get applied;
  @override
  int? get solidarityId;
  @override
  @JsonKey(ignore: true)
  _$$SolidarityLeaderImplCopyWith<_$SolidarityLeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

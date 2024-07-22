// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leader_election_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaderElectionDetail _$LeaderElectionDetailFromJson(Map<String, dynamic> json) {
  return _LeaderElectionDetail.fromJson(json);
}

/// @nodoc
mixin _$LeaderElectionDetail {
  int get solidarityLeaderElectionId => throw _privateConstructorUsedError;
  ElectionStatus get electionStatus => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderElectionDetailCopyWith<LeaderElectionDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderElectionDetailCopyWith<$Res> {
  factory $LeaderElectionDetailCopyWith(LeaderElectionDetail value,
          $Res Function(LeaderElectionDetail) then) =
      _$LeaderElectionDetailCopyWithImpl<$Res, LeaderElectionDetail>;
  @useResult
  $Res call(
      {int solidarityLeaderElectionId,
      ElectionStatus electionStatus,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class _$LeaderElectionDetailCopyWithImpl<$Res,
        $Val extends LeaderElectionDetail>
    implements $LeaderElectionDetailCopyWith<$Res> {
  _$LeaderElectionDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solidarityLeaderElectionId = null,
    Object? electionStatus = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      solidarityLeaderElectionId: null == solidarityLeaderElectionId
          ? _value.solidarityLeaderElectionId
          : solidarityLeaderElectionId // ignore: cast_nullable_to_non_nullable
              as int,
      electionStatus: null == electionStatus
          ? _value.electionStatus
          : electionStatus // ignore: cast_nullable_to_non_nullable
              as ElectionStatus,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderElectionDetailImplCopyWith<$Res>
    implements $LeaderElectionDetailCopyWith<$Res> {
  factory _$$LeaderElectionDetailImplCopyWith(_$LeaderElectionDetailImpl value,
          $Res Function(_$LeaderElectionDetailImpl) then) =
      __$$LeaderElectionDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int solidarityLeaderElectionId,
      ElectionStatus electionStatus,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$$LeaderElectionDetailImplCopyWithImpl<$Res>
    extends _$LeaderElectionDetailCopyWithImpl<$Res, _$LeaderElectionDetailImpl>
    implements _$$LeaderElectionDetailImplCopyWith<$Res> {
  __$$LeaderElectionDetailImplCopyWithImpl(_$LeaderElectionDetailImpl _value,
      $Res Function(_$LeaderElectionDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solidarityLeaderElectionId = null,
    Object? electionStatus = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$LeaderElectionDetailImpl(
      solidarityLeaderElectionId: null == solidarityLeaderElectionId
          ? _value.solidarityLeaderElectionId
          : solidarityLeaderElectionId // ignore: cast_nullable_to_non_nullable
              as int,
      electionStatus: null == electionStatus
          ? _value.electionStatus
          : electionStatus // ignore: cast_nullable_to_non_nullable
              as ElectionStatus,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderElectionDetailImpl extends _LeaderElectionDetail {
  const _$LeaderElectionDetailImpl(
      {required this.solidarityLeaderElectionId,
      required this.electionStatus,
      required this.startDate,
      required this.endDate})
      : super._();

  factory _$LeaderElectionDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderElectionDetailImplFromJson(json);

  @override
  final int solidarityLeaderElectionId;
  @override
  final ElectionStatus electionStatus;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'LeaderElectionDetail(solidarityLeaderElectionId: $solidarityLeaderElectionId, electionStatus: $electionStatus, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderElectionDetailImpl &&
            (identical(other.solidarityLeaderElectionId,
                    solidarityLeaderElectionId) ||
                other.solidarityLeaderElectionId ==
                    solidarityLeaderElectionId) &&
            (identical(other.electionStatus, electionStatus) ||
                other.electionStatus == electionStatus) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, solidarityLeaderElectionId,
      electionStatus, startDate, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderElectionDetailImplCopyWith<_$LeaderElectionDetailImpl>
      get copyWith =>
          __$$LeaderElectionDetailImplCopyWithImpl<_$LeaderElectionDetailImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderElectionDetailImplToJson(
      this,
    );
  }
}

abstract class _LeaderElectionDetail extends LeaderElectionDetail {
  const factory _LeaderElectionDetail(
      {required final int solidarityLeaderElectionId,
      required final ElectionStatus electionStatus,
      required final DateTime startDate,
      required final DateTime endDate}) = _$LeaderElectionDetailImpl;
  const _LeaderElectionDetail._() : super._();

  factory _LeaderElectionDetail.fromJson(Map<String, dynamic> json) =
      _$LeaderElectionDetailImpl.fromJson;

  @override
  int get solidarityLeaderElectionId;
  @override
  ElectionStatus get electionStatus;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  @JsonKey(ignore: true)
  _$$LeaderElectionDetailImplCopyWith<_$LeaderElectionDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

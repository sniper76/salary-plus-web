// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_home.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockHome _$StockHomeFromJson(Map<String, dynamic> json) {
  return _StockHome.fromJson(json);
}

/// @nodoc
mixin _$StockHome {
  List<Section> get sections => throw _privateConstructorUsedError;
  Dashboard? get dashboard => throw _privateConstructorUsedError;
  SolidarityLeader? get leader => throw _privateConstructorUsedError;
  List<StockHomeNotice>? get notices => throw _privateConstructorUsedError;
  LeaderElectionDetail? get leaderElectionDetail =>
      throw _privateConstructorUsedError;
  Stock? get stock => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StockHomeCopyWith<StockHome> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockHomeCopyWith<$Res> {
  factory $StockHomeCopyWith(StockHome value, $Res Function(StockHome) then) =
      _$StockHomeCopyWithImpl<$Res, StockHome>;
  @useResult
  $Res call(
      {List<Section> sections,
      Dashboard? dashboard,
      SolidarityLeader? leader,
      List<StockHomeNotice>? notices,
      LeaderElectionDetail? leaderElectionDetail,
      Stock? stock});

  $DashboardCopyWith<$Res>? get dashboard;
  $SolidarityLeaderCopyWith<$Res>? get leader;
  $LeaderElectionDetailCopyWith<$Res>? get leaderElectionDetail;
  $StockCopyWith<$Res>? get stock;
}

/// @nodoc
class _$StockHomeCopyWithImpl<$Res, $Val extends StockHome>
    implements $StockHomeCopyWith<$Res> {
  _$StockHomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? dashboard = freezed,
    Object? leader = freezed,
    Object? notices = freezed,
    Object? leaderElectionDetail = freezed,
    Object? stock = freezed,
  }) {
    return _then(_value.copyWith(
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
      dashboard: freezed == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Dashboard?,
      leader: freezed == leader
          ? _value.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as SolidarityLeader?,
      notices: freezed == notices
          ? _value.notices
          : notices // ignore: cast_nullable_to_non_nullable
              as List<StockHomeNotice>?,
      leaderElectionDetail: freezed == leaderElectionDetail
          ? _value.leaderElectionDetail
          : leaderElectionDetail // ignore: cast_nullable_to_non_nullable
              as LeaderElectionDetail?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as Stock?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardCopyWith<$Res>? get dashboard {
    if (_value.dashboard == null) {
      return null;
    }

    return $DashboardCopyWith<$Res>(_value.dashboard!, (value) {
      return _then(_value.copyWith(dashboard: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SolidarityLeaderCopyWith<$Res>? get leader {
    if (_value.leader == null) {
      return null;
    }

    return $SolidarityLeaderCopyWith<$Res>(_value.leader!, (value) {
      return _then(_value.copyWith(leader: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaderElectionDetailCopyWith<$Res>? get leaderElectionDetail {
    if (_value.leaderElectionDetail == null) {
      return null;
    }

    return $LeaderElectionDetailCopyWith<$Res>(_value.leaderElectionDetail!,
        (value) {
      return _then(_value.copyWith(leaderElectionDetail: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StockCopyWith<$Res>? get stock {
    if (_value.stock == null) {
      return null;
    }

    return $StockCopyWith<$Res>(_value.stock!, (value) {
      return _then(_value.copyWith(stock: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StockHomeImplCopyWith<$Res>
    implements $StockHomeCopyWith<$Res> {
  factory _$$StockHomeImplCopyWith(
          _$StockHomeImpl value, $Res Function(_$StockHomeImpl) then) =
      __$$StockHomeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Section> sections,
      Dashboard? dashboard,
      SolidarityLeader? leader,
      List<StockHomeNotice>? notices,
      LeaderElectionDetail? leaderElectionDetail,
      Stock? stock});

  @override
  $DashboardCopyWith<$Res>? get dashboard;
  @override
  $SolidarityLeaderCopyWith<$Res>? get leader;
  @override
  $LeaderElectionDetailCopyWith<$Res>? get leaderElectionDetail;
  @override
  $StockCopyWith<$Res>? get stock;
}

/// @nodoc
class __$$StockHomeImplCopyWithImpl<$Res>
    extends _$StockHomeCopyWithImpl<$Res, _$StockHomeImpl>
    implements _$$StockHomeImplCopyWith<$Res> {
  __$$StockHomeImplCopyWithImpl(
      _$StockHomeImpl _value, $Res Function(_$StockHomeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? dashboard = freezed,
    Object? leader = freezed,
    Object? notices = freezed,
    Object? leaderElectionDetail = freezed,
    Object? stock = freezed,
  }) {
    return _then(_$StockHomeImpl(
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
      dashboard: freezed == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Dashboard?,
      leader: freezed == leader
          ? _value.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as SolidarityLeader?,
      notices: freezed == notices
          ? _value._notices
          : notices // ignore: cast_nullable_to_non_nullable
              as List<StockHomeNotice>?,
      leaderElectionDetail: freezed == leaderElectionDetail
          ? _value.leaderElectionDetail
          : leaderElectionDetail // ignore: cast_nullable_to_non_nullable
              as LeaderElectionDetail?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as Stock?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockHomeImpl implements _StockHome {
  const _$StockHomeImpl(
      {required final List<Section> sections,
      this.dashboard,
      this.leader,
      final List<StockHomeNotice>? notices,
      this.leaderElectionDetail,
      this.stock})
      : _sections = sections,
        _notices = notices;

  factory _$StockHomeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockHomeImplFromJson(json);

  final List<Section> _sections;
  @override
  List<Section> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  final Dashboard? dashboard;
  @override
  final SolidarityLeader? leader;
  final List<StockHomeNotice>? _notices;
  @override
  List<StockHomeNotice>? get notices {
    final value = _notices;
    if (value == null) return null;
    if (_notices is EqualUnmodifiableListView) return _notices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final LeaderElectionDetail? leaderElectionDetail;
  @override
  final Stock? stock;

  @override
  String toString() {
    return 'StockHome(sections: $sections, dashboard: $dashboard, leader: $leader, notices: $notices, leaderElectionDetail: $leaderElectionDetail, stock: $stock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockHomeImpl &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.dashboard, dashboard) ||
                other.dashboard == dashboard) &&
            (identical(other.leader, leader) || other.leader == leader) &&
            const DeepCollectionEquality().equals(other._notices, _notices) &&
            (identical(other.leaderElectionDetail, leaderElectionDetail) ||
                other.leaderElectionDetail == leaderElectionDetail) &&
            (identical(other.stock, stock) || other.stock == stock));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sections),
      dashboard,
      leader,
      const DeepCollectionEquality().hash(_notices),
      leaderElectionDetail,
      stock);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StockHomeImplCopyWith<_$StockHomeImpl> get copyWith =>
      __$$StockHomeImplCopyWithImpl<_$StockHomeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockHomeImplToJson(
      this,
    );
  }
}

abstract class _StockHome implements StockHome {
  const factory _StockHome(
      {required final List<Section> sections,
      final Dashboard? dashboard,
      final SolidarityLeader? leader,
      final List<StockHomeNotice>? notices,
      final LeaderElectionDetail? leaderElectionDetail,
      final Stock? stock}) = _$StockHomeImpl;

  factory _StockHome.fromJson(Map<String, dynamic> json) =
      _$StockHomeImpl.fromJson;

  @override
  List<Section> get sections;
  @override
  Dashboard? get dashboard;
  @override
  SolidarityLeader? get leader;
  @override
  List<StockHomeNotice>? get notices;
  @override
  LeaderElectionDetail? get leaderElectionDetail;
  @override
  Stock? get stock;
  @override
  @JsonKey(ignore: true)
  _$$StockHomeImplCopyWith<_$StockHomeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

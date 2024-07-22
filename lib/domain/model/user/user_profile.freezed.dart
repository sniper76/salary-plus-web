// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get nickname => throw _privateConstructorUsedError;
  bool get isSolidarityLeader => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get individualStockCountLabel => throw _privateConstructorUsedError;
  String? get totalAssetLabel => throw _privateConstructorUsedError;
  List<LeadingStock>? get leadingStocks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String nickname,
      bool isSolidarityLeader,
      String? profileImageUrl,
      String? individualStockCountLabel,
      String? totalAssetLabel,
      List<LeadingStock>? leadingStocks});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? isSolidarityLeader = null,
    Object? profileImageUrl = freezed,
    Object? individualStockCountLabel = freezed,
    Object? totalAssetLabel = freezed,
    Object? leadingStocks = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      isSolidarityLeader: null == isSolidarityLeader
          ? _value.isSolidarityLeader
          : isSolidarityLeader // ignore: cast_nullable_to_non_nullable
              as bool,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      individualStockCountLabel: freezed == individualStockCountLabel
          ? _value.individualStockCountLabel
          : individualStockCountLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAssetLabel: freezed == totalAssetLabel
          ? _value.totalAssetLabel
          : totalAssetLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      leadingStocks: freezed == leadingStocks
          ? _value.leadingStocks
          : leadingStocks // ignore: cast_nullable_to_non_nullable
              as List<LeadingStock>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nickname,
      bool isSolidarityLeader,
      String? profileImageUrl,
      String? individualStockCountLabel,
      String? totalAssetLabel,
      List<LeadingStock>? leadingStocks});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? isSolidarityLeader = null,
    Object? profileImageUrl = freezed,
    Object? individualStockCountLabel = freezed,
    Object? totalAssetLabel = freezed,
    Object? leadingStocks = freezed,
  }) {
    return _then(_$UserProfileImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      isSolidarityLeader: null == isSolidarityLeader
          ? _value.isSolidarityLeader
          : isSolidarityLeader // ignore: cast_nullable_to_non_nullable
              as bool,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      individualStockCountLabel: freezed == individualStockCountLabel
          ? _value.individualStockCountLabel
          : individualStockCountLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAssetLabel: freezed == totalAssetLabel
          ? _value.totalAssetLabel
          : totalAssetLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      leadingStocks: freezed == leadingStocks
          ? _value._leadingStocks
          : leadingStocks // ignore: cast_nullable_to_non_nullable
              as List<LeadingStock>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl extends _UserProfile {
  const _$UserProfileImpl(
      {required this.nickname,
      required this.isSolidarityLeader,
      this.profileImageUrl,
      this.individualStockCountLabel,
      this.totalAssetLabel,
      final List<LeadingStock>? leadingStocks})
      : _leadingStocks = leadingStocks,
        super._();

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String nickname;
  @override
  final bool isSolidarityLeader;
  @override
  final String? profileImageUrl;
  @override
  final String? individualStockCountLabel;
  @override
  final String? totalAssetLabel;
  final List<LeadingStock>? _leadingStocks;
  @override
  List<LeadingStock>? get leadingStocks {
    final value = _leadingStocks;
    if (value == null) return null;
    if (_leadingStocks is EqualUnmodifiableListView) return _leadingStocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserProfile(nickname: $nickname, isSolidarityLeader: $isSolidarityLeader, profileImageUrl: $profileImageUrl, individualStockCountLabel: $individualStockCountLabel, totalAssetLabel: $totalAssetLabel, leadingStocks: $leadingStocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.isSolidarityLeader, isSolidarityLeader) ||
                other.isSolidarityLeader == isSolidarityLeader) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.individualStockCountLabel,
                    individualStockCountLabel) ||
                other.individualStockCountLabel == individualStockCountLabel) &&
            (identical(other.totalAssetLabel, totalAssetLabel) ||
                other.totalAssetLabel == totalAssetLabel) &&
            const DeepCollectionEquality()
                .equals(other._leadingStocks, _leadingStocks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nickname,
      isSolidarityLeader,
      profileImageUrl,
      individualStockCountLabel,
      totalAssetLabel,
      const DeepCollectionEquality().hash(_leadingStocks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile extends UserProfile {
  const factory _UserProfile(
      {required final String nickname,
      required final bool isSolidarityLeader,
      final String? profileImageUrl,
      final String? individualStockCountLabel,
      final String? totalAssetLabel,
      final List<LeadingStock>? leadingStocks}) = _$UserProfileImpl;
  const _UserProfile._() : super._();

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get nickname;
  @override
  bool get isSolidarityLeader;
  @override
  String? get profileImageUrl;
  @override
  String? get individualStockCountLabel;
  @override
  String? get totalAssetLabel;
  @override
  List<LeadingStock>? get leadingStocks;
  @override
  @JsonKey(ignore: true)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

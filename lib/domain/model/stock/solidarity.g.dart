// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidarity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolidarityImpl _$$SolidarityImplFromJson(Map<String, dynamic> json) =>
    _$SolidarityImpl(
      name: json['name'] as String,
      code: json['code'] as String,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      requiredMemberCount: (json['requiredMemberCount'] as num?)?.toInt() ?? 0,
      minThresholdMemberCount:
          (json['minThresholdMemberCount'] as num?)?.toInt() ?? 50,
      stake: (json['stake'] as num?)?.toDouble() ?? 0.0,
      stakeRankDelta: (json['stakeRankDelta'] as num?)?.toInt() ?? 0,
      status:
          $enumDecodeNullable(_$SolidarityStatusTypeEnumMap, json['status']) ??
              SolidarityStatusType.unknown,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      representativePhoneNumber: json['representativePhoneNumber'] as String?,
      stakeRank: json['stakeRank'] as String?,
    );

Map<String, dynamic> _$$SolidarityImplToJson(_$SolidarityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'memberCount': instance.memberCount,
      'requiredMemberCount': instance.requiredMemberCount,
      'minThresholdMemberCount': instance.minThresholdMemberCount,
      'stake': instance.stake,
      'stakeRankDelta': instance.stakeRankDelta,
      'status': _$SolidarityStatusTypeEnumMap[instance.status]!,
      'links': instance.links,
      'representativePhoneNumber': instance.representativePhoneNumber,
      'stakeRank': instance.stakeRank,
    };

const _$SolidarityStatusTypeEnumMap = {
  SolidarityStatusType.active: 'ACTIVE',
  SolidarityStatusType.inactiveByAdmin: 'INACTIVE_BY_ADMIN',
  SolidarityStatusType.unknown: 'UNKNOWN',
};

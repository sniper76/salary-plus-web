// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidarity_leader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolidarityLeaderImpl _$$SolidarityLeaderImplFromJson(
        Map<String, dynamic> json) =>
    _$SolidarityLeaderImpl(
      status: $enumDecode(_$SolidarityLeaderStatusTypeEnumMap, json['status'],
          unknownValue: SolidarityLeaderStatusType.unknown),
      message: json['message'] as String?,
      applied: json['applied'] as bool?,
      solidarityId: (json['solidarityId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SolidarityLeaderImplToJson(
        _$SolidarityLeaderImpl instance) =>
    <String, dynamic>{
      'status': _$SolidarityLeaderStatusTypeEnumMap[instance.status]!,
      'message': instance.message,
      'applied': instance.applied,
      'solidarityId': instance.solidarityId,
    };

const _$SolidarityLeaderStatusTypeEnumMap = {
  SolidarityLeaderStatusType.elected: 'Elected',
  SolidarityLeaderStatusType.progress: 'Election in progress',
  SolidarityLeaderStatusType.unknown: 'UNKNOWN',
};

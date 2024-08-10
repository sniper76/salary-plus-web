// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidarity_leader_applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidarityLeaderApplicant _$SolidarityLeaderApplicantFromJson(
        Map<String, dynamic> json) =>
    SolidarityLeaderApplicant(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String?,
      name: json['name'] as String,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String?,
      nickname: json['nickname'] as String?,
      status: $enumDecodeNullable(_$UserStatusTypeEnumMap, json['status'],
              unknownValue: UserStatusType.unknown) ??
          UserStatusType.unknown,
      solidarityApplicantId: (json['solidarityApplicantId'] as num).toInt(),
    );

Map<String, dynamic> _$SolidarityLeaderApplicantToJson(
        SolidarityLeaderApplicant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'status': _$UserStatusTypeEnumMap[instance.status]!,
      'solidarityApplicantId': instance.solidarityApplicantId,
    };

const _$UserStatusTypeEnumMap = {
  UserStatusType.active: 'ACTIVE',
  UserStatusType.processing: 'PROCESSING',
  UserStatusType.inactive_by_user: 'INACTIVE_BY_USER',
  UserStatusType.inactive_by_admin: 'INACTIVE_BY_ADMIN',
  UserStatusType.deleted_by_admin: 'DELETED_BY_ADMIN',
  UserStatusType.unknown: 'UNKNOWN',
};

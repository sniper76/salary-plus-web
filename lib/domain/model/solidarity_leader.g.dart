// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidarity_leader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidarityLeader _$SolidarityLeaderFromJson(Map<String, dynamic> json) =>
    SolidarityLeader(
      userId: (json['userId'] as num).toInt(),
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
      message: json['message'] as String?,
      corporateNo: json['corporateNo'] as String?,
      solidarityId: (json['solidarityId'] as num).toInt(),
      solidarityLeaderId: (json['solidarityLeaderId'] as num).toInt(),
    );

Map<String, dynamic> _$SolidarityLeaderToJson(SolidarityLeader instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'status': _$UserStatusTypeEnumMap[instance.status]!,
      'message': instance.message,
      'solidarityId': instance.solidarityId,
      'solidarityLeaderId': instance.solidarityLeaderId,
      'userId': instance.userId,
      'corporateNo': instance.corporateNo,
    };

const _$UserStatusTypeEnumMap = {
  UserStatusType.active: 'ACTIVE',
  UserStatusType.processing: 'PROCESSING',
  UserStatusType.inactive_by_user: 'INACTIVE_BY_USER',
  UserStatusType.inactive_by_admin: 'INACTIVE_BY_ADMIN',
  UserStatusType.deleted_by_admin: 'DELETED_BY_ADMIN',
  UserStatusType.unknown: 'UNKNOWN',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      gender: json['gender'] as String,
      phoneNumber: json['phoneNumber'] as String,
      totalAssetAmount: (json['totalAssetAmount'] as num?)?.toInt() ?? 0,
      isAgreeToReceiveMail: json['isAgreeToReceiveMail'] as bool? ?? false,
      isAdmin: json['isAdmin'] as bool? ?? false,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      address: json['address'] as String?,
      addressDetail: json['addressDetail'] as String?,
      zipcode: json['zipcode'] as String?,
      jobTitle: json['jobTitle'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      lastPinNumberVerifiedAt: json['lastPinNumberVerifiedAt'] == null
          ? null
          : DateTime.parse(json['lastPinNumberVerifiedAt'] as String),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$UserRoleEnumMap, e))
          .toList(),
      leadingSolidarityStockCodes:
          (json['leadingSolidarityStockCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      isPinNumberRegistered: json['isPinNumberRegistered'] as bool? ?? false,
      status: $enumDecodeNullable(_$UserStatusTypeEnumMap, json['status'],
              unknownValue: UserStatusType.unknown) ??
          UserStatusType.unknown,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      userBadgeVisibilities: (json['userBadgeVisibilities'] as List<dynamic>?)
              ?.map((e) => BadgeVisibility.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isSolidarityLeaderConfidentialAgreementSigned:
          json['isSolidarityLeaderConfidentialAgreementSigned'] as bool?,
      holdingStocks: (json['holdingStocks'] as List<dynamic>?)
          ?.map((e) => BaseStock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'totalAssetAmount': instance.totalAssetAmount,
      'isAgreeToReceiveMail': instance.isAgreeToReceiveMail,
      'isAdmin': instance.isAdmin,
      'birthDate': instance.birthDate?.toIso8601String(),
      'nickname': instance.nickname,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
      'zipcode': instance.zipcode,
      'jobTitle': instance.jobTitle,
      'profileImageUrl': instance.profileImageUrl,
      'lastPinNumberVerifiedAt':
          instance.lastPinNumberVerifiedAt?.toIso8601String(),
      'isPinNumberRegistered': instance.isPinNumberRegistered,
      'status': _$UserStatusTypeEnumMap[instance.status]!,
      'leadingSolidarityStockCodes': instance.leadingSolidarityStockCodes,
      'roles': instance.roles?.map((e) => _$UserRoleEnumMap[e]!).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'editedAt': instance.editedAt?.toIso8601String(),
      'userBadgeVisibilities': instance.userBadgeVisibilities,
      'isSolidarityLeaderConfidentialAgreementSigned':
          instance.isSolidarityLeaderConfidentialAgreementSigned,
      'holdingStocks': instance.holdingStocks,
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'SUPER_ADMIN',
  UserRole.admin: 'ADMIN',
  UserRole.user: 'USER',
  UserRole.acceptorUser: 'ACCEPTOR_USER',
};

const _$UserStatusTypeEnumMap = {
  UserStatusType.active: 'ACTIVE',
  UserStatusType.processing: 'PROCESSING',
  UserStatusType.inactiveByUser: 'INACTIVE_BY_USER',
  UserStatusType.inactiveByAdmin: 'INACTIVE_BY_ADMIN',
  UserStatusType.deletedByAdmin: 'DELETED_BY_ADMIN',
  UserStatusType.unknown: 'UNKNOWN',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'succeeded_web_verification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SucceededWebVerificationImpl _$$SucceededWebVerificationImplFromJson(
        Map<String, dynamic> json) =>
    _$SucceededWebVerificationImpl(
      status: $enumDecode(_$WebVerificationStatusEnumMap, json['status']),
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SucceededWebVerificationImplToJson(
        _$SucceededWebVerificationImpl instance) =>
    <String, dynamic>{
      'status': _$WebVerificationStatusEnumMap[instance.status]!,
      'token': instance.token,
      'user': instance.user,
    };

const _$WebVerificationStatusEnumMap = {
  WebVerificationStatus.verified: 'VERIFIED',
  WebVerificationStatus.expired: 'EXPIRED',
  WebVerificationStatus.waiting: 'WAITING',
};

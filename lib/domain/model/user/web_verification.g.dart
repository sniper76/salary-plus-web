// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_verification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebVerificationImpl _$$WebVerificationImplFromJson(
        Map<String, dynamic> json) =>
    _$WebVerificationImpl(
      verificationCode: json['verificationCode'] as String,
      expirationDateTime: DateTime.parse(json['expirationDateTime'] as String),
    );

Map<String, dynamic> _$$WebVerificationImplToJson(
        _$WebVerificationImpl instance) =>
    <String, dynamic>{
      'verificationCode': instance.verificationCode,
      'expirationDateTime': instance.expirationDateTime.toIso8601String(),
    };

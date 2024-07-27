// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAuth _$VerifyAuthFromJson(Map<String, dynamic> json) => VerifyAuth(
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyAuthToJson(VerifyAuth instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

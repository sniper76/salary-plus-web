// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DigitalDocumentUserImpl _$$DigitalDocumentUserImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalDocumentUserImpl(
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      gender: json['gender'] as String,
      phoneNumber: json['phoneNumber'] as String,
      zipcode: json['zipcode'] as String?,
      address: json['address'] as String?,
      addressDetail: json['addressDetail'] as String?,
    );

Map<String, dynamic> _$$DigitalDocumentUserImplToJson(
        _$DigitalDocumentUserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'zipcode': instance.zipcode,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
    };

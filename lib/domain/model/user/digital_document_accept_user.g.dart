// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_accept_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DigitalDocumentAcceptUserImpl _$$DigitalDocumentAcceptUserImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalDocumentAcceptUserImpl(
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
      corporateNo: json['corporateNo'] as String?,
    );

Map<String, dynamic> _$$DigitalDocumentAcceptUserImplToJson(
        _$DigitalDocumentAcceptUserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'corporateNo': instance.corporateNo,
    };

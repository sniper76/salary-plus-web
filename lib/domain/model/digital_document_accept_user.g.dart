// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_accept_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalDocumentAcceptUser _$DigitalDocumentAcceptUserFromJson(
        Map<String, dynamic> json) =>
    DigitalDocumentAcceptUser(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$DigitalDocumentAcceptUserToJson(
        DigitalDocumentAcceptUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'id': instance.id,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_attach_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DigitalDocumentAttachOptionsImpl _$$DigitalDocumentAttachOptionsImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalDocumentAttachOptionsImpl(
      signImage: $enumDecode(
          _$DigitalDocumentAttachOptionTypeEnumMap, json['signImage']),
      idCardImage: $enumDecode(
          _$DigitalDocumentAttachOptionTypeEnumMap, json['idCardImage']),
      bankAccountImage: $enumDecode(
          _$DigitalDocumentAttachOptionTypeEnumMap, json['bankAccountImage']),
      hectoEncryptedBankAccountPdf: $enumDecode(
          _$DigitalDocumentAttachOptionTypeEnumMap,
          json['hectoEncryptedBankAccountPdf']),
    );

Map<String, dynamic> _$$DigitalDocumentAttachOptionsImplToJson(
        _$DigitalDocumentAttachOptionsImpl instance) =>
    <String, dynamic>{
      'signImage':
          _$DigitalDocumentAttachOptionTypeEnumMap[instance.signImage]!,
      'idCardImage':
          _$DigitalDocumentAttachOptionTypeEnumMap[instance.idCardImage]!,
      'bankAccountImage':
          _$DigitalDocumentAttachOptionTypeEnumMap[instance.bankAccountImage]!,
      'hectoEncryptedBankAccountPdf': _$DigitalDocumentAttachOptionTypeEnumMap[
          instance.hectoEncryptedBankAccountPdf]!,
    };

const _$DigitalDocumentAttachOptionTypeEnumMap = {
  DigitalDocumentAttachOptionType.required: 'REQUIRED',
  DigitalDocumentAttachOptionType.optional: 'OPTIONAL',
  DigitalDocumentAttachOptionType.none: 'NONE',
};

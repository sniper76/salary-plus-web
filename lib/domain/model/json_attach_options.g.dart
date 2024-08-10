// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_attach_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAttachOptions _$JsonAttachOptionsFromJson(Map<String, dynamic> json) =>
    JsonAttachOptions(
      signImage: $enumDecode(_$OptionTypeEnumMap, json['signImage']),
      idCardImage: $enumDecode(_$OptionTypeEnumMap, json['idCardImage']),
      bankAccountImage:
          $enumDecode(_$OptionTypeEnumMap, json['bankAccountImage']),
      hectoEncryptedBankAccountPdf: $enumDecode(
          _$OptionTypeEnumMap, json['hectoEncryptedBankAccountPdf']),
    );

Map<String, dynamic> _$JsonAttachOptionsToJson(JsonAttachOptions instance) =>
    <String, dynamic>{
      'signImage': _$OptionTypeEnumMap[instance.signImage]!,
      'idCardImage': _$OptionTypeEnumMap[instance.idCardImage]!,
      'bankAccountImage': _$OptionTypeEnumMap[instance.bankAccountImage]!,
      'hectoEncryptedBankAccountPdf':
          _$OptionTypeEnumMap[instance.hectoEncryptedBankAccountPdf]!,
    };

const _$OptionTypeEnumMap = {
  OptionType.required: 'REQUIRED',
  OptionType.optional: 'OPTIONAL',
  OptionType.none: 'NONE',
};

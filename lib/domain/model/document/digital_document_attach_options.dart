import 'package:act_web/domain/enum/digital_document_attach_option_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_document_attach_options.freezed.dart';
part 'digital_document_attach_options.g.dart';

@freezed
class DigitalDocumentAttachOptions with _$DigitalDocumentAttachOptions {
  const factory DigitalDocumentAttachOptions({
    required DigitalDocumentAttachOptionType signImage,
    required DigitalDocumentAttachOptionType idCardImage,
    required DigitalDocumentAttachOptionType bankAccountImage,
    required DigitalDocumentAttachOptionType hectoEncryptedBankAccountPdf,
  }) = _DigitalDocumentAttachOptions;

  factory DigitalDocumentAttachOptions.fromJson(Map<String, dynamic> json) =>
      _$DigitalDocumentAttachOptionsFromJson(json);
}

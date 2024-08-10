import 'package:act_cms/domain/model/enum/option_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_attach_options.g.dart';

@JsonSerializable()
class JsonAttachOptions {
  final OptionType signImage;
  final OptionType idCardImage;
  final OptionType bankAccountImage;
  final OptionType hectoEncryptedBankAccountPdf;

  JsonAttachOptions({
    required this.signImage,
    required this.idCardImage,
    required this.bankAccountImage,
    required this.hectoEncryptedBankAccountPdf,
  });

  factory JsonAttachOptions.fromJson(Map<String, dynamic> json) => _$JsonAttachOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$JsonAttachOptionsToJson(this);
}

import 'package:act_cms/core/util/json_utils.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/enum/digital_document_version.dart';
import 'package:act_cms/domain/model/enum/id_card_watermark_type.dart';
import 'package:act_cms/domain/model/enum/stock_quantity_display_type.dart';
import 'package:act_cms/domain/model/json_attach_options.dart';
import 'package:json_annotation/json_annotation.dart';

part 'digital_document_admin.g.dart';

@JsonSerializable()
class DigitalDocumentAdmin {
  final String type;
  final String companyName;
  final int? acceptUserId;
  final int? stockReferenceDateId;
  @JsonKey(toJson: dateToJson)
  final DateTime? targetStartDate;
  @JsonKey(toJson: dateToJson)
  final DateTime? targetEndDate;
  final String? shareholderMeetingType;
  final String? shareholderMeetingName;
  @JsonKey(toJson: dateToJson)
  final DateTime? shareholderMeetingDate;
  final String? designatedAgentNames;
  final List<DigitalDocumentItem>? childItems;
  final String? companyRegistrationNumber;
  final String title;
  final String content;
  final bool isDisplayStockQuantity;
  final IdCardWatermarkType idCardWatermarkType;
  final JsonAttachOptions? attachOptions;
  final String? version;

  DigitalDocumentAdmin({
    required this.type,
    required this.companyName,
    required this.acceptUserId,
    required this.stockReferenceDateId,
    required this.targetStartDate,
    required this.targetEndDate,
    this.shareholderMeetingType,
    this.shareholderMeetingName,
    this.shareholderMeetingDate,
    this.designatedAgentNames,
    this.childItems,
    this.companyRegistrationNumber,
    required this.title,
    required this.content,
    required this.idCardWatermarkType,
    required this.isDisplayStockQuantity,
    this.attachOptions,
    this.version,
  });

  factory DigitalDocumentAdmin.fromJson(Map<String, dynamic> json) => _$DigitalDocumentAdminFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentAdminToJson(this);
}

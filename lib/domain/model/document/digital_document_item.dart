import 'package:act_web/domain/enum/digital_document_answer_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_document_item.freezed.dart';
part 'digital_document_item.g.dart';

@freezed
class DigitalDocumentItem with _$DigitalDocumentItem {
  const DigitalDocumentItem._();

  const factory DigitalDocumentItem({
    required int id,
    required String title,
    required String content,
    String? leaderDescription,
    DigitalDocumentAnswerType? defaultSelectValue,
    List<DigitalDocumentItem>? childItems,
  }) = _DigitalDocumentItem;

  factory DigitalDocumentItem.fromJson(Map<String, dynamic> json) => _$DigitalDocumentItemFromJson(json);
}

extension DigitalDocumentItemExtension on DigitalDocumentItem {
  String get subject => '[$title] $content';
  String get description => leaderDescription ?? '';
}

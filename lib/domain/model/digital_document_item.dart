import 'package:act_cms/core/util/json_utils.dart';
import 'package:act_cms/domain/model/enum/digital_document_answer_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'digital_document_item.g.dart';

@JsonSerializable()
class DigitalDocumentItem {
  int id;
  String title;
  String content;
  String? leaderDescription;
  @JsonKey(toJson: digitalDocumentAnswerTypeToJson)
  DigitalDocumentAnswerType? defaultSelectValue;
  List<DigitalDocumentItem>? childItems;

  DigitalDocumentItem({
    required this.id,
    required this.title,
    required this.content,
    this.leaderDescription,
    this.defaultSelectValue,
    this.childItems,
  });

  factory DigitalDocumentItem.fromJson(Map<String, dynamic> json) => _$DigitalDocumentItemFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentItemToJson(this);

  Map<String, dynamic> toCreateJson() {
    final data = {
      'title': title,
      'content': content,
      'leaderDescription': leaderDescription,
      'defaultSelectValue': defaultSelectValue?.value,
      'childItems': childItems,
    };
    return data;
  }
}

extension DigitalDocumentItemExtension on DigitalDocumentItem {
  String get subject => '[$title] $content';

  String get description => leaderDescription ?? '';
}

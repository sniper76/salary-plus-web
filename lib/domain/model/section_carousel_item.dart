import 'package:act_cms/domain/model/section_header.dart';
import 'package:act_cms/domain/model/section_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_carousel_item.g.dart';

@JsonSerializable()
class SectionCarouselItem {
  final SectionHeader header;
  final List<SectionItem> listItems;

  const SectionCarouselItem({
    required this.header,
    required this.listItems,
  });

  factory SectionCarouselItem.fromJson(Map<String, dynamic> json) => _$SectionCarouselItemFromJson(json);

  Map<String, dynamic> toJson() => _$SectionCarouselItemToJson(this);
}

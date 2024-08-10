import 'package:act_cms/domain/model/enum/section_type.dart';
import 'package:act_cms/domain/model/section_carousel_item.dart';
import 'package:act_cms/domain/model/section_header.dart';
import 'package:act_cms/domain/model/section_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable()
class Section {
  final SectionType type;
  final SectionHeader? header;
  final List<SectionCarouselItem>? carouselItems;
  final List<SectionItem>? listItems;

  const Section({
    required this.type,
    this.header,
    this.carouselItems,
    this.listItems,
  });

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}

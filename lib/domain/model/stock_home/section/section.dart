import 'package:act_web/domain/enum/section_type.dart';
import 'package:act_web/domain/model/stock_home/section/section_carousel_item.dart';
import 'package:act_web/domain/model/stock_home/section/section_header.dart';
import 'package:act_web/domain/model/stock_home/section/section_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@freezed
class Section with _$Section {
  const factory Section({
    required SectionType type,
    SectionHeader? header,
    List<SectionCarouselItem>? carouselItems,
    List<SectionItem>? listItems,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
}

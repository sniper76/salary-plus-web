import 'package:act_web/domain/model/stock_home/section/section_header.dart';
import 'package:act_web/domain/model/stock_home/section/section_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_carousel_item.freezed.dart';
part 'section_carousel_item.g.dart';

@freezed
class SectionCarouselItem with _$SectionCarouselItem {
  const factory SectionCarouselItem({
    required SectionHeader header,
    required List<SectionItem> listItems,
  }) = _SectionCarouselItem;

  factory SectionCarouselItem.fromJson(Map<String, dynamic> json) => _$SectionCarouselItemFromJson(json);
}

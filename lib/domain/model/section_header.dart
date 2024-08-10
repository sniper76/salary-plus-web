import 'package:json_annotation/json_annotation.dart';

part 'section_header.g.dart';

@JsonSerializable()
class SectionHeader {
  final String title;
  final String link;
  @JsonKey(name: 'image')
  final String? imageUrl;

  const SectionHeader({
    required this.title,
    required this.link,
    this.imageUrl,
  });

  factory SectionHeader.fromJson(Map<String, dynamic> json) => _$SectionHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$SectionHeaderToJson(this);
}

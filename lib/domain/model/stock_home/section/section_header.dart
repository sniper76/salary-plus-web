import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_header.freezed.dart';
part 'section_header.g.dart';

@freezed
class SectionHeader with _$SectionHeader {
  const factory SectionHeader({
    required String title,
    required String link,
    String? imageUrl,
  }) = _SectionHeader;

  factory SectionHeader.fromJson(Map<String, dynamic> json) => _$SectionHeaderFromJson(json);
}

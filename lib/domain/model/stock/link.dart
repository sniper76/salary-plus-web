import 'package:freezed_annotation/freezed_annotation.dart';

part 'link.g.dart';
part 'link.freezed.dart';

@freezed
class Link with _$Link {
  const factory Link({
    required String title,
    required String url,
    required String color,
  }) = _Link;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}

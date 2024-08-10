import 'package:json_annotation/json_annotation.dart';

enum NoticeCategoryType {
  @JsonValue('NOTICE')
  notice('NOTICE', '공지사항');

  const NoticeCategoryType(this.value, this.title);
  final String? value;
  final String title;
}

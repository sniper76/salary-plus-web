import 'package:act_cms/domain/model/enum/exposure_status.dart';
import 'package:act_cms/domain/model/enum/notice_search_category.dart';
import 'package:act_cms/domain/model/enum/notice_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  final int id;
  final NoticeCategoryType category;
  final String title;
  final DateTime createAt;
  final int viewer;
  final int like;
  final int comment;
  final ExposureStatus exposureStatus;

  Notice({
    required this.id,
    required this.category,
    required this.title,
    required this.createAt,
    required this.viewer,
    required this.like,
    required this.comment,
    required this.exposureStatus,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}

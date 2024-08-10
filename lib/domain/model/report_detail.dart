import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_detail.g.dart';

@JsonSerializable()
class ReportDetail {
  final Post? post;
  final Comment? comment;
  final List<Comment>? reply;
  final Report? report;

  const ReportDetail({
    required this.post,
    required this.comment,
    required this.reply,
    required this.report,
  });

  factory ReportDetail.fromJson(Map<String, dynamic> json) => _$ReportDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDetailToJson(this);
}

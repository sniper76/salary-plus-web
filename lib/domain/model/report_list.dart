import 'package:json_annotation/json_annotation.dart';

part 'report_list.g.dart';

@JsonSerializable()
class ReportList {
  final int reportId;
  final int contentId;
  final String? contentType;
  final String? boardCategoryName;
  final String? boardCategoryDisplayName;
  final String? boardGroupName;
  final String? stockCode;
  final String? stockName;
  final String? reportStatus;
  final int? likeCount;
  final int? commentCount;
  final int? replyCount;
  final int? viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? title;

  const ReportList({
    required this.reportId,
    required this.contentId,
    this.contentType,
    this.boardCategoryName,
    this.boardCategoryDisplayName,
    this.boardGroupName,
    this.stockCode,
    this.stockName,
    this.reportStatus,
    this.likeCount,
    this.commentCount,
    this.replyCount,
    this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    this.title,
  });

  factory ReportList.fromJson(Map<String, dynamic> json) => _$ReportListFromJson(json);

  Map<String, dynamic> toJson() => _$ReportListToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }

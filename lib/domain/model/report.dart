import 'package:act_cms/domain/model/report_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  final int? reportId;
  final int? contentId;
  final int? userId;
  final String? nickname;
  final String? contentType;
  final String? reportStatus;
  final String? reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ReportHistory>? reportHistoryList;

  const Report({
    this.reportId,
    this.contentId,
    this.userId,
    this.nickname,
    this.contentType,
    this.reportStatus,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.reportHistoryList,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }

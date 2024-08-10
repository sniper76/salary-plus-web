import 'package:json_annotation/json_annotation.dart';

part 'report_status.g.dart';

@JsonSerializable()
class ReportStatus {
  final String result;
  final String currentReportStatus;
  final String changeReportStatus;

  const ReportStatus({
    required this.result,
    required this.currentReportStatus,
    required this.changeReportStatus,
  });

  factory ReportStatus.fromJson(Map<String, dynamic> json) => _$ReportStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStatusToJson(this);
}

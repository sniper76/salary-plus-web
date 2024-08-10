import 'package:json_annotation/json_annotation.dart';

part 'report_history.g.dart';

@JsonSerializable()
class ReportHistory {
  final int? id;
  final int userId;
  final String reportStatus;
  final String? reason;
  final String result;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ReportHistory({
    this.id,
    required this.userId,
    required this.reportStatus,
    this.reason,
    required this.result,
    this.createdAt,
    this.updatedAt,
  });

  factory ReportHistory.fromJson(Map<String, dynamic> json) => _$ReportHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ReportHistoryToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }

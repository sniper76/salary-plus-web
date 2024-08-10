import 'package:act_cms/domain/model/report_detail.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateReportStatus {
  final AdminPostRepository repository;

  const UpdateReportStatus({required this.repository});

  Future<Result<ReportDetail, Exception>> call({
    required String reportType,
    required int reportId,
    required String result,
    required String currentReportStatus,
    required String changeReportStatus,
  }) {
    return repository.updateReportStatus(
        reportId: reportId,
        reportType: reportType,
        result: result,
        currentReportStatus: currentReportStatus,
        changeReportStatus: changeReportStatus);
  }
}

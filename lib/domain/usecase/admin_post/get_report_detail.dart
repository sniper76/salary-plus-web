import 'package:act_cms/domain/model/report_detail.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetReportDetail {
  final AdminPostRepository repository;

  const GetReportDetail({required this.repository});

  Future<Result<ReportDetail, Exception>> call({
    required String reportType,
    required int reportId,
  }) {
    return repository.getReportDetail(reportType: reportType, reportId: reportId);
  }
}

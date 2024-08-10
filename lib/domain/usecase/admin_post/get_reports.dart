import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/report_list.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetReports {
  final AdminPostRepository repository;

  const GetReports({required this.repository});

  Future<Result<DataResponse<List<ReportList>>, Exception>> call(
      {required String reportType, String? reportStatus, int? page, int? size, String? sorts}) {
    return repository.getReports(
        reportType: reportType, reportStatus: reportStatus, page: page, size: size, sorts: sorts);
  }
}

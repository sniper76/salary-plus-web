import 'package:act_cms/config/constants.dart';
import 'package:act_cms/domain/usecase/util/download_csv_util.dart';
import 'package:multiple_result/multiple_result.dart';

class DownloadDigitalDocumentCsv {
  final DownloadCsvUtil downloadCsvUtil;

  DownloadDigitalDocumentCsv({required this.downloadCsvUtil});

  Future<Result<void, Exception>> call({required int digitalDocumentId}) async {
    String downloadUrl =
        '${Constants.getEnvironment.getApiBaseUrl()}/admin/digital-document/$digitalDocumentId/csv-download';

    return await downloadCsvUtil.call(downloadUrl: downloadUrl);
  }
}

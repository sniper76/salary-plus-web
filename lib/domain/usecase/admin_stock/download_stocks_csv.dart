import 'package:act_cms/config/constants.dart';
import 'package:act_cms/domain/usecase/util/download_csv_util.dart';
import 'package:multiple_result/multiple_result.dart';

class DownloadStocksCSV {
  final DownloadCsvUtil downloadCsvUtil;

  const DownloadStocksCSV({required this.downloadCsvUtil});

  Future<Result<void, Exception>> call({required String stockCode}) async {
    String downloadUrl = '${Constants.getEnvironment.getApiBaseUrl()}/admin/stocks/$stockCode/users/csv-download';

    return await downloadCsvUtil.call(downloadUrl: downloadUrl);
  }
}

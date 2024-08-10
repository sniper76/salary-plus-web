import 'package:act_cms/config/constants.dart';
import 'package:act_cms/domain/usecase/util/download_csv_util.dart';
import 'package:multiple_result/multiple_result.dart';

class CampaignDownloadCsv {
  final DownloadCsvUtil downloadCsvUtil;

  const CampaignDownloadCsv({required this.downloadCsvUtil});

  Future<Result<void, Exception>> call({required int campaignId}) async {
    String downloadUrl = '${Constants.getEnvironment.getApiBaseUrl()}/admin/campaigns/$campaignId/csv-download';

    return await downloadCsvUtil.call(downloadUrl: downloadUrl);
  }
}

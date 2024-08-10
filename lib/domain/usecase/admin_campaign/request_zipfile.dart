import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class RequestZipFile {
  final AdminCampaignRepository repository;

  const RequestZipFile({required this.repository});

  Future<Result<void, Exception>> call({required int campaignId, required bool isSecured}) =>
      repository.requestZipFile(campaignId: campaignId, isSecured: isSecured);
}

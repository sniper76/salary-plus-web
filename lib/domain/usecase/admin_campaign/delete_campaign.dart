import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteCampaign {
  final AdminCampaignRepository repository;

  const DeleteCampaign({required this.repository});

  Future<Result<void, Exception>> call(int campaignId) {
    return repository.delete(campaignId: campaignId);
  }
}

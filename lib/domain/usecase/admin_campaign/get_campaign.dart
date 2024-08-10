import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCampaign {
  final AdminCampaignRepository repository;

  const GetCampaign({required this.repository});

  Future<Result<DataResponse<Campaign>, Exception>> call(int campaignId) {
    return repository.detail(campaignId);
  }
}

import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateCampaign {
  final AdminCampaignRepository repository;

  const UpdateCampaign({required this.repository});

  Future<Result<DataResponse<Campaign>, Exception>> call({
    required int campaignId,
    required int stockGroupId,
    required BoardGroupCategory boardGroupCategory,
    required String campaignTitle,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isNotification = true,
    bool isActive = true,
    List<UploadImageFile> uploadImages = const [],
    DateTime? pollTargetEndDate,
    DateTime? digitalProxyTargetEndDate,
    DateTime? digitalDocumentTargetEndDate,
    bool? isEscaped,
  }) {
    return repository.update(
      campaignId: campaignId,
      stockGroupId: stockGroupId,
      boardGroupCategory: boardGroupCategory.name,
      campaignTitle: campaignTitle,
      title: title,
      content: content,
      isNotification: isNotification,
      isAnonymous: isAnonymous,
      isActive: isActive,
      uploadImages: uploadImages,
      pollTargetEndDate: pollTargetEndDate,
      digitalProxyTargetEndDate: digitalProxyTargetEndDate,
      digitalDocumentTargetEndDate: digitalDocumentTargetEndDate,
      isEscaped: isEscaped,
    );
  }
}

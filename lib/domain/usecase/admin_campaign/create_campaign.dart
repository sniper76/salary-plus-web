import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateCampaign {
  final AdminCampaignRepository repository;

  const CreateCampaign({required this.repository});

  Future<Result<void, Exception>> call({
    required int stockGroupId,
    required String boardGroupName,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    required String campaignTitle,
    bool isActive = true,
    bool isNotification = true,
    bool isAnonymous = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
    bool? isEscaped,
  }) {
    return repository.create(
      stockGroupId: stockGroupId,
      boardGroupName: boardGroupName,
      boardGroupCategory: boardGroupCategory,
      title: title,
      campaignTitle: campaignTitle,
      content: content,
      isActive: isActive,
      isNotification: isNotification,
      isAnonymous: isAnonymous,
      uploadImages: uploadImages,
      polls: polls,
      digitalProxy: digitalProxy,
      digitalDocument: digitalDocument,
      isEscaped: isEscaped,
    );
  }
}

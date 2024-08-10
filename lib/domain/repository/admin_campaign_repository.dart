import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/campaign_search_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminCampaignRepository {
  Future<Result<DataResponse<List<Campaign>>, Exception>> list({
    String? searchKeyword,
    String? boardCategory,
    required CampaignSearchType searchType,
    int page,
    int size,
    String? sorts,
  });

  Future<Result<DataResponse<Campaign>, Exception>> detail(int campaignId);

  Future<Result<void, Exception>> create({
    required int stockGroupId,
    required String boardGroupName,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    required String campaignTitle,
    bool isActive,
    bool isNotification,
    bool isAnonymous,
    List<UploadImageFile> uploadImages,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
    bool? isEscaped,
  });

  Future<Result<DataResponse<Campaign>, Exception>> update({
    required int campaignId,
    required int stockGroupId,
    required String boardGroupCategory,
    required String campaignTitle,
    required String title,
    required String content,
    bool isAnonymous,
    bool isNotification,
    bool isActive,
    List<UploadImageFile> uploadImages,
    DateTime? pollTargetEndDate,
    DateTime? digitalProxyTargetEndDate,
    DateTime? digitalDocumentTargetEndDate,
    bool? isEscaped,
  });

  Future<Result<void, Exception>> delete({required int campaignId});

  Future<Result<void, Exception>> requestZipFile({required int campaignId, required bool isSecured});

  Future<Result<List<int>, Exception>> downloadCsv({required int campaignId});
}

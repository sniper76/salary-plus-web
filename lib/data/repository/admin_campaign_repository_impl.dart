import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/campaign_search_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminCampaignRepositoryImpl implements AdminCampaignRepository {
  final ApiDataSource dataSource;

  const AdminCampaignRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<Campaign>>, Exception>> list({
    required CampaignSearchType searchType,
    String? boardCategory,
    String? searchKeyword,
    int? page,
    int? size,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<Campaign>>>(
      dataSource.getCampaigns(
        searchKeyword,
        searchType.value,
        boardCategory,
        page,
        size,
        sorts,
      ),
    );
  }

  @override
  Future<Result<DataResponse<Campaign>, Exception>> detail(int campaignId) {
    return safeCall<DataResponse<Campaign>>(dataSource.getCampaignDetail(campaignId));
  }

  @override
  Future<Result<void, Exception>> create({
    required int stockGroupId,
    required String boardGroupName,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    required String campaignTitle,
    bool isActive = true,
    bool isNotification = false,
    bool isAnonymous = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
    bool? isEscaped,
  }) {
    final data = {
      'createPostRequest': {
        'boardCategory': boardGroupCategory.name,
        'title': title,
        'content': content,
        'isAnonymous': isAnonymous,
        'isActive': isActive,
        'isNotification': isNotification,
        'imageIds': uploadImages.map((e) => e.id).toList(),
        'polls': polls?.map((poll) => poll.toJson()).toList(),
        'digitalProxy': digitalProxy?.toJson(),
        'digitalDocument': digitalDocument?.toJson(),
        'boardGroupName': boardGroupName,
        'isEd': isEscaped ?? false,
      },
      "title": campaignTitle,
      "boardGroupName": 'ACTION',
      "stockGroupId": stockGroupId
    };

    return safeCall<void>(dataSource.postCampaign(
      data,
    ));
  }

  @override
  Future<Result<DataResponse<Campaign>, Exception>> update({
    required int stockGroupId,
    required String boardGroupCategory,
    required int campaignId,
    required String campaignTitle,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isNotification = false,
    bool isActive = true,
    List<UploadImageFile> uploadImages = const [],
    DateTime? pollTargetEndDate,
    DateTime? digitalProxyTargetEndDate,
    DateTime? digitalDocumentTargetEndDate,
    bool? isEscaped,
  }) async {
    final updatePostRequest = {
      'boardCategory': boardGroupCategory,
      'title': title,
      'content': content,
      'isAnonymous': isAnonymous,
      'isNotification': isNotification,
      'isActive': isActive,
      'imageIds': uploadImages.map((e) => e.id).toList(),
      'isEd': isEscaped ?? false,
    };
    if (pollTargetEndDate != null) {
      updatePostRequest['updateTargetDate'] = {'targetEndDate': pollTargetEndDate.toUtc().toIso8601String()};
    }

    if (digitalProxyTargetEndDate != null) {
      updatePostRequest['updateTargetDate'] = {'targetEndDate': digitalProxyTargetEndDate.toUtc().toIso8601String()};
    }

    if (digitalDocumentTargetEndDate != null) {
      updatePostRequest['updateTargetDate'] = {'targetEndDate': digitalDocumentTargetEndDate.toUtc().toIso8601String()};
      updatePostRequest['digitalDocument'] = {'targetEndDate': digitalDocumentTargetEndDate.toUtc().toIso8601String()};
    }

    final data = {'updatePostRequest': updatePostRequest, 'title': campaignTitle};

    return safeCall<DataResponse<Campaign>>(dataSource.updateCampaign(
      campaignId,
      data,
    ));
  }

  @override
  Future<Result<void, Exception>> delete({
    required int campaignId,
  }) {
    return safeCall(dataSource.deleteCampaign(campaignId));
  }

  @override
  Future<Result<List<int>, Exception>> downloadCsv({required int campaignId}) async {
    return safeCall<List<int>>(dataSource.downloadDigitalDocs(campaignId));
  }

  @override
  Future<Result<void, Exception>> requestZipFile({required int campaignId, required bool isSecured}) async {
    return safeCall<void>(dataSource.requestZipFile(campaignId, isSecured));
  }
}

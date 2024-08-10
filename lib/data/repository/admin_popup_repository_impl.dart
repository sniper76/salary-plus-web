import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/popup/popup_search_type.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/repository/admin_popup_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminPopupRepositoryImpl implements AdminPopupRepository {
  final ApiDataSource dataSource;

  const AdminPopupRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Popup, Exception>> create({
    required String title,
    required String content,
    required String displayTargetType,
    required String stockTargetType,
    required String linkType,
    required String targetStartDatetime,
    required String targetEndDatetime,
    String? stockCode,
    int? stockGroupId,
    String? linkTitle,
    String? postId,
  }) async {
    final data = {
      'title': title,
      'content': content,
      'displayTargetType': displayTargetType,
      'stockTargetType': stockTargetType,
      'linkType': linkType,
      'targetStartDatetime': targetStartDatetime,
      'targetEndDatetime': targetEndDatetime,
      'stockCode': stockCode,
      'stockGroupId': stockGroupId,
      'linkTitle': linkTitle,
      'postId': postId,
    };
    final res = await safeCall<DataResponse<Popup>>(dataSource.createAdminPopup(data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Popup, Exception>> update({
    required int popupId,
    required String title,
    required String content,
    required String displayTargetType,
    required String stockTargetType,
    required String linkType,
    required String targetStartDatetime,
    required String targetEndDatetime,
    String? stockCode,
    int? stockGroupId,
    String? linkTitle,
    String? postId,
  }) async {
    final data = {
      'title': title,
      'content': content,
      'displayTargetType': displayTargetType,
      'stockTargetType': stockTargetType,
      'linkType': linkType,
      'targetStartDatetime': targetStartDatetime,
      'targetEndDatetime': targetEndDatetime,
      'stockCode': stockCode,
      'stockGroupId': stockGroupId,
      'linkTitle': linkTitle,
      'postId': postId,
    };
    final res = await safeCall<DataResponse<Popup>>(dataSource.updateAdminPopup(popupId, data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> delete({required int popupId}) {
    return safeCall<void>(dataSource.deleteAdminPopup(popupId));
  }

  @override
  Future<Result<DataResponse<List<Popup>>, Exception>> list(
      {required String searchKeyword,
      required PopupSearchType searchType,
      String? popupStatus,
      int page = 10,
      int size = 1,
      String? sorts}) {
    return safeCall<DataResponse<List<Popup>>>(dataSource.getAdminPopups(
      searchType.value,
      searchKeyword,
      popupStatus,
      page,
      size,
      sorts,
    ));
  }

  @override
  Future<Result<DataResponse<Popup>, Exception>> get({
    required int popupId,
  }) {
    return safeCall<DataResponse<Popup>>(dataSource.getAdminPopup(popupId));
  }
}

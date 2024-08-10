import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/popup/popup_search_type.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminPopupRepository {
  Future<Result<DataResponse<List<Popup>>, Exception>> list({
    required String searchKeyword,
    required PopupSearchType searchType,
    String? popupStatus,
    int page,
    int size,
    String? sorts,
  });

  Future<Result<DataResponse<Popup>, Exception>> get({
    required int popupId,
  });

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
  });

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
  });

  Future<Result<void, Exception>> delete({required int popupId});
}

import 'package:act_cms/domain/model/enum/popup/popup_display_target_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_link_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_stock_target_type.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/repository/admin_popup_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdatePopup {
  final AdminPopupRepository repository;

  const UpdatePopup({required this.repository});

  Future<Result<Popup, Exception>> call({
    required int popupId,
    required String title,
    required String content,
    required PopupDisplayTargetType displayTargetType,
    required PopupStockTargetType stockTargetType,
    required PopupLinkType linkType,
    required DateTime targetStartDatetime,
    required DateTime targetEndDatetime,
    String? stockCode,
    int? stockGroupId,
    String? linkTitle,
    String? postId,
  }) {
    return repository.update(
      popupId: popupId,
      title: title,
      content: content,
      displayTargetType: displayTargetType.value,
      stockTargetType: stockTargetType.value,
      linkType: linkType.value,
      targetStartDatetime: targetStartDatetime.toUtc().toIso8601String(),
      targetEndDatetime: targetEndDatetime.toUtc().toIso8601String(),
      stockCode: stockCode,
      stockGroupId: stockGroupId,
      linkTitle: PopupLinkType.none != linkType ? linkTitle : null,
      postId: PopupLinkType.none != linkType ? postId : null,
    );
  }
}

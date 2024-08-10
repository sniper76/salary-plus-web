import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/repository/admin_popup_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FindPopup {
  final AdminPopupRepository repository;

  const FindPopup({required this.repository});

  Future<Result<DataResponse<Popup>, Exception>> call({required int popupId}) {
    return repository.get(popupId: popupId);
  }
}

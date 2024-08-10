import 'package:act_cms/domain/repository/admin_popup_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeletePopup {
  final AdminPopupRepository repository;

  const DeletePopup({required this.repository});

  Future<Result<void, Exception>> call({
    required int popupId,
  }) {
    return repository.delete(
      popupId: popupId,
    );
  }
}

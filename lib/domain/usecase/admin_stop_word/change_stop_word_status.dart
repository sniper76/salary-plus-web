import 'package:act_cms/domain/model/enum/stop_word_status.dart';
import 'package:act_cms/domain/repository/admin_stop_word_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ChangeStopWordStatus {
  final AdminStopWordRepository repository;

  const ChangeStopWordStatus({required this.repository});

  Future<Result<void, Exception>> call(
    int stopWordId,
    StopWordStatus beforeStatus,
    StopWordStatus afterStatus,
  ) {
    return repository.changeStopWordStatus(
      stopWordId,
      beforeStatus,
      afterStatus,
    );
  }
}

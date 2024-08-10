import 'package:act_cms/domain/repository/admin_stop_word_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteStopWord {
  final AdminStopWordRepository repository;

  const DeleteStopWord({required this.repository});

  Future<Result<void, Exception>> call(int stopWordId) {
    return repository.deleteStopWord(
      stopWordId,
    );
  }
}

import 'package:act_cms/domain/model/error/stop_word_exception.dart';
import 'package:act_cms/domain/repository/admin_stop_word_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateStopWord {
  final AdminStopWordRepository repository;

  const CreateStopWord({required this.repository});

  Future<Result<void, StopWordException>> call(String newStopWord) {
    return repository.createStopWord(
      newStopWord,
    );
  }
}

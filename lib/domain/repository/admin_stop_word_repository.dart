import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/stop_word_filter_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_sort_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_status.dart';
import 'package:act_cms/domain/model/error/stop_word_exception.dart';
import 'package:act_cms/domain/model/stop_word.dart';
import 'package:multiple_result/src/result.dart';

abstract class AdminStopWordRepository {
  Future<Result<DataResponse<List<StopWord>>, Exception>> getStopWords({
    int? page,
    int? size,
    StopWordSortType? sortType,
    StopWordFilterType? filterType,
    String? searchKeyWord,
  });

  Future<Result<void, StopWordException>> createStopWord(
    String newStopWord,
  );

  Future<Result<void, Exception>> changeStopWordStatus(
    int stopWordId,
    StopWordStatus beforeStatus,
    StopWordStatus afterStatus,
  );

  Future<Result<void, Exception>> deleteStopWord(
    int stopWordId,
  );
}

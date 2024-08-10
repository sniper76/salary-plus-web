import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/stop_word_filter_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_sort_type.dart';
import 'package:act_cms/domain/model/stop_word.dart';
import 'package:act_cms/domain/repository/admin_stop_word_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStopWords {
  final AdminStopWordRepository repository;

  const GetStopWords({required this.repository});

  Future<Result<DataResponse<List<StopWord>>, Exception>> call({
    int? page,
    int? size,
    StopWordSortType? sortType,
    StopWordFilterType? filterType,
    String? searchKeyWord,
  }) {
    return repository.getStopWords(
      page: page,
      size: size,
      sortType: sortType,
      filterType: filterType,
      searchKeyWord: searchKeyWord,
    );
  }
}

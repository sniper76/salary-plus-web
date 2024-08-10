import 'package:act_cms/core/extension/exception_extension.dart';
import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/stop_word_filter_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_sort_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_status.dart';
import 'package:act_cms/domain/model/error/stop_word_exception.dart';
import 'package:act_cms/domain/model/stop_word.dart';
import 'package:act_cms/domain/repository/admin_stop_word_repository.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/src/result.dart';

class AdminStopWordRepositoryImpl implements AdminStopWordRepository {
  final ApiDataSource dataSource;

  const AdminStopWordRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<StopWord>>, Exception>> getStopWords({
    int? page,
    int? size,
    StopWordSortType? sortType,
    StopWordFilterType? filterType,
    String? searchKeyWord,
  }) {
    String filterTypeString;

    switch (filterType) {
      case StopWordFilterType.active:
        filterTypeString = 'ACTIVE';
        break;
      case StopWordFilterType.inactive:
        filterTypeString = 'INACTIVE';
        break;
      default:
        filterTypeString = 'ALL';
    }

    return safeCall<DataResponse<List<StopWord>>>(
        dataSource.getStopWords(page, size, sortType?.queryValue, filterTypeString, searchKeyWord));
  }

  @override
  Future<Result<void, StopWordException>> createStopWord(String newStopWord) {
    Map<String, dynamic> data = {
      'word': newStopWord,
    };

    return safeCallWithCustomException<void, StopWordException>(
      dataSource.createStopWords(data),
      errorParser: (Response response) {
        return StopWordException.fromJson(response.data);
      },
      defaultErrorParser: (Exception exception) {
        return StopWordException(message: exception.message);
      },
    );
  }

  @override
  Future<Result<void, Exception>> changeStopWordStatus(
    int stopWordId,
    StopWordStatus beforeStatus,
    StopWordStatus afterStatus,
  ) {
    Map<String, dynamic> data = {
      'beforeStatus': beforeStatus.value,
      'afterStatus': afterStatus.value,
    };
    return safeCall(dataSource.changeStopWordStatus(stopWordId, data));
  }

  @override
  Future<Result<void, Exception>> deleteStopWord(int stopWordId) {
    return safeCall(dataSource.deleteStopWords(stopWordId));
  }
}

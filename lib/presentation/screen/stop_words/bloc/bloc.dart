import 'dart:async';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/stop_word_filter_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_sort_type.dart';
import 'package:act_cms/domain/model/enum/stop_word_status.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/stop_word_search/stop_word_filter_type_wrapper.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/stop_word_search/stop_word_sort_type_wrapper.dart';
import 'package:act_cms/domain/model/error/stop_word_exception.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/stop_word.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/change_stop_word_status.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/create_stop_word.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/delete_stop_word.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/get_stop_words.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class StopWordsBloc extends Bloc<StopWordsEvent, StopWordsState> {
  final int alreadyRegisteredButInActivatedCode = 4001;

  final _getStopWords = getIt<GetStopWords>();
  final _createStopWord = getIt<CreateStopWord>();
  final _deleteStopWord = getIt<DeleteStopWord>();
  final _changeStopWordStatus = getIt<ChangeStopWordStatus>();

  StopWordsBloc() : super(StopWordsState()) {
    on<StopsWordOnInit>((event, emit) async {
      await _fetchStopWords(const StopsWordsOnFetchStopWords(), emit);
    });

    on<StopsWordsOnCreateStopWord>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final Result<void, StopWordException> result = await _createStopWord(event.newStopWord);

      if (result.isSuccess()) {
        await _fetchStopWords(StopsWordsOnFetchStopWords(sortType: state.selectedSortType), emit);
      } else {
        final StopWordException? stopWordException = result.tryGetError();
        if (stopWordException?.errorCode == alreadyRegisteredButInActivatedCode && stopWordException != null) {
          emit(state.copyWith(
            isLoading: false,
            reActivateTargetPopupId: stopWordException.errorData?.stopWordId,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            errorToastMessage: stopWordException.toString(),
          ));
        }
      }
    });

    on<StopsWordsOnChangeStopWordStatus>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final Result result = await _changeStopWordStatus(
        event.stopWordId,
        event.beforeStatus,
        event.afterStatus,
      );

      if (result.isSuccess()) {
        await _fetchStopWords(StopsWordsOnFetchStopWords(sortType: state.selectedSortType), emit);
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: result.tryGetError().toString(),
        ));
      }
    });

    on<StopWordsOnDeleteStopWord>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final Result result = await _deleteStopWord(event.stopWordId);

      if (result.isSuccess()) {
        await _fetchStopWords(StopsWordsOnFetchStopWords(sortType: state.selectedSortType), emit);
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: result.tryGetError().toString(),
        ));
      }
    });

    on<StopsWordOnLoadMore>((event, emit) async {
      if (state.isLoading) return;

      await _fetchStopWords(StopsWordsOnFetchStopWords(page: event.page), emit);
    });

    on<StopsWordOnSearchKeword>((event, emit) async {
      if (state.isLoading) return;
      emit(state.copyWith(
        isLoading: true,
      ));

      await _fetchStopWords(StopsWordsOnFetchStopWords(searchKeyWord: event.keyword), emit);
    });

    on<StopsWordOnChangeSortType>(
      (event, emit) async {
        if (event.changedSortType == state.selectedSortType) return;
        await _fetchStopWords(StopsWordsOnFetchStopWords(sortType: event.changedSortType), emit);
      },
    );

    on<StopsWordOnChangeFilterType>(
      (event, emit) async {
        if (event.changedFilterType == state.selectedFilterType) return;
        await _fetchStopWords(StopsWordsOnFetchStopWords(filterType: event.changedFilterType), emit);
      },
    );
  }

  Future<void> _fetchStopWords(
    StopsWordsOnFetchStopWords fetchEvent,
    Emitter<StopWordsState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final Result result = await _getStopWords(
      page: fetchEvent.page ?? 1,
      size: fetchEvent.size ?? apiLoadSize,
      sortType: fetchEvent.sortType ?? state.selectedSortType,
      filterType: fetchEvent.filterType ?? state.selectedFilterType,
      searchKeyWord: fetchEvent.searchKeyWord ?? state.curSearchKeyWord,
    );

    if (result.isSuccess()) {
      final DataResponse<List<StopWord>>? resData = result.tryGetSuccess();

      emit(state.copyWith(
        isLoading: false,
        stopWordList: resData?.data,
        paging: resData?.paging,
        totalCount: resData?.paging?.total,
        selectedSortType: fetchEvent.sortType ?? state.selectedSortType,
        selectedFilterType: fetchEvent.filterType ?? state.selectedFilterType,
        curSearchKeyWord: fetchEvent.searchKeyWord ?? state.curSearchKeyWord,
        errorToastMessage: null,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: result.tryGetError().toString(),
      ));
    }
  }
}

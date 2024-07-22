import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/data/response/paging.dart';
import 'package:act_web/domain/model/ranking/search_ranking.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/domain/usecase/home/get_my_solidarity_list.dart';
import 'package:act_web/domain/usecase/home/update_my_solidarity_display_order.dart';
import 'package:act_web/domain/usecase/stock/get_search_ranking_list.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:act_web/presentation/widget/act_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetSearchRankingList _getSearchRankingList = GetIt.I<GetSearchRankingList>();
  final GetMySolidarityList _getMySolidarityList = GetIt.I<GetMySolidarityList>();
  final UpdateMySolidarityDisplayOrder _updateMySolidarityDisplayOrder = GetIt.I<UpdateMySolidarityDisplayOrder>();

  StockBloc() : super(StockState.initial()) {
    on<_OnInit>((event, emit) async {
      add(const StockEvent.fetchSearchRanking());
      add(const StockEvent.fetchMySolidarity(page: 1, isFetchingWhole: false));
    });

    on<_OnChangePage>((event, emit) async {
      add(StockEvent.fetchMySolidarity(page: event.page, isFetchingWhole: false));
    });

    on<_OnChangeDisplayOrder>((event, emit) async {
      int previousIndex = event.previousIndex;
      int currentIndex = event.currentIndex;
      List<Solidarity> currentSolidarityList = [...state.wholeMySolidarityList];

      if (previousIndex < currentIndex && currentIndex != 0) {
        currentIndex -= 1;
      }

      final Solidarity item = currentSolidarityList.removeAt(previousIndex);
      currentSolidarityList.insert(currentIndex, item);

      emit(state.copyWithNull(
        wholeMySolidarityList: currentSolidarityList,
      ));
    });

    on<_OnUpdateDisplayOrder>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
        isWholeMySolidarityListFetched: null,
      ));

      final List<String> currentSolidarityCodeListOrder =
          state.wholeMySolidarityList.map((Solidarity solidarity) => solidarity.code).toList();

      final Result<void, Exception> updateDisplayOrderRes = await _updateMySolidarityDisplayOrder(
        currentSolidarityCodeListOrder,
      );

      updateDisplayOrderRes.when((_) {
        emit(state.copyWithNull(
          isLoading: false,
        ));
        add(StockEvent.fetchMySolidarity(
          page: state.paging.page,
          isFetchingWhole: false,
        ));
      }, (Exception error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: error.message,
        ));
      });
    });

    on<_OnFetchMySolidarity>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
        isWholeMySolidarityListFetched: null,
      ));

      final Result<DataResponse<List<Solidarity>>, Exception> mySolidarityListRes = await _getMySolidarityList(
        page: event.page,
        size: 10,
        isFetchingWhole: event.isFetchingWhole,
      );

      mySolidarityListRes.when((DataResponse<List<Solidarity>> successData) {
        if (event.isFetchingWhole) {
          emit(state.copyWithNull(
            isLoading: false,
            wholeMySolidarityList: successData.data ?? [],
            isWholeMySolidarityListFetched: true,
          ));
        } else {
          emit(state.copyWithNull(
            isLoading: false,
            pagedMySolidarityList: successData.data ?? [],
            mySolidarityPaging: successData.paging ?? Paging.initial(),
          ));
        }
      }, (Exception error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: error.message,
        ));
      });
    });

    on<_OnFetchSearchRanking>((event, emit) async {
      final Result<DataResponse<List<SearchRanking>>?, Exception> searchRankingListRes = await _getSearchRankingList();

      searchRankingListRes.when((DataResponse<List<SearchRanking>>? successData) {
        if (successData?.data != null) {
          emit(state.copyWithNull(
            isLoading: false,
            searchRankingList: successData!.data!,
          ));
        } else {
          emit(state.copyWithNull(
            isLoading: false,
            searchRankingList: [],
            errorToastMessage: '에러가 발생했습니다. 다시 시도해주세요.',
          ));
          return;
        }
      }, (Exception error) {
        emit(state.copyWithNull(
          isLoading: false,
          searchRankingList: [],
          errorToastMessage: error.message,
        ));
      });
    });
  }
}

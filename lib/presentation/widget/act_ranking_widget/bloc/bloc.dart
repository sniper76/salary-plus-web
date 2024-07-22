import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/ranking_sort_type.dart';
import 'package:act_web/domain/model/ranking/ranking_stock.dart';
import 'package:act_web/domain/usecase/ranking/get_ranking_stock_list.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

part 'bloc.freezed.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final int size = 50;
  final GetRankingStockList _getRankingStockList = GetIt.I<GetRankingStockList>();

  RankingBloc() : super(RankingState.initial()) {
    on<_OnInit>((event, emit) async {
      add(const RankingEvent.refresh());
    });

    on<_OnSort>((event, emit) async {
      add(RankingEvent.refresh(event.selectedSortType));
    });

    on<_OnRefresh>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<DataResponse<List<RankingStock>>, Exception> rankingListRes = await _getRankingStockList(
        sorts: event.selectedSortType?.queryValue ?? state.currentSortType.queryValue,
      );

      rankingListRes.when(
        (DataResponse<List<RankingStock>> rankingListData) {
          if (rankingListData.data?.isEmpty == true) {
            emit(state.copyWithNull(
              isLoading: false,
              errorToastMessage: '랭킹이 없습니다.',
            ));
            return;
          } else {
            emit(state.copyWithNull(
              isLoading: false,
              currentSortType: event.selectedSortType ?? state.currentSortType,
              rankingStockList: rankingListData.data!,
            ));
            return;
          }
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));

          return;
        },
      );
    });
  }
}

import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/model/stock_home/stock_home.dart';
import 'package:act_web/domain/usecase/post/get_post_list_previews.dart';
import 'package:act_web/domain/usecase/stock/get_stock_home.dart';
import 'package:act_web/domain/usecase/stock/update_solidarity_leader_message.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class StockHomeBloc extends Bloc<StockHomeEvent, StockHomeState> {
  final String stockCode;

  final GetStockHome _getStockHome = GetIt.I<GetStockHome>();
  final GetPostListPreviews _getPostListPreviews = GetIt.I<GetPostListPreviews>();
  final UpdateSolidarityLeaderMessage _updateLeaderMessage = GetIt.I<UpdateSolidarityLeaderMessage>();

  StockHomeBloc({required this.stockCode}) : super(StockHomeState.initial()) {
    on<_OnInit>((event, emit) async {
      // TODO: need refactoring with act post list widget
      if (stockCode == AppConfig.globalBoardCode) return;

      emit(state.copyWithNull(
        isLoading: true,
      ));

      final Future<Result<StockHome, Exception>> stockHomeResFuture = _getStockHome(stockCode);
      final Future<Result<DataResponse<List<Post>>, Exception>> debatePostListResFuture = _getPostListPreviews(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.debate,
      );
      final Future<Result<DataResponse<List<Post>>, Exception>> analysisPostListResFuture = _getPostListPreviews(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.analysis,
      );
      final Future<Result<DataResponse<List<Post>>, Exception>> actionPostListResFuture = _getPostListPreviews(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.action,
      );

      List<Result> resList = await Future.wait([
        stockHomeResFuture,
        debatePostListResFuture,
        analysisPostListResFuture,
        actionPostListResFuture,
      ]);

      final Result<StockHome, Exception> stockHomeRes = resList[0] as Result<StockHome, Exception>;
      final Result<DataResponse<List<Post>>, Exception> debatePostListRes =
          resList[1] as Result<DataResponse<List<Post>>, Exception>;
      final Result<DataResponse<List<Post>>, Exception> analysisPostListRes =
          resList[2] as Result<DataResponse<List<Post>>, Exception>;
      final Result<DataResponse<List<Post>>, Exception> actionPostListRes =
          resList[3] as Result<DataResponse<List<Post>>, Exception>;

      stockHomeRes.when(
        (StockHome successData) {
          emit(state.copyWithNull(
            isLoading: false,
            stockHome: successData,
            debatePostList: debatePostListRes.tryGetSuccess()?.data ?? [],
            analysisPostList: analysisPostListRes.tryGetSuccess()?.data ?? [],
            actionPostList: actionPostListRes.tryGetSuccess()?.data ?? [],
          ));
        },
        (Exception exception) {
          emit(state.copyWithNull(
            isLoading: false,
            isNotFound: true,
            errorToastMessage: exception.message,
          ));
        },
      );
    });

    on<_OnUpdateSolidarityLeaderMessage>((event, emit) async {
      if (state.isLoading || state.stockHome?.leader?.solidarityId == null) return;

      emit(state.copyWithNull(isLoading: true));

      final res = await _updateLeaderMessage(
        stockCode: stockCode,
        solidarityId: state.stockHome!.leader!.solidarityId!,
        message: event.message,
      );

      if (res.isSuccess()) {
        add(const StockHomeEvent.init());
      }

      emit(state.copyWithNull(
        isLoading: false,
        errorToastMessage: res.tryGetError()?.message,
      ));
    });
  }
}

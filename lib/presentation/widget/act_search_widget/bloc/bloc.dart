import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/domain/usecase/common/get_common_stocks.dart';
import 'package:act_web/domain/usecase/common/post_stock_search_trends.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'bloc.freezed.dart';

part 'event.dart';
part 'state.dart';

class ActSearchWidgetBloc extends Bloc<ActSearchWidgetEvent, ActSearchWidgetState> {
  final GetCommonStocks _getCommonStocks = GetIt.I<GetCommonStocks>();
  final PostStockSearchTrends _postStockSearchTrends = GetIt.I<PostStockSearchTrends>();

  ActSearchWidgetBloc() : super(ActSearchWidgetState.initial()) {
    on<_OnInit>((event, emit) async {
      final Result<List<BaseStock>, Exception> commonStockRes = await _getCommonStocks();

      commonStockRes.when(
        (List<BaseStock> stocks) {
          emit(state.copyWithNull(
            stocks: stocks,
          ));
        },
        (Exception e) {
          emit(state.copyWithNull(
            stocks: [],
            errorToastMessage: e.message,
          ));
        },
      );
    });

    on<_OnSearchStock>((event, emit) async {
      await _postStockSearchTrends(stockCode: event.stockCode);
    });
  }
}

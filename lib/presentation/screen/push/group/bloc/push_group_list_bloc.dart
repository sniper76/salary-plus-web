import 'dart:async';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/usecase/admin_push/delete_push.dart';
import 'package:act_cms/domain/usecase/admin_push/find_pushs.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'push_group_list_event.dart';
part 'push_group_list_state.dart';

class PushGroupListBloc extends Bloc<PushGroupListEvent, PushGroupListState> {
  final _findPushes = getIt<FindPushes>();
  final _cancelPush = getIt<DeletePush>();

  final _cmsCommonsData = getIt<CMSCommonsService>();

  Paging? _paging;

  PushGroupListBloc() : super(const PushGroupListState()) {
    on<PushGroupListOnInit>(onPushListOnInit);

    on<PushGroupListOnChangedSearchType>((event, emit) async {
      emit(state.copyWith(searchType: event.searchType, searchKeyword: ""));
    });

    on<PushGroupListOnRefresh>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true));

      // PushSearchType.push_content,
      final pushRes = await _fetchPush(
        searchType: state.searchType,
        searchKeyword: state.searchKeyword,
        page: state.paging.page,
        size: state.paging.size,
      );
      if (pushRes.isSuccess()) {
        final pagingData = pushRes.tryGetSuccess();
        final pushes = pagingData?.data ?? [];
        _paging = pagingData?.paging;
        emit(state.copyWith(
          paging: _paging,
          isLoadingMore: false,
          pushes: pushes,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: pushRes.tryGetError().toString(),
        ));
      }
    });

    on<PushGroupListOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true));

      // PushSearchType.push_content,
      final pushRes = await _fetchPush(
        searchType: state.searchType,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        page: event.page,
        size: event.size ?? apiLoadSize,
        sort: event.sorts,
      );
      final pagingData = pushRes.tryGetSuccess();
      final pushes = pagingData?.data ?? [];

      if (pushRes.isSuccess()) {
        _paging = pagingData?.paging;
        emit(state.copyWith(
          paging: _paging,
          isLoadingMore: false,
          searchKeyword: event.searchKeyword,
          pushes: pushes,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: pushRes.isError().toString(),
        ));
      }
    });

    on<PushGroupListOnSetSearchKeyword>((event, emit) async {
      if (state.searchType == PushSearchType.stockName) {
        if (event.searchKeyword == "") {
          emit(state.copyWith(sourceCandidateStockList: [], searchKeyword: event.searchKeyword));
        } else {
          final candidatedStockList = _cmsCommonsData.cmsCommons?.stocks
              .where((stock) {
                String searchKeywordLower = event.searchKeyword.toLowerCase();
                String stockCodeLower = stock.code.toLowerCase();
                String stockNameLower = stock.name.toLowerCase();

                return stockCodeLower.startsWith(searchKeywordLower) ||
                    (searchKeywordLower.length >= 2 && stockNameLower.contains(searchKeywordLower));
              })
              .map((data) => SimpleStock(code: data.code, name: data.name))
              .toList();

          emit(state.copyWith(sourceCandidateStockList: candidatedStockList, searchKeyword: event.searchKeyword));
        }
      }
    });

    on<PushGroupOnCancelPush>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final pushRes = await _cancelPush(pushId: event.pushId);
      if (pushRes.isSuccess()) {
        // _cancelPush
        emit(state.copyWith(isLoading: false, refreshPage: !state.refreshPage));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: pushRes.tryGetError().toString(),
        ));
      }
    });
  }

  FutureOr<void> onPushListOnInit(event, emit) async {
    emit(state.copyWith(isLoading: true, searchType: PushSearchType.pushContent, searchKeyword: ""));

    final pushRes = await _fetchPush(
      searchType: state.searchType,
      searchKeyword: "",
      size: apiLoadSize,
      page: 1,
    );

    if (pushRes.isSuccess()) {
      final pagingData = pushRes.tryGetSuccess();
      _paging = pagingData?.paging;
      final pushes = pagingData?.data;

      emit(state.copyWith(
        isLoading: false,
        pushes: pushes,
        totalCount: pagingData?.paging?.total,
        paging: pagingData?.paging,
      ));
    } else {
      emit(state.copyWith(isLoading: false, errorToastMessage: pushRes.tryGetError().toString()));
    }
  }

  Future<Result<DataResponse<List<GroupPush>>, Exception>> _fetchPush({
    required String searchKeyword,
    required PushSearchType searchType,
    int? page,
    int? size,
    BoardSortType? sort,
  }) {
    return _findPushes(
      searchKeyword: searchKeyword,
      searchType: searchType,
      page: page ?? 1,
      size: size ?? apiLoadSize,
      sort: sort,
    );
  }

  @override
  Future<void> close() {
    // _pushChangeEventSubscription.cancel();
    // _pushItemChangeEventSubscription.cancel();
    return super.close();
  }
}

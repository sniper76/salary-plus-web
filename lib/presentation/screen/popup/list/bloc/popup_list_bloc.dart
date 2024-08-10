import 'dart:async';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_search_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/usecase/admin_popup/delete_popup.dart';
import 'package:act_cms/domain/usecase/admin_popup/find_popups.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

part 'popup_list_event.dart';
part 'popup_list_state.dart';

class PopupListBloc extends Bloc<PopupListEvent, PopupListState> {
  final _findPopups = getIt<FindPopups>();
  final _deletePopups = getIt<DeletePopup>();

  Paging? _paging;

  PopupListBloc() : super(const PopupListState()) {
    on<PopupListOnInit>(onPopupListOnInit);

    on<PopupOnCancelPopup>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final popupRes = await _deletePopups(popupId: event.popupId);
      if (popupRes.isSuccess()) {
        emit(state.copyWith(isLoading: false, refreshPage: !state.refreshPage));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: popupRes.tryGetError().toString(),
        ));
      }
    });

    on<PopupListOnRefresh>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true));

      final popupRes = await _fetchPopups(
        searchType: state.searchType,
        searchKeyword: state.searchKeyword,
        page: state.paging.page,
        size: state.paging.size,
      );

      if (popupRes.isSuccess()) {
        final pagingData = popupRes.tryGetSuccess();
        final popups = pagingData?.data ?? [];
        _paging = pagingData?.paging;
        emit(state.copyWith(
          paging: _paging,
          isLoadingMore: false,
          popups: popups,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: popupRes.tryGetError().toString(),
        ));
      }
    });

    on<PopupListOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true));

      final popupRes = await _fetchPopups(
        searchType: state.searchType,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        page: event.page,
        size: event.size ?? apiLoadSize,
        sort: event.sorts,
      );
      final pagingData = popupRes.tryGetSuccess();
      final popups = pagingData?.data ?? [];

      if (popupRes.isSuccess()) {
        _paging = pagingData?.paging;
        emit(state.copyWith(
          paging: _paging,
          isLoadingMore: false,
          searchKeyword: event.searchKeyword,
          popups: popups,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: popupRes.isError().toString(),
        ));
      }
    });
  }

  FutureOr<void> onPopupListOnInit(event, emit) async {
    emit(state.copyWith(isLoading: true, searchType: PopupSearchType.popup_title, searchKeyword: ""));

    final popupRes = await _fetchPopups(
      searchType: state.searchType,
      searchKeyword: "",
      size: apiLoadSize,
      page: 1,
    );

    if (popupRes.isSuccess()) {
      final pagingData = popupRes.tryGetSuccess();
      _paging = pagingData?.paging;
      final popups = pagingData?.data;

      emit(state.copyWith(
        isLoading: false,
        popups: popups,
        totalCount: pagingData?.paging?.total,
        paging: pagingData?.paging,
      ));
    } else {
      emit(state.copyWith(isLoading: false, errorToastMessage: popupRes.tryGetError().toString()));
    }
  }

  Future<Result<DataResponse<List<Popup>>, Exception>> _fetchPopups({
    required String searchKeyword,
    required PopupSearchType searchType,
    int? page,
    int? size,
    BoardSortType? sort,
  }) {
    return _findPopups(
      searchKeyword: searchKeyword,
      searchType: searchType,
      page: page ?? 1,
      size: size ?? apiLoadSize,
      sort: sort,
    );
  }
}

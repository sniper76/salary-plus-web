import 'dart:async';
import 'dart:convert';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_groups.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'cms_group_event.dart';
part 'cms_group_state.dart';

class CmsStockGroupBloc extends Bloc<CmsStockGroupEvent, CmsStockGroupState> {
  final _getCmsStockGroup = getIt<GetGroups>();
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _eventBus = getIt<IEventBus>();
  late StreamSubscription _stockGroupChangeEventSubscription;

  CmsStockGroupBloc() : super(const CmsStockGroupState()) {
    on<CmsStockGroupOnInit>(onCmsStockGroupOnInit);

    on<CmsStockGroupOnSetStockGroupId>((event, emit) {
      emit(state.copyWith(
        stockGroupId: event.stockGroupId,
      ));
    });

    on<CmsStockGroupOnPaginatorIndex>((event, emit) {
      emit(state.copyWith(
        paginatorIndex: event.paginatorIndex,
      ));
    });

    on<FetchCmsStockGroup>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final res = await _getCmsStockGroup(
        stockGroupId: event.stockGroupId,
        page: event.page,
        size: event.size,
      );
      emit(state.copyWith(isLoading: true));
      if (res.isSuccess()) {
        final users = res.tryGetSuccess();
        emit(state.copyWith(
          stockGroupId: event.stockGroupId,
          isLoading: false,
          stockGroupList: users?.data,
          paging: users?.paging,
          clearStockGroupId: event.stockGroupId == null,
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    });

    on<CmsStockGroupOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }

      emit(state.copyWith(isLoading: true));

      final res = await _fetchCmsStockGroup(
        stockGroupId: event.stockGroupId,
        page: event.page,
        size: event.size,
        sorts: event.sorts,
      );
      if (res.isSuccess()) {
        final pagingData = res.tryGetSuccess();

        emit(state.copyWith(
          isLoading: false,
          paging: pagingData?.paging,
          stockGroupList: pagingData?.data ?? [],
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    });

    on<SearchKeword>((event, emit) async {
      if (event.keyword == "") {
        emit(state.copyWith(cadiatedStocGroupkList: []));
      } else {
        final keyword = event.keyword.toLowerCase();
        final cadiatedStocGroupkList = _cmsCommonsData.cmsCommons?.stockGroups
            .where((stock) => stock.name.toLowerCase().contains(keyword))
            .map((data) => SimpleStockGroup(id: data.id, name: data.name))
            .toList();
        emit(state.copyWith(cadiatedStocGroupkList: cadiatedStocGroupkList));
      }
    });

    on<SubmitKeyword>((event, emit) async {
      if (event.keyword == "") {
        emit(state.copyWith(stockGroupList: state.allStockGroupList));
      } else {
        List<StockGroup> stockGroupList = [];

        // If the search term is not empty, filter the allStockGroupList
        // Use `where` to filter the stock groups that contain the search term
        // This is case-insensitive search
        List<StockGroup> filteredList = state.allStockGroupList.where((stockGroup) {
          // Check if the name of the stock group contains the search term
          // The `contains` method here is case-insensitive
          return stockGroup.name.toLowerCase().contains(event.keyword.toLowerCase());
        }).toList();

        // Add the filtered stock groups to the stockGroupList
        stockGroupList.addAll(filteredList);

        emit(state.copyWith(
          stockGroupList: stockGroupList,
          paginatorIndex: 0,
        ));
      }
    });

    on<FilterStockGroupList>((event, emit) {
      emit(state.copyWith(
        stockGroupList: state.stockGroupList.where((stockGroup) => stockGroup.id != event.stockGroupId).toList(),
      ));
    });

    _stockGroupChangeEventSubscription = _eventBus.on<StockGroupChangeEvent>().listen((e) {
      add(CmsStockGroupEvent.filterStockGroupList(e.stockGroupId));
    });

    @override
    Future<void> close() {
      _stockGroupChangeEventSubscription.cancel();
      return super.close();
    }
  }

  Future<Result<DataResponse<List<StockGroup>>, Exception>> _fetchCmsStockGroup({
    int? stockGroupId,
    int? page,
    int? size,
    String? sorts,
  }) {
    return _getCmsStockGroup(
      stockGroupId: stockGroupId,
      page: page ?? 1,
      size: size ?? apiLoadSize,
      // sorts: sorts,
    );
  }

  FutureOr<void> onCmsStockGroupOnInit(event, emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      final res = await _fetchCmsStockGroup(page: state.paging.page, size: state.paging.size);
      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          allStockGroupList: resData?.data,
          stockGroupList: resData?.data,
          paging: resData?.paging,
          totalCount: resData?.paging?.total,
          clearStockGroupId: true,
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorToastMessage: e.toString()));
    }
  }
}

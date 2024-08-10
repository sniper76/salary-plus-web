import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/stock_sort_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_stock/create_reference_dates.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stocks.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'cms_stock_event.dart';
part 'cms_stock_state.dart';

class CmsStockBloc extends Bloc<CmsStockEvent, CmsStockState> {
  final _getCmsStock = getIt<GetStocks>();
  final _createReferenceDates = getIt<CreateReferenceDates>();
  final _cmsCommonsData = getIt<CMSCommonsService>().cmsCommons;

  CmsStockBloc() : super(const CmsStockState()) {
    on<CmsStockOnInit>((event, emit) async {
      add(CmsStockEvent.fetchCmsStock(
        page: state.paging.page,
        size: state.paging.size,
        clearSimpleStock: true,
      ));
    });

    on<CmsStockOnSelectStock>((event, emit) async {
      add(CmsStockEvent.fetchCmsStock(
        page: 1,
        size: 0,
        stock: event.stock,
      ));
    });

    on<CmsStockOnPaginatorIndex>((event, emit) {
      emit(state.copyWith(
        paginatorIndex: event.paginatorIndex,
      ));
    });

    on<CmsStockOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }

      add(CmsStockEvent.fetchCmsStock(
        page: event.page,
      ));
    });

    on<ShowInfo>((event, emit) async {
      emit(state.copyWith(toastMessage: event.msg, isRegistered: !state.isRegistered));
    });

    on<SearchKeword>((event, emit) async {
      if (event.keyword == "") {
        emit(state.copyWith(cadiatedStockList: []));
      } else {
        final catidatedStockList = _cmsCommonsData?.stocks
            .where((stock) {
              String searchKeywordLower = event.keyword.toLowerCase();
              String stockCodeLower = stock.code.toLowerCase();
              String stockNameLower = stock.name.toLowerCase();

              return stockCodeLower.startsWith(searchKeywordLower) ||
                  (searchKeywordLower.length >= 2 && stockNameLower.contains(searchKeywordLower));
            })
            .map((data) => SimpleStock(code: data.code, name: data.name))
            .toList();
        emit(state.copyWith(cadiatedStockList: catidatedStockList));
      }
    });

    on<AssignStockReferencDate>((event, emit) async {
      if (state.seletedStock != null) {
        try {
          emit(state.copyWith(
            isLoading: true,
          ));
          final res = await _createReferenceDates(stockCode: state.seletedStock!.code, date: event.date);
          if (res.isSuccess()) {
            final resData = res.tryGetSuccess();
            emit(state.copyWith(
              isLoading: false,
              assingedStockReferenceDate: resData,
              isRegistered: !state.isRegistered,
            ));
            emit(state.copyWith());
          } else {
            final err = res.tryGetError();
            // EasyLoading.showToast('관리자로 등록되었습니다.');
            emit(state.copyWith(
              isLoading: false,
              errorToastMessage: "$err",
            ));
          }
        } catch (e) {
          emit(state.copyWith(isLoading: false));
        }
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: "Stock이 선택되지 않았습니다.",
        ));
      }
    });

    on<ChangeSortType>(
      (event, emit) async {
        if (event.changedSortType == state.selectedSortType) return;
        add(CmsStockEvent.fetchCmsStock(
          page: state.paging.page,
          size: state.paging.size,
          sortType: event.changedSortType,
        ));
      },
    );

    on<FetchCmsStock>((FetchCmsStock event, Emitter<CmsStockState> emit) async {
      emit(state.copyWith(isLoading: true));

      final Result result = await _fetchCmsStock(
        page: event.page,
        size: event.size,
        stock: event.stock,
        sortType: event.sortType,
      );

      if (result.isSuccess()) {
        final DataResponse<List<Stock>>? resData = result.tryGetSuccess();
        bool isStockSeleted = false;
        if (resData?.data != null && resData?.data?.length == 1) {
          isStockSeleted = true;
        }

        emit(state.copyWith(
          isLoading: false,
          stockList: resData?.data,
          paging: resData?.paging,
          totalCount: resData?.paging?.total,
          selectedSortType: event.sortType ?? state.selectedSortType,
          clearSimpleStock: event.clearSimpleStock ?? false,
          seletedStock: event.stock ?? state.seletedStock,
          errorToastMessage: null,
          isStockSeleted: isStockSeleted,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: result.tryGetError().toString(),
        ));
      }
    });
  }

  Future<Result<DataResponse<List<Stock>>, Exception>> _fetchCmsStock({
    int? page,
    int? size,
    SimpleStock? stock,
    StockSortType? sortType,
  }) {
    return _getCmsStock(
      page: page ?? 1,
      size: size ?? apiLoadSize,
      code: stock?.code ?? state.seletedStock?.code,
      sorts: sortType?.queryValue ?? state.selectedSortType.queryValue,
    );
  }
}

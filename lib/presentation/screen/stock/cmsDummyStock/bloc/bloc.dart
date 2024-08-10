import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/usecase/admin_stock/add_dummy_stock.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_reference_dates.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'event.dart';
part 'state.dart';

class CmsDummyBloc extends Bloc<CmsDummyEvent, CmsDummyState> {
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _referenceDay = getIt<GetReferenceDates>();
  final _addDummyStock = getIt<AddDummyStock>();

  CmsDummyBloc() : super(const CmsDummyState()) {
    on<OnInit>(_onInit);
    on<OnSelectedStock>(_onSelectedStock);
    on<OnSearchStock>(_onSearchStock);
    on<OnSearchKeyword>(_onSearchKeyword);
    on<OnGetReferenceDate>(_onGetStockReferenceDate);
    on<OnSelectedReferenceDate>(_onSelectedReferenceDate);
    on<OnAddDummyStock>(_onAddDummyStock);
  }

  void _onInit(OnInit event, emit) {
    add(const CmsDummyEvent.onSearchStock());
  }

  void _onSelectedStock(OnSelectedStock event, emit) {
    final selectedStock = event.selectedStock;
    emit(state.copyWith(selectedStock: selectedStock));
    add(CmsDummyEvent.onGetStockReferenceDate(selectedStock.code));
  }

  void _onGetStockReferenceDate(OnGetReferenceDate event, emit) async {
    emit(state.copyWith(isLoading: true));
    final resReferenceDates = await _referenceDay(stockCode: event.selectedStockCode);

    final data = resReferenceDates.tryGetSuccess()?.data ?? [];

    data.sort((a, b) => a.referenceDate.compareTo(b.referenceDate));

    emit(state.copyWith(
      isLoading: false,
      errorToastMessage: resReferenceDates.isError() ? resReferenceDates.tryGetError().toString() : null,
      referenceDates: resReferenceDates.isSuccess() ? data : null,
    ));
  }

  void _onSearchStock(OnSearchStock event, emit) {
    emit(state.copyWith(referenceDates: [], selectedReferenceDate: null));
    final filteredStockList = _cmsCommonsData.getFilteredCandidateStockList(state.searchKeyword);
    emit(state.copyWith(simpleStockList: filteredStockList));
  }

  void _onSearchKeyword(OnSearchKeyword event, emit) {
    emit(state.copyWith(searchKeyword: event.searchText));
    add(const CmsDummyEvent.onSearchStock());
  }

  void _onSelectedReferenceDate(OnSelectedReferenceDate event, emit) {
    emit(state.copyWith(selectedReferenceDate: event.selectedReferenceDate));
  }

  void _onAddDummyStock(OnAddDummyStock event, emit) async {
    if (state.selectedStock?.code == null || state.selectedReferenceDate?.id == null) return;

    emit(state.copyWith(isLoading: true));
    final res = await _addDummyStock(
      userId: event.userId,
      stockCode: state.selectedStock!.code,
      stockReferenceDateId: state.selectedReferenceDate!.id,
    );

    emit(state.copyWith(
      isLoading: false,
      isComplete: res.isSuccess(),
      errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
    ));
  }
}

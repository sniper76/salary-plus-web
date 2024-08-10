import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/enum/digital_document_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/usecase/admin_acceptor/get_acceptance_list.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/download_digital_document_csv.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class AcceptanceListBloc extends Bloc<AcceptanceListEvent, AcceptanceListState> {
  final _getAcceptanceList = getIt<GetAcceptanceList>();
  final _downloadExcel = getIt<DownloadDigitalDocumentCsv>();

  AcceptanceListBloc() : super(const AcceptanceListState()) {
    on<OnInit>(onInit);
    on<OnSetSearchType>(onSetSearchType);
    on<OnSetSearchKeyword>(onSetSearchKeyword);
    on<OnGetAcceptanceList>(onGetAcceptanceList);
    on<OnDownloadExcel>(onDownloadExcel);
  }

  void onInit(OnInit event, emit) {
    add(const AcceptanceListEvent.onGetAcceptanceList());
  }

  void onSetSearchType(OnSetSearchType event, emit) {
    emit(state.copyWith(searchType: event.searchType));
  }

  void onSetSearchKeyword(OnSetSearchKeyword event, emit) {
    emit(state.copyWith(searchKeyword: event.searchKeyword));
  }

  void onGetAcceptanceList(OnGetAcceptanceList event, emit) async {
    emit(state.copyWith(isLoading: true));

    final acceptanceList = await _getAcceptanceList(
      digitalDocumentType: event.documentType.value,
      searchType: event.searchType?.value ?? BoardSearchType.title.value,
      searchKeyword: event.searchKeyword ?? '',
      page: event.page ?? 1,
      size: apiLoadSize,
    );

    emit(state.copyWith(
      isLoading: false,
      documentList: acceptanceList.isSuccess() ? acceptanceList.tryGetSuccess()?.data ?? [] : null,
      errorToastMessage: acceptanceList.tryGetError()?.toString(),
      paging: acceptanceList.isSuccess() ? acceptanceList.tryGetSuccess()?.paging : null,
    ));
  }

  void onDownloadExcel(OnDownloadExcel event, emit) async {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final res = await _downloadExcel(digitalDocumentId: event.documentId);
    emit(state.copyWith(isLoading: false, errorToastMessage: res.isError() ? res.tryGetError().toString() : null));
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/domain/model/enum/digital_document_sort_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_digital_document_users.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_user_digital_document_pdf.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'doc_event.dart';
part 'doc_state.dart';

class DigitalDocumentBloc extends Bloc<DigitalDocumentEvent, DigitalDocumentState> {
  final _getUsers = getIt<GetDigitalDocumentUsers>();
  final _getPDF = getIt<GetUserDigitalDocumentPdf>();

  DigitalDocumentBloc(int documentId) : super(DigitalDocumentState(documentId: documentId)) {
    on<DigitalDocumentOnInit>(onDigitalDocumentOnInit);

    on<DigitalDocumentOnSetSearchKeyword>((event, emit) async {
      emit(state.copyWith(
        searchKeyword: event.searchKeyword,
      ));
    });

    on<DigitalDocumentOnFetchList>((event, emit) async {
      if (state.isLoading) return;
      emit(state.copyWith(isLoading: true));

      final res = await _getUsers(
        digitalDocumentId: state.documentId,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        page: event.page,
        size: event.size,
        sort: DigitalDocumentSortType.issuedNumber,
      );
      if (res.isSuccess()) {
        final users = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          userList: users?.data,
          paging: users?.paging,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<DigitalDocumentOnGetPDF>((event, emit) async {
      if (state.isLoading) return;
      emit(state.copyWith(isLoading: true));

      final res = await _getPDF(
        userId: event.userID,
        digitalDocumentId: event.digitalDocumentID,
      );

      if (res.isSuccess()) {
        final users = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          pdfUrl: users,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });
  }

  FutureOr<void> onDigitalDocumentOnInit(event, emit) async {
    if (state.isLoading) return;

    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      final res = await _getUsers(digitalDocumentId: state.documentId, sort: DigitalDocumentSortType.issuedNumber);

      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        emit(state.copyWith(isLoading: false, userList: resData?.data, paging: resData?.paging));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: "[docID: ${state.documentId.toString()}] ${res.tryGetError()} ",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: e.toString(),
      ));
    }
  }
}

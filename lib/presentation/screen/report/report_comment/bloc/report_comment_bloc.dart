import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/report_status_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/report_list.dart';
import 'package:act_cms/domain/usecase/admin_post/get_reports.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'report_comment_event.dart';
part 'report_comment_state.dart';

class ReportCommentBloc extends Bloc<ReportCommentEvent, ReportCommentState> {
  final _getReportComment = getIt<GetReports>();

  ReportCommentBloc() : super(const ReportCommentState()) {
    on<ReportCommentOnInit>(onReportCommentOnInit);

    on<ReportCommentOnSetStatus>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        reportStatus: event.reportStatus,
        paging: state.paging.copyWith(page: 1),
      ));
    });

    on<FetchReportComment>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final res = await _fetchReportComment(
        reportStatus: (event.reportStatus == ReportStatusType.all.value) //
            ? null //
            : event.reportStatus ?? state.reportStatus.value,
        page: event.page,
        size: event.size,
      );

      if (res.isSuccess()) {
        final users = res.tryGetSuccess();
        emit(state.copyWith(
          reportList: users?.data,
          paging: users?.paging,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<PostOnPageRefresh>((event, emit) {
      emit(state.copyWith(
        refreshPage: !state.refreshPage,
      ));
    });
  }

  Future<Result<DataResponse<List<ReportList>>, Exception>> _fetchReportComment({
    String? reportStatus,
    int? page,
    int? size,
  }) {
    return _getReportComment(
      reportType: "COMMENT",
      reportStatus: reportStatus,
      page: page ?? 1,
      size: apiLoadSize,
    );
  }

  FutureOr<void> onReportCommentOnInit(event, emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      final res = await _fetchReportComment(
        page: state.paging.page,
        size: apiLoadSize,
      );
      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          reportList: resData?.data,
          paging: resData?.paging,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
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

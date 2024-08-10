import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/report_detail.dart';
import 'package:act_cms/domain/usecase/admin_post/get_report_detail.dart';
import 'package:act_cms/domain/usecase/admin_post/update_report_status.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final String reportType;
  final int reportId;
  final _getReportPost = getIt<GetReportDetail>();
  final _updateStatus = getIt<UpdateReportStatus>();

  PostBloc(this.reportType, this.reportId) : super(const PostState()) {
    on<PostOnInit>(onPostOnInit);

    on<PostOnSetReason>((event, emit) async {
      emit(state.copyWith(reason: event.reason));
    });

    on<PostOnUpdateState>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        final res = await _updateStatus(
          changeReportStatus: event.changeReportStatus,
          currentReportStatus: event.currentReportStatus,
          reportType: event.type,
          result: event.result,
          reportId: event.reportId,
        );

        if (res.isSuccess()) {
          final resData = res.tryGetSuccess();
          emit(state.copyWith(isLoading: false, reportDetail: resData));
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
    });
  }

  Future<Result<ReportDetail, Exception>> _fetchPost({
    required String reportType,
    required int reportId,
  }) {
    return _getReportPost(
        reportId: reportId, // 23,
        reportType: reportType //"POST"
        );
  }

  FutureOr<void> onPostOnInit(event, emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final res = await _fetchPost(
        reportType: reportType,
        reportId: reportId,
      );
      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        emit(state.copyWith(isLoading: false, reportDetail: resData));
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

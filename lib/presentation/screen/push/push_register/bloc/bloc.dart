import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/enum/push/push_link_type.dart';
import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:act_cms/domain/model/enum/push/push_target_type.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/usecase/admin_push/create_push.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class PushBloc extends Bloc<PushEvent, PushState> {
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _createPush = getIt<CreatePush>();

  PushBloc() : super(const PushState()) {
    on<PushOnSetTargetSearchType>((event, emit) async {
      emit(state.copyWith(
        targetSearchType: event.searchType,
        targetSearchKeyword: "",
        selectedSimpleStock: (event.searchType == PushTargetType.all || event.searchType == PushTargetType.stock_group)
            ? null
            : state.selectedSimpleStock,
        selectedSimpleStockGroup: (event.searchType == PushTargetType.all || event.searchType == PushTargetType.stock)
            ? null
            : state.selectedSimpleStockGroup,
        clearSelectedSimpleStock: true,
        clearSelectedSimpleStockGroup: true,
      ));
    });

    on<PushOnSetTargetSearchKeyword>((event, emit) async {
      final searchKeyword = event.searchKeyword;

      if (state.targetSearchType == PushTargetType.stock) {
        emit(state.copyWith(
          targetCandidateStockList: _cmsCommonsData.getFilteredCandidateStockList(searchKeyword),
          targetSearchKeyword: searchKeyword,
        ));
      } else {
        emit(state.copyWith(
          targetCandidateStockGroupList: _cmsCommonsData.getFilteredCandidateStockGroupList(searchKeyword),
          targetSearchKeyword: searchKeyword,
        ));
      }
    });

    on<PushOnSetData>((event, emit) async {
      emit(state.copyWith(
        title: event.title ?? state.title,
        postId: event.targetLinkPostId ?? state.postId,
        targetLinkType: event.targetLinkType ?? state.targetLinkType,
        sendType: event.sendType ?? state.sendType,
        targetDatetime: event.dateTime ?? state.targetDatetime,
        content: event.content ?? state.content,
        selectedSimpleStockGroup: event.stockGroup ?? state.selectedSimpleStockGroup,
        selectedSimpleStock: event.stock ?? state.selectedSimpleStock,
      ));
    });

    on<PushOnPost>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final res = await _createPush(
        title: state.title,
        content: state.content,
        stockCode: state.selectedSimpleStock?.code,
        stockGroupId: state.selectedSimpleStockGroup?.id,
        stockTargetType: state.targetSearchType.value,
        sendType: state.sendType.value,
        postId: state.targetLinkType == PushLinkType.link ? state.postId : null,
        linkType: state.targetLinkType.value,
        targetDatetime: state.targetDatetime ?? DateTime.now(),
      );

      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          isComplete: true,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });
  }
}

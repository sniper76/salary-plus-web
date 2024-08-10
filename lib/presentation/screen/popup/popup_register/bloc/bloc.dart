import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/enum/popup/popup_display_target_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_link_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_stock_target_type.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/usecase/admin_popup/create_popup.dart';
import 'package:act_cms/domain/usecase/admin_popup/update_popup.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class PopupBloc extends Bloc<PopupEvent, PopupState> {
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _createPopup = getIt<CreatePopup>();
  final _updatePopup = getIt<UpdatePopup>();

  PopupBloc() : super(const PopupState()) {
    on<PopupOnInit>((event, emit) {
      emit(state.copyWith(isLoading: true));

      if (event.updatePopup != null) {
        emit(
          state.copyWith(
            targetStockType: event.updatePopup!.stockTargetType,
            displayTargetType: event.updatePopup!.displayTargetType,
            targetLinkType: event.updatePopup!.linkType,
            targetStartDatetime: event.updatePopup!.targetStartDatetime,
            targetEndDatetime: event.updatePopup!.targetEndDatetime,
            selectedStockCode: event.updatePopup?.stockCode,
            selectedStockGroupId: event.updatePopup?.stockGroupId,
          ),
        );
      }

      emit(state.copyWith(isLoading: false));
    });

    on<PopupOnSetStockType>((event, emit) async {
      emit(state.copyWith(targetStockType: event.targetStockType));
    });

    on<PopupOnSetStockCode>((event, emit) async {
      emit(state.copyWith(selectedStockCode: event.stockCode));
    });

    on<PopupOnSetStockGroupId>((event, emit) async {
      emit(state.copyWith(selectedStockGroupId: event.stockGroupId));
    });

    on<PopupOnSetDisplayType>((event, emit) async {
      emit(state.copyWith(displayTargetType: event.displayTargetType));
    });

    on<PopupOnSetLinkType>((event, emit) async {
      emit(state.copyWith(targetLinkType: event.targetLinkType));
    });

    on<PopupOnSetStartDatetime>((event, emit) async {
      emit(state.copyWith(targetStartDatetime: event.newDate));
    });

    on<PopupOnSetEndDatetime>((event, emit) async {
      emit(state.copyWith(targetEndDatetime: event.newDate));
    });

    on<PopupOnSetTargetSearchKeyword>((event, emit) async {
      if (state.targetStockType == PopupStockTargetType.stock) {
        if (event.searchKeyword == "") {
          emit(state.copyWith(targetCandidateStockList: [], targetSearchKeyword: event.searchKeyword));
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
          emit(state.copyWith(
            targetCandidateStockList: candidatedStockList,
            targetSearchKeyword: event.searchKeyword,
          ));
        }
      } else {
        if (event.searchKeyword == "") {
          emit(state.copyWith(targetCandidateStockList: [], targetSearchKeyword: event.searchKeyword));
        } else {
          final keyword = event.searchKeyword.toLowerCase();
          final candidatedStockList = _cmsCommonsData.cmsCommons?.stockGroups
              .where((stock) => stock.name.toLowerCase().contains(keyword))
              .map((data) => SimpleStockGroup(id: data.id, name: data.name))
              .toList();

          emit(state.copyWith(
            targetCandidateStockGroupList: candidatedStockList,
            targetSearchKeyword: event.searchKeyword,
          ));
        }
      }
    });

    on<PopupOnSave>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      Future<Result<Popup, Exception>> savePopupAsync = event.popupId == null
          ? _createPopup(
              title: event.title,
              content: event.content,
              displayTargetType: event.displayTargetType,
              stockTargetType: event.stockTargetType,
              linkType: event.linkType,
              targetStartDatetime: event.targetStartDatetime,
              targetEndDatetime: event.targetEndDatetime,
              stockCode: event.stockTargetType == PopupStockTargetType.stock ? event.stockCode : null,
              stockGroupId: event.stockTargetType == PopupStockTargetType.stock_group ? event.stockGroupId : null,
              linkTitle: event.linkTitle,
              postId: event.postId)
          : _updatePopup(
              popupId: event.popupId!,
              title: event.title,
              content: event.content,
              displayTargetType: event.displayTargetType,
              stockTargetType: event.stockTargetType,
              linkType: event.linkType,
              targetStartDatetime: event.targetStartDatetime,
              targetEndDatetime: event.targetEndDatetime,
              stockCode: event.stockTargetType == PopupStockTargetType.stock ? event.stockCode : null,
              stockGroupId: event.stockTargetType == PopupStockTargetType.stock_group ? event.stockGroupId : null,
              linkTitle: event.linkTitle,
              postId: event.postId);

      final res = await savePopupAsync;

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

  FutureOr<void> onPopupInit(event, emit) {}
}

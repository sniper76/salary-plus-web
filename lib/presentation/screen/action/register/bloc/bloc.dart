import 'dart:async';
import 'dart:html';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/digital_proxy.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/action_document_type.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/digital_document_type.dart';
import 'package:act_cms/domain/model/enum/poll_selection_type.dart';
import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/domain/model/enum/post_target_search_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/poll_register_result.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_campaign/create_campaign.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_document_preview.dart';
import 'package:act_cms/domain/usecase/admin_post/create_post.dart';
import 'package:act_cms/domain/usecase/admin_stock/create_reference_dates.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_reference_dates.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stock_detail.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:act_cms/core/util/toast_message_utils.dart';

part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final int maxUploadFileCount = 1;
  final bool isActionExclusiveToHolders = true;

  final _createActionPost = getIt<CreateAdminPost>();
  final _createCampaignPost = getIt<CreateCampaign>();
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _getDocumentPreview = getIt<GetDocumentPreview>();
  final _getStockDetail = getIt<GetStockDetail>();
  final _authService = getIt<UserAuthService>();
  final _referenceDay = getIt<GetReferenceDates>();
  final _createReferenceDay = getIt<CreateReferenceDates>();

  // final BoardGroupType boardGroupType;

  PostBloc() : super(const PostState()) {
    on<PostSaveOnInit>((event, emit) async {
      final user = _authService.userMe;
      emit(state.copyWith(
        user: user,
        postType: event.postType,
        pollResults: [PollRegisterResult(title: '', startedAt: DateTime.now())],
        selectedDigitalDocumentCategory: DigitalDocumentType.getDigitalDocumentType(event.postType).first,
      ));
    });

    on<PostSaveOnSearchStock>((event, emit) async {
      if (event.keyword == "") {
        emit(state.copyWith(targetCandidateStockList: []));
      } else {
        final catidatedStockList = _cmsCommonsData.cmsCommons?.stocks
            .where((stock) {
              String searchKeywordLower = event.keyword.toLowerCase();
              String stockCodeLower = stock.code.toLowerCase();
              String stockNameLower = stock.name.toLowerCase();

              return stockCodeLower.startsWith(searchKeywordLower) ||
                  (searchKeywordLower.length >= 2 && stockNameLower.contains(searchKeywordLower));
            })
            .map((data) => SimpleStock(code: data.code, name: data.name))
            .toList();
        emit(state.copyWith(targetCandidateStockList: catidatedStockList));
      }
    });

    on<PostSaveOnSearchStockGroup>((event, emit) async {
      if (event.keyword == "") {
        emit(state.copyWith(targetCandidateStockGroupList: []));
      } else {
        final keyword = event.keyword.toLowerCase();
        final catidatedStockList = _cmsCommonsData.cmsCommons?.stockGroups
            .where((stockGroup) => stockGroup.name.toLowerCase().contains(keyword))
            .map((data) => SimpleStockGroup(id: data.id, name: data.name))
            .toList();
        emit(state.copyWith(targetCandidateStockGroupList: catidatedStockList));
      }
    });

    on<ClearToastMsg>((event, emit) async {
      emit(state.copyWith(
        completeMsg: "",
      ));
    });

    on<PostSaveOnSetTitle>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        title: event.title,
      ));
    });

    on<PostSaveOnSetCampaignTitle>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        campaignTitle: event.title,
      ));
    });

    on<PostOnSelectStockGroup>((event, emit) {
      emit(state.copyWith(stockGroup: event.stockGroup, targetCandidateStockList: []));
    });

    on<PostOnSelectStock>((event, emit) async {
      if (state.isLoading) return;
      emit(state.copyWith(
        isLoading: true,
      ));

      final res = await _getStockDetail(code: event.stock.code);
      if (res.isSuccess()) {
        emit(state.copyWith(stockCode: event.stock, stockDetail: res.tryGetSuccess(), targetCandidateStockList: []));
      } else {
        emit(
            state.copyWith(stockCode: event.stock, stockDetail: null, errorToastMessage: res.tryGetError().toString()));
        return;
      }

      final resReferenceDates = await _referenceDay(stockCode: event.stock.code);

      if (resReferenceDates.isSuccess()) {
        final List<StockReferenceDate> newList = resReferenceDates.tryGetSuccess()?.data ?? [];

        List<StockReferenceDate> selectReferenceTime = [...newList];
        selectReferenceTime.sort((a, b) => b.referenceDate.compareTo(a.referenceDate));

        emit(state.copyWith(
          stockReferenceDateList: selectReferenceTime,
          selectedReferenceDay: filterLastYear(selectReferenceTime).first,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          errorToastMessage: res.tryGetError().toString(),
          isLoading: false,
        ));
      }
    });

    on<PostOnSetReferenceDay>((event, emit) {
      emit(state.copyWith(
        selectedReferenceDay: event.day,
      ));
    });

    on<PostOnAddPoll>((event, emit) {
      emit(
        state.copyWith(
          pollResults: [
            ...state.pollResults,
            PollRegisterResult(title: '', startedAt: DateTime.now()),
          ],
        ),
      );
    });

    on<PostOnEditPoll>((event, emit) {
      final newPollResults = state.pollResults.mapIndexed((index, pollResult) {
        if (event.pollId == index) {
          return pollResult.copyWith(
            title: event.title ?? pollResult.title,
            content: event.content ?? pollResult.content,
            pollItems: event.items ?? pollResult.pollItems,
            selectionType: event.selectionType ?? pollResult.selectionType,
            voteType: event.voteType ?? pollResult.voteType,
            startedAt: event.startedAt ?? pollResult.startedAt,
            endedAt: event.endedAt ?? pollResult.endedAt,
          );
        }
        return pollResult;
      });
      emit(state.copyWith(pollResults: newPollResults.toList()));
    });

    on<PostOnDeletePoll>((event, emit) {
      emit(
          state.copyWith(pollResults: state.pollResults.whereIndexed((index, _) => index != event.pollIndex).toList()));
    });

    on<PostOnCreateReferenceDay>((event, emit) async {
      if (state.isLoading || state.stockCode == null) return;
      emit(state.copyWith(isLoading: true));

      final res = await _createReferenceDay(
        stockCode: state.stockCode!.code,
        date: event.date,
      );
      if (res.isSuccess()) {
        final newReferenceDay = res.tryGetSuccess();

        final resReferenceDates = await _referenceDay(stockCode: state.stockCode!.code);

        final List<StockReferenceDate> newList = resReferenceDates.tryGetSuccess()?.data ?? [];
        StockReferenceDate? selectReferenceTime = newList.firstWhere(
          (element) =>
              element.referenceDate.year == newReferenceDay!.referenceDate.year &&
              element.referenceDate.month == newReferenceDay.referenceDate.month &&
              element.referenceDate.day == newReferenceDay.referenceDate.day,
        );

        if (resReferenceDates.isSuccess()) {
          emit(state.copyWith(
            stockReferenceDateList: resReferenceDates.tryGetSuccess()?.data ?? [],
            selectedReferenceDay: selectReferenceTime,
          ));
        } else {
          emit(state.copyWith(errorToastMessage: res.tryGetError().toString()));
        }
      } else {
        emit(state.copyWith(errorToastMessage: res.tryGetError().toString()));
      }
      emit(state.copyWith(isLoading: false));
    });

    on<PostSaveOnChangedPostSearchType>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        targetSearchType: event.postSearchType,
      ));
    });

    on<PostSaveOnSetActionDocType>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        selectedActionDocumentType: event.actionDocumentType,
      ));
    });
    on<PostSaveOnSetDigitalDocumentCategory>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        selectedDigitalDocumentCategory: event.category,
      ));
    });

    on<PostSaveOnSetActionPreview>((event, emit) async {
      if (state.isLoading) return;
      try {
        if (event.isPreviewOn) {
          emit(state.copyWith(
            isLoading: true,
          ));
          final result = await _getDocumentPreview(
            type: event.type ?? "DIGITAL_PROXY",
            title: event.title,
            content: event.content,
            acceptUserId: event.acceptUserId,
            shareholderMeetingType: event.shareholderMeetingType,
            shareholderMeetingName: event.shareholderMeetingName,
            shareholderMeetingDate: event.shareholderMeetingDate,
            designatedAgentNames: event.designatedAgentNames,
            companyName: event.companyName ?? state.stockCode?.name,
            companyRegistrationNumber: event.companyRegistrationNumber,
            digitalDocumentList: event.digitalDocumentList,
            version: state.selectedDigitalDocumentCategory.version,
          );

          if (result.isSuccess()) {
            emit(state.copyWith(isLoading: false, isPreviewOn: event.isPreviewOn, pdf: result.tryGetSuccess()));
          } else {
            emit(state.copyWith(isLoading: false, errorToastMessage: result.tryGetError().toString()));
          }
        } else {
          emit(state.copyWith(isLoading: false, isPreviewOn: event.isPreviewOn));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorToastMessage: e.toString()));
      }
    });

    on<PostActionOnSave>((event, emit) async {
      if (state.isLoading) return;

      final boardGroupCategory = event.boardGroupCategory;
      final title = event.title;
      final content = event.content;
      final uploadImages = state.uploadImageFiles;
      final stockCode = state.stockCode?.code ?? AppConfig.globalBoardCode;

      emit(state.copyWith(isLoading: true));

      Future<Result<Post, Exception>> savePostAsync = _createActionPost(
        stockCode: stockCode,
        boardGroupType: state.boardGroupType,
        boardGroupCategory: boardGroupCategory,
        title: title,
        content: content,
        isNotification: event.isNotification,
        isExclusiveToHolders: isActionExclusiveToHolders,
        uploadImages: uploadImages,
        polls: event.polls,
        digitalProxy: event.digitalProxy,
        digitalDocument: event.digitalDocument,
        isActive: true, //TODO register 화면에서 노출여부 추가 후 변경 필요
        isEscaped: true,
      );

      final res = await savePostAsync;

      if (res.isSuccess()) {
        emit(state.copyWith(isLoading: false, updatedPost: res.tryGetSuccess(), completeMsg: "게시물이 등록되었습니다. "));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    });

    on<PostCampaignOnSave>((event, emit) async {
      if (state.isLoading) return;
      emit(state.copyWith(isLoading: true));
      final stockGroup = state.stockGroup;

      final res = await _createCampaignPost(
        stockGroupId: stockGroup!.id,
        boardGroupName: stockGroup.name,
        boardGroupCategory: event.boardGroupCategory,
        title: event.title,
        campaignTitle: state.campaignTitle ?? '',
        content: event.content,
        isNotification: event.isNotification,
        polls: event.polls,
        digitalProxy: event.digitalProxy,
        digitalDocument: event.digitalDocument,
        isEscaped: true,
      );

      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          completeMsg: "게시물이 등록되었습니다. ",
        ));
      } else {
        emit(state.copyWith(
            isLoading: false,
            errorToastMessage: ToastMessageUtils.getDuplicateAndCampaignCreateTimeoutMessage(res)
        ));
      }
    });

    on<PostSaveOnSetIsNotification>((event, emit) async {
      emit(state.copyWith(
        isNotification: event.isNotification,
      ));
    });
  }

  List<StockReferenceDate> filterLastYear(List<StockReferenceDate> dates) {
    DateTime now = DateTime.now();
    int lastYear = now.year - 1;

    Iterable<StockReferenceDate> iter = dates.where((element) => element.referenceDate.year == lastYear);
    if (iter.isEmpty) {
      return dates;
    }

    return iter.toList();
  }
}

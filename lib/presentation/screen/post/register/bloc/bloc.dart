import 'dart:async';
import 'dart:io';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/exception_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/usecase/admin_campaign/update_campaign.dart';
import 'package:act_cms/domain/usecase/admin_post/create_post.dart';
import 'package:act_cms/domain/usecase/admin_post/update_post.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _createPost = getIt<CreateAdminPost>();
  final _updatePost = getIt<UpdatePost>();
  final _updateCampaign = getIt<UpdateCampaign>();
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final int maxUploadFileCount = 1;

  PostBloc(
      {required BoardGroupType boardGroupType,
      Post? updatePost,
      Stock? updateStock,
      SimpleStockGroup? updateStockGroup,
      String? campaignTitle})
      : super(const PostState()) {
    on<OnInit>((event, emit) async {
      final boardCategoryList = _cmsCommonsData.getCategoryByBoardGroup(boardGroupType);
      boardCategoryList.removeWhere((category) => category.displayName == '전체');
      if (updatePost != null) {
        emit(state.copyWith(
            boardCategoryList: boardCategoryList,
            boardGroupType: boardGroupType,
            title: updatePost.title,
            stockCode: updateStock != null ? SimpleStock(code: updateStock.code, name: updateStock.name) : null,
            stockCodeGroup: updateStockGroup,
            selectedBoardGroupCategory: updatePost.boardGroupCategory,
            isActive: updatePost.isActive,
            isExclusiveToHolders: updatePost.isExclusiveToHolders,
            content: updatePost.content,
            updatedPost: updatePost,
            pollTargetDate: updatePost.polls?.firstOrNull?.targetEndDate,
            digitalProxyTargetDate: updatePost.digitalProxy?.targetEndDate,
            digitalDocumentTargetDate: updatePost.digitalDocument?.targetEndDate,
            campaignTitle: campaignTitle));
      } else {
        emit(state.copyWith(boardCategoryList: boardCategoryList, boardGroupType: boardGroupType));
      }
    });

    on<OnChangedCategory>((event, emit) async {
      emit(state.copyWith(
        selectedBoardGroupCategory: event.boardGroupCategory,
      ));
    });

    on<OnSetIsActive>((event, emit) async {
      emit(state.copyWith(
        isActive: event.isActive,
      ));
    });

    on<OnSetIsExclusiveToUsers>((event, emit) async {
      emit(state.copyWith(
        isExclusiveToHolders: event.isExclusiveToHolders,
      ));
    });

    on<OnSetIsNotification>((event, emit) async {
      emit(state.copyWith(
        isNotification: event.isNotification,
      ));
    });

    on<OnUploadImage>((event, emit) async {
      if (state.isLoading) return;

      if (state.uploadImageFiles.length >= maxUploadFileCount) {
        emit(state.copyWith(errorToastMessage: '이미지 업로드 최대 갯수($maxUploadFileCount)를 초과 하였 습니다'));
        return;
      }
    });

    on<OnDeleteUploadImage>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        isLoading: false,
        uploadImageFiles: [],
      ));
    });

    on<OnSearchStock>((event, emit) async {
      if (event.stockSearchKeyword == "") {
        emit(state.copyWith(candiatedStockList: []));
      } else {
        if (event.isStockGroup) {
          emit(state.copyWith(
              candidateStockGroupList: _cmsCommonsData.getFilteredCandidateStockGroupList(event.stockSearchKeyword)));
        } else {
          emit(state.copyWith(
              candiatedStockList: _cmsCommonsData.getFilteredCandidateStockList(event.stockSearchKeyword)));
        }
      }
    });

    on<OnSetTitle>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        title: event.title,
      ));
    });
    on<OnSetCampaignTitle>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(campaignTitle: event.campaignTitle));
    });

    on<OnSelectStock>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        stockCode: event.stock,
      ));
    });

    on<OnSelectStockGroup>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        stockCodeGroup: event.stockGroup,
      ));
    });

    on<OnUpdateTargetDate>((event, emit) async {
      emit(state.copyWith(
        pollTargetDate: state.pollTargetDate == null ? null : event.date,
        digitalProxyTargetDate: state.digitalProxyTargetDate == null ? null : event.date,
        digitalDocumentTargetDate: state.digitalDocumentTargetDate == null ? null : event.date,
      ));
    });

    on<OnSavePost>((event, emit) async {
      if (state.isLoading || state.selectedBoardGroupCategory == null) return;

      final title = event.title;
      final content = event.content;
      final isNotification = event.isNotification;

      emit(state.copyWith(isLoading: true));
      Future<Result<Post, Exception>> savePostAsync = state.updatedPost != null
          ? updateContent(title: title, content: content, isNotification: isNotification, isActive: state.isActive)
          : createdPost(
              title: title,
              content: content,
              isNotification: isNotification,
              polls: event.polls,
              digitalProxy: event.digitalProxy,
            );

      final res = await savePostAsync;

      final updatedPost = res.tryGetSuccess();

      emit(state.copyWith(
        isLoading: false,
        updatedPost: updatedPost,
        onClose: true,
        errorToastMessage: res.tryGetError()?.message,
        isComplete: res.isSuccess() ? true : false,
      ));
    });

    on<OnUpdateCampaign>((event, emit) async {
      if (state.isLoading || state.selectedBoardGroupCategory == null) return;

      final title = event.title;
      final content = event.content;
      final isNotification = event.isNotification;

      emit(state.copyWith(isLoading: true));
      final res =
          await updateContent(title: title, content: content, isNotification: isNotification, isActive: state.isActive);

      final updatedCampaign = res.tryGetSuccess()?.data;
      final newPost = updatedCampaign != null
          ? Post(
              id: updatedCampaign.sourcePost!.id,
              title: updatedCampaign.title,
              createdAt: updatedCampaign.createdAt,
              updatedAt: updatedCampaign.updatedAt,
              status: updatedCampaign.sourcePost?.status ?? state.updatedPost?.status,
              content: updatedCampaign.sourcePost?.content ?? state.content,
              userProfile: updatedCampaign.sourcePost!.userProfile,
              boardGroupCategory: updatedCampaign.sourcePost?.boardCategory,
              boardGroupType: updatedCampaign.sourcePost?.boardGroup ?? BoardGroupType.action,
              isActive: updatedCampaign.sourcePost?.isActive ?? state.isActive,
              userId: updatedCampaign.sourcePost?.userId ?? 0,
              polls: updatedCampaign.sourcePost?.polls,
              digitalDocument: updatedCampaign.sourcePost?.digitalDocument,
            )
          : null;
      emit(state.copyWith(
        isLoading: false,
        updatedPost: newPost,
        onClose: true,
        errorToastMessage: res.tryGetError()?.message,
        isComplete: res.isSuccess() ? true : false,
      ));
    });
  }

  updateContent({required String title, required String content, bool isNotification = false, bool isActive = true}) {
    return state.stockCodeGroup != null
        ? _updateCampaign(
            content: content,
            isActive: isActive,
            title: title,
            isNotification: isNotification,
            campaignId: state.updatedPost?.id ?? 0,
            boardGroupCategory: state.selectedBoardGroupCategory!,
            campaignTitle: state.campaignTitle ?? '',
            stockGroupId: state.stockCodeGroup?.id ?? 0,
            uploadImages: state.uploadImageFiles,
            pollTargetEndDate: state.pollTargetDate,
            digitalProxyTargetEndDate: state.digitalProxyTargetDate,
            digitalDocumentTargetEndDate: state.digitalDocumentTargetDate,
            isEscaped: true,
          )
        : _updatePost(
            stockCode: state.stockCode?.code ?? AppConfig.globalBoardCode,
            boardGroupType: state.boardGroupType,
            boardGroupCategory: state.selectedBoardGroupCategory!,
            postId: state.updatedPost!.id,
            title: title,
            content: content,
            uploadImages: state.uploadImageFiles,
            pollIds: state.updatedPost?.polls?.map((Poll poll) => poll.id).toList(),
            pollTargetEndDate: state.pollTargetDate,
            digitalProxyTargetEndDate: state.digitalProxyTargetDate,
            digitalDocumentTargetEndDate: state.digitalDocumentTargetDate,
            isNotification: isNotification,
            isActive: isActive,
            isExclusiveToHolders: state.isExclusiveToHolders,
            isEscaped: true,
          );
  }

  Future<Result<Post, Exception>> createdPost({
    required String title,
    required String content,
    bool isNotification = false,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
  }) {
    final boardGroupCategory = state.selectedBoardGroupCategory;
    final isActive = state.isActive;
    final uploadImages = state.uploadImageFiles;
    final stockCode = state.stockCode?.code ?? AppConfig.globalBoardCode;
    return _createPost(
      stockCode: stockCode,
      boardGroupType: state.boardGroupType,
      boardGroupCategory: boardGroupCategory!,
      title: title,
      content: content,
      isActive: isActive,
      isNotification: isNotification,
      isExclusiveToHolders: state.isExclusiveToHolders,
      uploadImages: uploadImages,
      polls: polls,
      digitalProxy: digitalProxy,
      isEscaped: true,
    );
  }
}

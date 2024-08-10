import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/enum/post_target_search_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/usecase/admin_post/duplicate_post.dart';
import 'package:act_cms/domain/usecase/admin_post/duplicate_stcok_group_post.dart';
import 'package:act_cms/domain/usecase/admin_post/find_posts.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:act_cms/core/util/toast_message_utils.dart';

part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostStatusType _defaultPostStatusTypeOnDuplicatePage = PostStatusType.active;

  final _getPosts = getIt<FindPosts>();
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _duplicatePostToGroup = getIt<DuplicatePost>();
  final _duplicatePostToStock = getIt<DuplicateStockGroupPost>();

  PostBloc(BoardGroupType boardGroupType)
      : super(PostState(boardCategory: BoardGroupCategory.defaultCategory(), boardGroup: boardGroupType)) {
    // boardGroup: BoardGroupType.globalboard)) {
    on<PostOnInit>(onPostOnInit);

    on<PostOnSetSourceSearchKeyword>((event, emit) async {
      if (state.sourceSearchType == BoardSearchType.stockcode) {
        if (event.searchKeyword == "") {
          emit(state.copyWith(sourceCandidateStockList: [], sourceSearchKeyword: event.searchKeyword));
        } else {
          final candidatedStockList = _cmsCommonsData.cmsCommons?.stocks
              .where((stock) {
                String searchKeywordLower = event.searchKeyword.toLowerCase();
                String stockCodeLower = stock.code.toLowerCase();
                String stockNameLower = stock.name.toLowerCase();

                return stockCodeLower.startsWith(searchKeywordLower) || (stockNameLower.contains(searchKeywordLower));
              })
              .map((data) => SimpleStock(code: data.code, name: data.name))
              .toList();

          emit(state.copyWith(sourceCandidateStockList: candidatedStockList, sourceSearchKeyword: event.searchKeyword));
        }
      } else {
        emit(state.copyWith(sourceSearchKeyword: event.searchKeyword));
      }
    });

    on<PostOnSetSourceStock>((event, emit) async {
      emit(state.copyWith(
        sourceSimpleStock: event.stock,
      ));
    });

    on<PostOnSetTargetStock>((event, emit) async {
      emit(state.copyWith(
        targetSimpleStock: event.stock,
      ));
    });

    on<PostOnSetTargetStockGroup>((event, emit) async {
      emit(state.copyWith(
        targetStockGroup: event.stockGroup,
      ));
    });

    on<PostOnSelectPost>((event, emit) async {
      emit(state.copyWith(
        sourceSelectedPost: event.post,
      ));
    });

    on<PostOnSetSourceSearchType>((event, emit) async {
      emit(state.copyWith(
        sourceSearchType: event.searchType,
        sourceSearchKeyword: "",
        sourceSimpleStock: null,
      ));
    });

    // on<PostOnSetStockGroup>((event, emit) async {
    //   emit(state.copyWith(
    //     targetStockGroup: event.stockGroup,
    //   ));
    // });

    on<PostOnSetTargetSearchType>((event, emit) async {
      emit(state.copyWith(
        targetSearchType: event.searchType,
        targetSearchKeyword: "",
        targetSimpleStock: null,
        targetStockGroup: null,
      ));
    });

    on<PostOnSetTargetSearchKeyword>((event, emit) async {
      if (state.targetSearchType == BoardTargetSearchType.stockname) {
        if (event.searchKeyword == "") {
          emit(state.copyWith(targetCandidateStockList: [], targetSearchKeyword: event.searchKeyword));
        } else {
          final candidatedStockList = _cmsCommonsData.cmsCommons?.stocks
              .where((stock) {
                String searchKeywordLower = event.searchKeyword.toLowerCase();
                String stockCodeLower = stock.code.toLowerCase();
                String stockNameLower = stock.name.toLowerCase();

                return stockCodeLower.startsWith(searchKeywordLower) || (stockNameLower.contains(searchKeywordLower));
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

    on<PostOnFetchPost>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      String searchKeyword = state.sourceSearchKeyword;
      if (state.sourceSearchType == BoardSearchType.stockcode) {
        searchKeyword = state.sourceSimpleStock?.code ?? "";
      }

      final res = await _fetchPost(
        boardGroup: state.boardGroup,
        boardCategory: state.boardCategory,
        searchType: state.sourceSearchType,
        searchKeyword: searchKeyword,
        size: event.size,
        page: event.page,
      );

      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        if (resData?.data?.length == 1) {
          emit(state.copyWith(isLoading: false, sourceSelectedPost: resData?.data?[0], paging: resData?.paging));
        } else {
          emit(state.copyWith(isLoading: false, sourcePostList: resData?.data, paging: resData?.paging));
        }
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });

    on<PostOnLoadMore>((event, emit) async {
      String searchKeyword = event.searchKeyword ?? state.sourceSearchKeyword;

      if (state.sourceSearchType == BoardSearchType.stockcode) {
        searchKeyword = state.sourceSimpleStock?.code ?? "";
      }
      if (state.isLoading) {
        return;
      }

      emit(state.copyWith(isLoading: true));

      final res = await _fetchPost(
        boardGroup: state.boardGroup,
        boardCategory: state.boardCategory,
        searchType: state.sourceSearchType,
        searchKeyword: searchKeyword,
        size: event.size,
        page: event.page,
        sorts: event.sorts,
      );
      if (res.isSuccess()) {
        final pagingData = res.tryGetSuccess();

        emit(state.copyWith(
          isLoading: false,
          paging: pagingData?.paging,
          sourcePostList: pagingData?.data,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<PostOnDuplicatePostToStock>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      if (state.sourceSelectedPost == null || state.targetSimpleStock == null) {
        return;
      }

      final res =
          await _duplicatePostToStock(postId: state.sourceSelectedPost!.id, stockCode: state.targetSimpleStock!.code);
      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          isComplete: true,
        ));
      } else {
        emit(state.copyWith(
            isLoading: false,
            errorToastMessage: ToastMessageUtils.getDuplicateAndCampaignCreateTimeoutMessage(res)
        ));
      }
    });

    on<PostOnDuplicatePostToGroup>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      if (state.sourceSelectedPost == null || state.targetStockGroup == null) {
        return;
      }

      final res =
          await _duplicatePostToGroup(postId: state.sourceSelectedPost!.id, stockGroupId: state.targetStockGroup!.id);
      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          isComplete: true,
        ));
      } else {
        emit(state.copyWith(
            isLoading: false,
            errorToastMessage: ToastMessageUtils.getDuplicateAndCampaignCreateTimeoutMessage(res)
        ));
      }
    });
  }

  Future<Result<DataResponse<List<Post>>, Exception>> _fetchPost({
    required BoardGroupType boardGroup,
    BoardSearchType? searchType,
    BoardGroupCategory? boardCategory,
    String? searchKeyword,
    int? page,
    int? size,
    String? sorts,
  }) {
    return _getPosts(
      boardGroup: boardGroup,
      boardCategory: boardCategory,
      searchType: searchType,
      searchKeyword: searchKeyword,
      status: _defaultPostStatusTypeOnDuplicatePage,
      page: page ?? 1,
      size: size ?? apiLoadSize,
    );
  }

  FutureOr<void> onPostOnInit(event, emit) async {}
}

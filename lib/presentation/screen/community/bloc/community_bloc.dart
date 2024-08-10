import 'dart:async';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/usecase/admin_post/find_posts.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final _getPosts = getIt<FindPosts>();
  final _cmsCommonsData = getIt<CMSCommonsService>();

  CommunityBloc() : super(const CommunityState()) {
    on<CommunityOnInit>(onInit);

    on<CommunityOnSetSearchKeyword>((event, emit) async {
      emit(state.copyWith(
        searchKeyword: event.searchKeyword,
      ));
    });

    on<CommunityOnSetSearchType>((event, emit) async {
      emit(state.copyWith(
        searchType: event.searchType,
      ));
    });

    on<CommunityOnSetStatusType>((event, emit) async {
      emit(state.copyWith(
        postStatusType: event.postStatusType,
        paging: state.paging.copyWith(page: 1),
      ));
    });

    on<CommunityOnSetBoardCategory>((event, emit) async {
      emit(state.copyWith(
        boardCategory: event.boardCategory,
        paging: state.paging.copyWith(page: 1),
      ));
    });

    on<CommunityOnPageRefresh>((event, emit) {
      emit(state.copyWith(
        refreshPage: !state.refreshPage,
      ));
    });

    on<CommunityFetchPost>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final res = await _getPosts(
        boardGroup: state.boardGroup,
        boardCategory: state.boardCategory,
        searchType: state.searchType,
        searchKeyword: state.searchKeyword,
        status: state.postStatusType,
        page: event.page,
        size: event.size,
      );

      if (res.isSuccess()) {
        final pagingData = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          paging: pagingData?.paging,
          postList: pagingData?.data ?? [],
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });
  }

  FutureOr<void> onInit(event, emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final boardGroupCategoryList = _cmsCommonsData.getCategoryByBoardGroup(state.boardGroup);

      final res = await _getPosts(
        boardGroup: state.boardGroup,
        page: state.paging.page,
        size: state.paging.size,
      );

      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          boardCategoryList: boardGroupCategoryList,
          boardCategory: boardGroupCategoryList.isNotEmpty //
              ? BoardGroupCategory.defaultCategory() //
              : null,
          postList: resData?.data,
          paging: resData?.paging,
        ));
      } else {
        emit(state.copyWith(
          boardCategoryList: boardGroupCategoryList,
          boardCategory: boardGroupCategoryList.isNotEmpty //
              ? boardGroupCategoryList[0] //
              : null,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }
}

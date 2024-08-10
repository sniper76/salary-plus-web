import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/data/response/data_response.dart';
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
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _getPosts = getIt<FindPosts>();
  final _cmsCommonsData = getIt<CMSCommonsService>();

  PostBloc() : super(const PostState()) {
    on<PostOnInit>(onPostOnInit);

    on<PostOnSetSearchKeyword>((event, emit) async {
      emit(state.copyWith(
        searchKeyword: event.searchKeyword,
      ));
    });

    on<PostOnSetSearchType>((event, emit) async {
      emit(state.copyWith(
        searchType: event.searchType,
      ));
    });

    on<PostOnSetPostStatusType>((event, emit) async {
      emit(state.copyWith(
        postStatusType: event.postStatusType,
        paging: state.paging.copyWith(page: 1),
      ));
    });

    on<PostOnSetBoardCategory>((event, emit) async {
      emit(state.copyWith(
        boardCategory: event.boardCategory,
        paging: state.paging.copyWith(page: 1),
      ));
    });

    on<PostOnPageRefresh>((event, emit) {
      emit(state.copyWith(
        refreshPage: !state.refreshPage,
      ));
    });

    on<PostOnFetchPost>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final res = await _fetchPost(
        boardGroup: state.boardGroup,
        boardCategory: state.boardCategory,
        searchType: state.searchType,
        status: state.postStatusType,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        size: event.size ?? apiLoadSize,
        page: event.page ?? 1,
      );
      if (res.isSuccess()) {
        final result = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          postList: result?.data,
          paging: result?.paging,
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });
  }

  Future<Result<DataResponse<List<Post>>, Exception>> _fetchPost({
    required BoardGroupType boardGroup,
    BoardSearchType? searchType,
    BoardGroupCategory? boardCategory,
    String? searchKeyword,
    PostStatusType? status,
    int? page,
    int? size,
  }) {
    return _getPosts(
      boardGroup: boardGroup,
      boardCategory: boardCategory,
      searchType: searchType,
      searchKeyword: searchKeyword,
      status: status,
      page: page ?? 1,
      size: size ?? apiLoadSize,
    );
  }

  FutureOr<void> onPostOnInit(event, emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final boardGroupCategoryList = _cmsCommonsData.getCategoryByBoardGroup(state.boardGroup);

      final res = await _fetchPost(
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
            paging: resData?.paging));
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
      print('fetchPostNewsFromJson error');
      print('fetchPostNewsFromJson $e');
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }
}

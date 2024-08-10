import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/usecase/admin_post/find_posts.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'debate_event.dart';
part 'debate_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _getPosts = getIt<FindPosts>();
  final _cmsCommonsData = getIt<CMSCommonsService>();

  PostBloc() : super(const PostState()) {
    on<PostOnInit>(onPostOnInit);

    on<PostOnSetSearchKeyword>((event, emit) async {
      if (state.searchType == BoardSearchType.stockcode) {
        if (event.searchKeyword == "") {
          emit(state.copyWith(
            sourceCandidateStockList: [],
            searchKeyword: event.searchKeyword,
          ));
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
            sourceCandidateStockList: candidatedStockList,
            searchKeyword: event.searchKeyword,
          ));
        }
      }
    });

    on<PostOnSetSelectedSimpleStock>((event, emit) async {
      emit(state.copyWith(selectedSimpleStock: event.simpleStock));
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

    on<PostOnPageRefresh>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final res = await _getPosts(
        boardGroup: state.boardGroup,
        boardCategory: state.boardCategory,
        searchType: state.searchType,
        searchKeyword: state.searchKeyword,
        size: apiLoadSize,
        page: state.paging.page,
      );
      if (res.isSuccess()) {
        final pagingData = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          paging: pagingData?.paging,
          postList: pagingData?.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<PostOnFetchPost>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(
        isLoading: true,
        searchKeyword: event.searchKeyword,
      ));

      final res = await _getPosts(
        boardGroup: state.boardGroup,
        boardCategory: state.boardCategory,
        searchType: state.searchType,
        status: state.postStatusType,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        page: event.page,
        size: event.size,
      );
      if (res.isSuccess()) {
        final users = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          postList: users?.data,
          paging: users?.paging,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });
  }

  FutureOr<void> onPostOnInit(event, emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final boardGroupCategoryList = _cmsCommonsData.getCategoryByBoardGroup(state.boardGroup);

      final res = await _getPosts(
        boardGroup: state.boardGroup,
        page: 1,
        size: apiLoadSize,
      );

      if (res.isSuccess()) {
        final resData = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          boardCategoryList: boardGroupCategoryList,
          boardCategory: boardGroupCategoryList.isNotEmpty ? boardGroupCategoryList[0] : null,
          postList: resData?.data,
          paging: resData?.paging,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          boardCategoryList: boardGroupCategoryList,
          boardCategory: boardGroupCategoryList.isNotEmpty ? boardGroupCategoryList[0] : null,
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

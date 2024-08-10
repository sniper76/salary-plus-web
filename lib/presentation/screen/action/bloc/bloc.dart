import 'dart:async';
import 'dart:convert';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/file_download_status.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/create_zip_file.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/download_digital_document_csv.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/update_digital_document_reference_date.dart';
import 'package:act_cms/domain/usecase/admin_post/find_posts.dart';
import 'package:act_cms/domain/usecase/admin_post/get_post.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  final _eventBus = getIt<IEventBus>();

  final _getPosts = getIt<FindPosts>();
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _downloadExcel = getIt<DownloadDigitalDocumentCsv>();
  final _getPost = getIt<GetPost>();
  final _createZipFile = getIt<CreateZipFile>();
  final _updateReferenceDay = getIt<UpdateDigitalDocumentReferenceDate>();

  Timer? _timer;

  late StreamSubscription _postChangeEventSubscription;
  late StreamSubscription _postItemChangeEventSubscription;

  ActionBloc() : super(const ActionState()) {
    on<ActionOnInit>(onPostOnInit);
    on<ActionOnGetPosts>(onGetPosts);

    on<ActionOnSetSearchKeyword>((event, emit) async {
      if (state.searchType == BoardSearchType.stockcode) {
        if (event.searchKeyword == "") {
          emit(state.copyWith(sourceCandidateStockList: [], searchKeyword: event.searchKeyword));
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

          emit(state.copyWith(sourceCandidateStockList: candidatedStockList, searchKeyword: event.searchKeyword));
        }
      }
    });

    on<ActionOnSetSearchType>((event, emit) async {
      emit(state.copyWith(
        searchType: event.searchType,
        clearSimpleStock: true,
      ));
    });

    on<ActionOnSetPostStatusType>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      add(ActionEvent.getPosts(status: event.postStatusType));

      emit(state.copyWith(isLoading: false, postStatusType: event.postStatusType));
    });

    on<ActionOnSuccessChagnedReferenceDay>((event, emit) async {
      emit(state.copyWith(
        isSuccessChangeReferenceDay: event.isSuccessChangeReferenceDay,
      ));
    });

    on<ActionOnSetBoardCategory>((event, emit) async {
      if (state.isLoading) return;

      add(ActionEvent.getPosts(boardCategory: event.boardCategory));
    });

    on<ActionOnUpdateReferenceDay>((event, emit) async {
      if (state.isLoading) return;

      // 기준일 업데이트 이후 목록 불러오기에서 에러가 발생하여
      emit(state.copyWith(
        isLoading: true,
        isSuccessChangeReferenceDay: false,
      ));

      final res = await _updateReferenceDay(
        referenceDate: event.referenceDate,
        referenceDateId: event.stockReferenceDateId,
        digitalDocumentId: event.digitalDocumentId,
      );

      if (res.isSuccess()) {
        // final date = res.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          refreshPage: !state.refreshPage,
          isSuccessChangeReferenceDay: true,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<ActionOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      add(ActionEvent.getPosts(searchType: state.searchType, page: event.page));
      emit(state.copyWith(isLoading: false));
    });

    on<ActionOnUpdatedPost>((event, emit) async {
      final res = await _getPost(
        stockCode: event.stockCode,
        boardGroupType: state.boardGroup,
        postId: event.postId,
      );

      if (res.isSuccess()) {
        final postData = res.tryGetSuccess();
        if (postData == null || postData.data == null) return;

        final updatedPosts = [...state.postList];
        final index = updatedPosts.indexWhere((Post updatedPost) => updatedPost.id == postData.data!.id);

        if (index > -1) {
          updatedPosts.removeAt(index);
          updatedPosts.insert(index, postData.data!);

          emit(state.copyWith(postList: updatedPosts));
        }
      }
    });

    on<ActionOnSetSelectedSimpleStock>((event, emit) async {
      emit(state.copyWith(
        searchKeyword: event.simpleStock.code,
        selectedSimpleStock: event.simpleStock,
      ));

      add(ActionEvent.getPosts(searchKeyword: event.simpleStock.code));
    });

    on<ActionOnPageRefresh>((event, emit) async {
      emit(state.copyWith(isSuccessChangeReferenceDay: false));
      add(const ActionEvent.getPosts());
    });

    on<ActionOnExcelDownload>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      final res = await _downloadExcel(
        digitalDocumentId: event.documentId,
      );
      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });

    on<ActionOnZipFileRequest>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoading: true));

      try {
        final post = event.post;
        final res = await _createZipFile(digitalDocumentId: post.digitalDocument!.id, isSecured: event.isSecured);

        if (res.isSuccess()) {
          final postDetailRes = await _getPost(
            stockCode: post.stock!.code,
            boardGroupType: post.boardGroupType!,
            postId: post.id,
          );
          if (postDetailRes.isSuccess()) {
            final postDetail = postDetailRes.tryGetSuccess()?.data;
            emit(state.copyWith(isLoading: false, selectedPostDetail: postDetail));
          } else {
            emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
          }
        } else {
          emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorToastMessage: e.toString()));
      }
    });

    on<ActionOnGetZipFileStatus>((event, emit) async {
      try {
        if (state.selectedPost != null) {
          final res = await _getPost(
              stockCode: state.selectedPost!.stock!.code,
              boardGroupType: state.selectedPost!.boardGroupType!,
              postId: state.selectedPost!.id);
          if (res.isSuccess()) {
            final postDetail = res.tryGetSuccess()?.data;
            emit(state.copyWith(selectedPostDetail: postDetail, retryCount: state.retryCount + 1));
            if (postDetail?.digitalDocument?.digitalDocumentDownload?.zipFileStatus ==
                FileDownloadStatusType.complete) {
              add(const ActionEvent.removeZipFileStatus());
            }
          } else {
            emit(state.copyWith(selectedPostDetail: null, errorToastMessage: res.tryGetError().toString()));
          }
        }
      } catch (e) {
        emit(state.copyWith(errorToastMessage: e.toString()));
      }
    });

    on<ActionOnRemoveZipFileStatus>((event, emit) async {
      emit(state.copyWith(selectedPost: null, selectedPostDetail: null, retryCount: 0));
      _cancelTimer();
    });

    on<ActionOnSetSelectedPost>((event, emit) async {
      if (state.isLoading) {
        return;
      }
      emit(state.copyWith(isLoading: true, selectedPost: event.post));
      final res = await _getPost(
          stockCode: state.selectedPost!.stock!.code,
          boardGroupType: state.selectedPost!.boardGroupType!,
          postId: state.selectedPost!.id);
      if (res.isSuccess()) {
        final postDetail = res.tryGetSuccess()?.data;
        emit(state.copyWith(isLoading: false, selectedPostDetail: postDetail));
        if (postDetail?.digitalDocument?.digitalDocumentDownload?.zipFileStatus == FileDownloadStatusType.complete) {
          add(const ActionEvent.removeZipFileStatus());
        }
      } else {
        emit(state.copyWith(
            isLoading: false, selectedPostDetail: null, errorToastMessage: res.tryGetError().toString()));
      }
    });
  }

  void onGetPosts(ActionOnGetPosts event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _getPosts(
      boardGroup: event.boardGroup ?? state.boardGroup,
      boardCategory: event.boardCategory ?? state.boardCategory,
      searchType: event.searchType ?? state.searchType,
      searchKeyword: event.searchKeyword ?? state.searchKeyword,
      page: event.page ?? 1,
      size: apiLoadSize,
      sort: null,
      status: event.status ?? state.postStatusType,
    );
    if (res.isSuccess()) {
      final successData = res.tryGetSuccess();

      emit(state.copyWith(
        isLoading: false,
        postList: successData?.data,
        boardCategory: event.boardCategory ?? state.boardCategory,
        searchType: event.searchType ?? state.searchType,
        searchKeyword: event.searchKeyword ?? state.searchKeyword,
        paging: successData?.paging,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: res.tryGetError().toString(),
      ));
    }
  }

  FutureOr<void> onPostOnInit(event, emit) async {
    _postChangeEventSubscription = _eventBus.on<PostChangedEvent>().listen((PostChangedEvent _) {
      add(const ActionEvent.pageRefresh());
    });

    _postItemChangeEventSubscription = _eventBus.on<PostItemChangedEvent>().listen((PostItemChangedEvent event) {
      add(ActionEvent.updatePost(event.id, event.stockCode));
    });

    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final boardGroupCategoryList = _cmsCommonsData.getCategoryByBoardGroup(state.boardGroup);

      var defaultCategory = BoardGroupCategory.defaultCategory();
      if (!boardGroupCategoryList.contains(defaultCategory)) {
        boardGroupCategoryList.insert(0, defaultCategory);
      }

      add(const ActionEvent.getPosts(boardGroup: BoardGroupType.action, page: 1, size: apiLoadSize));

      emit(
        state.copyWith(
          isLoading: false,
          boardCategoryList: boardGroupCategoryList,
          boardCategory: boardGroupCategoryList.isNotEmpty ? boardGroupCategoryList[0] : null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: e.toString(),
      ));
    }
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _postChangeEventSubscription.cancel();
    _postItemChangeEventSubscription.cancel();
    return super.close();
  }
}

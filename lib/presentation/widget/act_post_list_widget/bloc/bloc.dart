import 'dart:async';

import 'package:act_web/config/app_event.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/data/response/paging.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/usecase/post/get_board_group_categories.dart';
import 'package:act_web/domain/usecase/post/get_post_list.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:act_web/presentation/widget/act_pagination.dart';
import 'package:event_bus_plus/res/res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'bloc.freezed.dart';

part 'event.dart';
part 'state.dart';

class ActPostListWidgetBloc extends Bloc<ActPostListWidgetEvent, ActPostListWidgetState> {
  final IEventBus _eventBus = GetIt.I<IEventBus>();

  final GetPostList _getPostList = GetIt.I<GetPostList>();
  final GetBoardGroupCategories _getBoardGroupCategories = GetIt.I<GetBoardGroupCategories>();

  final String stockCode;
  final BoardGroupType boardGroupType;

  late final String _postPagingSizeStorageKey = 'post_paging_size_key';
  late StreamSubscription? _postCountChangeEventSubscription;
  late StreamSubscription? _postChangeEventSubscription;

  ActPostListWidgetBloc({
    required this.stockCode,
    required this.boardGroupType,
  }) : super(ActPostListWidgetState.initial()) {
    on<_OnInit>((event, emit) async {
      _postCountChangeEventSubscription = _eventBus.on<PostCountChangeEvent>().listen((e) {
        add(const ActPostListWidgetEvent.refresh());
      });

      _postChangeEventSubscription = _eventBus.on<PostChangedEvent>().listen((e) {
        emit(state.copyWithNull(
          postList: state.postList.map((post) {
            if (post.id == e.post.id) {
              return e.post;
            }
            return post;
          }).toList(),
        ));
      });

      final Result<List<BoardGroupCategory>, Exception> categoryRes = await _getBoardGroupCategories(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
      );

      categoryRes.when((List<BoardGroupCategory> successData) {
        final defaultBoardGroupCategory = BoardGroupCategory.defaultCategory();
        if (successData.length > 1) {
          successData.insert(0, defaultBoardGroupCategory);
        }
        emit(state.copyWithNull(
          boardGroupCategoryList: successData,
          selectedBoardGroupCategory: successData.firstOrNull,
        ));
      }, (error) {
        emit(state.copyWithNull(
          errorToastMessage: '게시판 카테고리를 불러오는 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
        ));
        return;
      });

      try {
        final int? savedPostPagingSize = await _loadPostPagingSize();
        if (savedPostPagingSize != null) {
          emit(state.copyWithNull(
            postPaging: state.postPaging.copyWith(size: savedPostPagingSize),
          ));
        }
      } catch (_) {
        await _deletePostPagingSize();
      }

      add(ActPostListWidgetEvent.fetchPostList(
        page: state.paging.page,
        size: state.paging.size,
      ));
    });

    on<_OnRefresh>((event, emit) async {
      add(ActPostListWidgetEvent.fetchPostList(
        page: state.paging.page,
        size: state.paging.size,
      ));
    });

    on<_OnChangePage>((event, emit) async {
      add(ActPostListWidgetEvent.fetchPostList(
        page: event.page,
        size: state.paging.size,
      ));
    });

    on<_OnChangePageSize>((event, emit) async {
      await _deletePostPagingSize();
      await _savePostPagingSize(event.size);

      emit(state.copyWithNull(
        postPaging: state.postPaging.copyWith(size: event.size),
      ));

      add(ActPostListWidgetEvent.fetchPostList(
        page: state.paging.page,
        size: event.size,
      ));
    });

    on<_OnChangeBoardGroupCategory>((event, emit) async {
      if (state.selectedBoardGroupCategory == event.boardGroupCategory) return;
      emit(state.copyWithNull(selectedBoardGroupCategory: event.boardGroupCategory));
      add(ActPostListWidgetEvent.fetchPostList(
        page: state.paging.page,
        size: state.paging.size,
      ));
    });

    on<_OnChangeBoardSortType>((event, emit) async {
      if (state.selectedBoardSortType == event.boardSortType) return;
      emit(state.copyWithNull(selectedBoardSortType: event.boardSortType));
      add(ActPostListWidgetEvent.fetchPostList(
        page: state.paging.page,
        size: state.paging.size,
      ));
    });

    on<_OnFetchPostList>((event, emit) async {
      emit(state.copyWithNull(isLoading: true));

      final Result<DataResponse<List<Post>>, Exception> postListRes = await _getPostList(
        boardGroupType: boardGroupType,
        boardGroupCategory: state.selectedBoardGroupCategory,
        stockCode: stockCode,
        page: event.page,
        size: event.size ?? state.paging.size,
        sort: state.selectedBoardSortType,
      );

      postListRes.when((DataResponse<List<Post>> successData) {
        emit(state.copyWithNull(
          isLoading: false,
          postList: successData.data ?? [],
          postPaging: successData.paging ?? Paging.initial(),
        ));
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '게시글을 불러오는 중 오류가 발생했습니다.',
        ));
      });
    });
  }

  Future<int?> _loadPostPagingSize() async {
    try {
      String? postPagingSizeString = await const FlutterSecureStorage().read(
        key: _postPagingSizeStorageKey,
      );

      if (postPagingSizeString == null) return null;

      return int.tryParse(postPagingSizeString);
    } catch (e) {
      return null;
    }
  }

  Future<void> _savePostPagingSize(int size) async {
    await const FlutterSecureStorage().write(
      key: _postPagingSizeStorageKey,
      value: size.toString(),
    );
  }

  Future<void> _deletePostPagingSize() async {
    await const FlutterSecureStorage().delete(
      key: _postPagingSizeStorageKey,
    );
  }

  @override
  Future<void> close() {
    _postCountChangeEventSubscription?.cancel();
    _postChangeEventSubscription?.cancel();
    return super.close();
  }
}

import 'dart:async';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/digital_document.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/write_count.dart';
import 'package:act_cms/domain/usecase/admin_comment/create_comment.dart';
import 'package:act_cms/domain/usecase/admin_comment/find_comments.dart';
import 'package:act_cms/domain/usecase/admin_comment/edit_comment.dart';
import 'package:act_cms/domain/usecase/admin_comment/update_comment_status.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'act_comment_list_event.dart';
part 'act_comment_list_state.dart';

class ActCommentListBloc extends Bloc<ActCommentListEvent, ActCommentListState> {
  final _eventBus = getIt<IEventBus>();
  final _authService = getIt<UserAuthService>();
  final _findComments = getIt<FindComments>();
  final _updateCommentStatus = getIt<UpdateCommentStatus>();
  final _editComment = getIt<EditComment>();
  final _createComment = getIt<CreateComment>();

  late StreamSubscription _postItemChangeEventSubscription;

  final BoardGroupType boardGroupType;
  final Post post;
  final String stockCode;
  final BoardGroupCategory? boardGroupCategory;

  ActCommentListBloc({
    required this.boardGroupType,
    required this.stockCode,
    required this.post,
    required this.boardGroupCategory,
  }) : super(ActCommentListState(post: post)) {
    on<ActCommentListOnInit>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final userMe = _authService.userMe;

      final Result<DataResponse<List<Comment>>, Exception> commentRes = await _findComments(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: post.id,
        sort: state.sortType,
        size: 20,
      );

      _postItemChangeEventSubscription =
          _eventBus.on<PostCommentChangedEvent>().listen((PostCommentChangedEvent event) {
        add(ActCommentListEvent.updateComment(
          commentId: event.id,
          isActive: event.isActive,
          content: event.content,
        ));
      });

      emit(state.copyWith(
          isLoading: false,
          userMe: userMe,
          post: post,
          comments: commentRes.tryGetSuccess()?.data ?? [],
          paging: commentRes.tryGetSuccess()?.paging,
          isOwner: post.userId == userMe?.id,
          digitalDocument: post.digitalDocument?.copyWith(title: post.title),
          isNotification: post.isNotification,
          isActive: post.isActive));
    });

    on<ActCommentListOnCommentUpdate>((event, emit) async {
      final updatedComments = [...state.comments];

      final index = updatedComments.indexWhere((e) => e.id == event.commentId);

      if (index > -1) {
        final updatedComment = updatedComments[index].copyWith(deleted: !event.isActive, content: event.content);
        updatedComments.removeAt(index);
        updatedComments.insert(index, updatedComment);
        emit(state.copyWith(comments: updatedComments));
      }
    });

    on<ActCommentListOnRefresh>((event, emit) async {
      if (state.isLoading) return;

      add(const ActCommentListEvent.getCommentsList());
    });

    on<ActCommentListOnCommentDelete>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));

        final res = await _updateCommentStatus(
            stockCode: stockCode,
            boardGroup: event.boardGroup,
            status: "DELETED_BY_ADMIN",
            commentId: event.comment.id,
            postId: event.postId);

        if (res.isSuccess()) {
          final comment = res.tryGetSuccess();
          _broadcastCommentChanged(comment!.id, false, comment.content);
        }

        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );

    on<ActCommentListOnCommentActive>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));

        final res = await _updateCommentStatus(
            stockCode: stockCode,
            boardGroup: event.boardGroup,
            status: "ACTIVE",
            commentId: event.comment.id,
            postId: event.postId);

        if (res.isSuccess()) {
          final comment = res.tryGetSuccess();
          _broadcastCommentChanged(comment!.id, true, comment.content);
        }

        emit(state.copyWith(isLoading: false));
      },
    );

    on<ActCommentListOnCommentEdit>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));

      final res = await _editComment(
        content: event.editedContent,
        stockCode: stockCode,
        boardGroup: event.boardGroup,
        postId: event.postId,
        commentId: event.commentId,
      );

      if (res.isSuccess()) {
        final comment = res.tryGetSuccess();
        _broadcastCommentChanged(comment!.id, true, comment.content);
      }

      emit(state.copyWith(
        isLoading: false,
        isEditingComment: false,
      ));
    });

    on<ActCommentListOnLoadMoreComment>((event, emit) async {
      if (state.isLoading || state.isCommentMoreLoading || state.paging.endOfPage == true) return;

      emit(state.copyWith(isCommentMoreLoading: true));

      final res = await _findComments(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        sort: state.sortType,
        postId: post.id,
        size: apiLoadSize,
        page: (state.paging.page) + 1,
      );

      final pagingData = res.tryGetSuccess();
      final comments = pagingData?.data ?? [];

      emit(state.copyWith(
        isCommentMoreLoading: false,
        paging: pagingData?.paging,
        comments: [
          ...state.comments.where((element) => !element.isTemporaryAdded).toList(),
          ...comments,
          if (!isLastPage()) ...state.comments.where((element) => element.isTemporaryAdded).toList()
        ],
      ));
    });

    on<ActCommentListOnSortComment>((event, emit) async {
      if (state.isLoading) return;
      add(ActCommentListEvent.getCommentsList(boardSortType: event.sortType));
    });

    on<ActCommentListOnCommentSave>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));

        final res = await _createComment(
          stockCode: stockCode,
          boardGroup: event.boardGroup,
          postId: event.postId,
          content: event.text,
          isAnonymous: event.isAnonymous,
        );

        if (res.isSuccess()) {
          emit(state.copyWith(
            paging: state.paging.copyWith(total: state.paging.total + 1),
            comments: [...state.comments, res.tryGetSuccess()!.copyWith(isTemporaryAdded: true)],
          ));
        }

        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );

    on<ActCommentListOnActivateCommentUpdatingMode>(
      (event, emit) async {
        if (state.isLoading) return;
        emit(state.copyWith(
          isEditingComment: event.isUpdatingComment,
          curEditingComment: event.curUpdatingComment,
        ));
      },
    );

    on<ActCommentListOnGetCommentsList>(
      (event, emit) async {
        final commentRes = await _findComments(
          stockCode: stockCode,
          boardGroupType: boardGroupType,
          postId: post.id,
          sort: event.boardSortType ?? state.sortType,
          size: apiLoadSize,
          page: event.page ?? 1,
        );

        emit(state.copyWith(
          isLoading: false,
          comments: commentRes.tryGetSuccess()?.data ?? [],
          paging: commentRes.tryGetSuccess()?.paging,
        ));
      },
    );
  }

  bool isLastPage() => state.paging.page == state.paging.totalPage;

  _broadcastCommentChanged(int id, bool isActive, String content) {
    _eventBus.fire(PostCommentChangedEvent(id: id, isActive: isActive, content: content));
  }

  @override
  Future<void> close() {
    _postItemChangeEventSubscription.cancel();
    return super.close();
  }
}

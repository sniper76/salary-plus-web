import 'dart:async';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/write_count.dart';
import 'package:act_cms/domain/usecase/admin_comment/create_comment_replies.dart';
import 'package:act_cms/domain/usecase/admin_comment/edit_comment.dart';
import 'package:act_cms/domain/usecase/admin_comment/update_comment_status.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:meta/meta.dart';

import '../../../../../domain/usecase/admin_comment/find_replies.dart';

part 'reply_list_event.dart';
part 'reply_list_state.dart';

class ReplyListBloc extends Bloc<ReplyListEvent, ReplyListState> {
  final _eventBus = getIt<IEventBus>();
  final _authService = getIt<UserAuthService>();
  final _findReplies = getIt<FindReplies>();
  final _updateCommentStatus = getIt<UpdateCommentStatus>();
  final _editComment = getIt<EditComment>();
  final _createReplies = getIt<CreateCommentReplies>();
  late StreamSubscription _postItemChangeEventSubscription;

  Paging? _paging;

  final String stockCode;
  final String boardGroup;
  final int postId;
  final Comment comment;

  ReplyListBloc({
    required this.stockCode,
    required this.boardGroup,
    required this.postId,
    required this.comment,
  }) : super(const ReplyListState()) {
    on<ReplyListOnInit>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      _postItemChangeEventSubscription =
          _eventBus.on<PostCommentChangedEvent>().listen((PostCommentChangedEvent event) {
        add(ReplyListEvent.updateComment(commentId: event.id, isActive: event.isActive, content: event.content));
      });

      final boardGroupType = BoardGroupType.values.byName(boardGroup.toLowerCase());

      final userMe = _authService.userMe;
      final res = await _findReplies(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: comment.id,
        sort: state.sortType,
      );

      _paging = res.tryGetSuccess()?.paging;

      emit(state.copyWith(
        isLoading: false,
        userMe: userMe,
        comment: comment,
        replies: res.tryGetSuccess()?.data,
      ));
    });

    on<ReplyListOnLoadMore>((event, emit) async {
      if (state.isLoadMore || _paging?.endOfPage == true) return;

      emit(state.copyWith(isLoadMore: true));

      final boardGroupType = BoardGroupType.values.byName(boardGroup.toLowerCase());

      final res = await _findReplies(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: comment.id,
        sort: state.sortType,
        page: (_paging?.page ?? 0) + 1,
      );

      final replies = res.tryGetSuccess()?.data ?? [];
      if (res.isSuccess()) {
        _paging = res.tryGetSuccess()?.paging;
      }

      emit(state.copyWith(
        isLoadMore: false,
        replies: [
          ...state.replies.where((element) => !element.isTemporaryAdded).toList(),
          ...replies,
          if (!isLastPage()) ...state.replies.where((element) => element.isTemporaryAdded).toList()
        ],
      ));
    });

    on<ReplyListOnCommentDelete>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));

        final res = await _updateCommentStatus(
            stockCode: event.stockCode,
            boardGroup: event.boardGroup,
            status: "DELETED_BY_ADMIN",
            commentId: event.comment.id,
            postId: event.postId);

        if (res.isSuccess()) {
          final updateComment = res.tryGetSuccess()?.content ?? '';
          _broadcastCommentChanged(res.tryGetSuccess()!.id, false, updateComment);
        }

        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );

    on<ReplyListOnCommentActive>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));

        final res = await _updateCommentStatus(
            stockCode: event.stockCode,
            boardGroup: event.boardGroup,
            status: "ACTIVE",
            commentId: event.comment.id,
            postId: event.postId);

        if (res.isSuccess()) {
          final updateComment = state.comment?.content ?? '';

          _broadcastCommentChanged(res.tryGetSuccess()!.id, true, updateComment);
        }

        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );

    on<ReplyListOnCommentEdit>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));

        final res = await _editComment(
            stockCode: event.stockCode,
            boardGroup: event.boardGroup,
            content: event.editedContent,
            commentId: event.commentId,
            postId: event.postId);

        if (res.isSuccess()) {
          final comment = res.tryGetSuccess();
          _broadcastCommentChanged(comment!.id, true, comment.content);
        }

        emit(state.copyWith(
          isLoading: false,
          isEditingComment: false,
        ));
      },
    );

    on<ReplyListOnActivateCommentUpdatingMode>(
      (event, emit) async {
        if (state.isLoading) return;
        emit(state.copyWith(
          isEditingComment: event.isUpdatingComment,
          curEditingComment: event.curUpdatingComment,
        ));
      },
    );

    on<ReplyListOnCommentUpdate>((event, emit) async {
      if (state.comment!.id == event.commentId) {
        final updatedComment = state.comment!.copyWith(
          deleted: !event.isActive,
          content: event.content,
        );
        emit(state.copyWith(comment: updatedComment));
        return;
      }

      final updatedComments = [...state.replies];

      final index = updatedComments.indexWhere((e) => e.id == event.commentId);

      if (index > -1) {
        final updatedComment = updatedComments[index].copyWith(
          deleted: !event.isActive, content: event.content,
          // isActive: event.isActive, // Assuming `event.isActive` holds the new value for isActive.
        );
        updatedComments.removeAt(index);
        updatedComments.insert(index, updatedComment);
        emit(state.copyWith(replies: updatedComments));
      }
    });

    on<ReplyListOnSaveReply>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));

        final res = await _createReplies(
          stockCode: event.stockCode,
          boardGroup: event.boardGroup,
          commentId: event.commentId,
          postId: event.postId,
          content: event.text,
          isAnonymous: event.isAnonymous,
        );

        if (res.isSuccess()) {
          // _broadcastCommentChanged(res.tryGetSuccess()!.id, true);
          emit(state.copyWith(
            replies: [...state.replies, res.tryGetSuccess()!.copyWith(isTemporaryAdded: true)],
          ));
        }

        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );
  }

  bool isLastPage() => _paging?.page == _paging?.totalPage;

  _broadcastCommentChanged(int id, bool isActive, String content) {
    _eventBus.fire(PostCommentChangedEvent(id: id, isActive: isActive, content: content));
  }

  @override
  Future<void> close() {
    _postItemChangeEventSubscription.cancel();
    return super.close();
  }
}

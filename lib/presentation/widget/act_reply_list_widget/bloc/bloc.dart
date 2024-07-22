import 'dart:math';

import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/data/response/paging.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/usecase/comment/create_reply.dart';
import 'package:act_web/domain/usecase/comment/delete_comment.dart';
import 'package:act_web/domain/usecase/comment/get_reply_list.dart';
import 'package:act_web/domain/usecase/comment/like_comment.dart';
import 'package:act_web/domain/usecase/comment/report_comment.dart';
import 'package:act_web/domain/usecase/comment/unlike_comment.dart';
import 'package:act_web/domain/usecase/comment/update_comment.dart';
import 'package:act_web/domain/usecase/user/block_user.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:act_web/presentation/widget/act_pagination.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'bloc.freezed.dart';

part 'event.dart';
part 'state.dart';

class ActReplyListWidgetBloc extends Bloc<ActReplyListWidgetEvent, ActReplyListWidgetState> {
  final GetReplyList _getReplyList = GetIt.I<GetReplyList>();
  final CreateReply _createReply = GetIt.I<CreateReply>();
  final UpdateComment _updateReply = GetIt.I<UpdateComment>();
  final DeleteComment _deleteReply = GetIt.I<DeleteComment>();
  final LikeComment _likeReply = GetIt.I<LikeComment>();
  final UnlikeComment _unlikeReply = GetIt.I<UnlikeComment>();
  final BlockUser _blockUser = GetIt.I<BlockUser>();
  final ReportComment _reportReply = GetIt.I<ReportComment>();

  final String stockCode;
  final BoardGroupType boardGroupType;
  final int totalReplyCount;
  final int postId;
  final int commentId;
  final List<Comment> firstPageReplyList;

  ActReplyListWidgetBloc({
    required this.stockCode,
    required this.boardGroupType,
    required this.firstPageReplyList,
    required this.totalReplyCount,
    required this.postId,
    required this.commentId,
  }) : super(ActReplyListWidgetState.initial()) {
    List<Comment> replyList = [...firstPageReplyList];

    on<_OnInit>((event, emit) async {
      emit(state.copyWithNull(
        replyList: replyList.length > 3 ? replyList.sublist(0, 3) : replyList,
        hasMoreReplies: replyList.length > 3,
        remainingReplyCount: min(totalReplyCount, 20) - 3,
      ));
    });

    on<_OnFetchReplyList>((event, emit) async {
      emit(state.copyWithNull(isLoading: true));

      if (state.replyList.length < replyList.length) {
        emit(state.copyWithNull(
          isLoading: false,
          replyList: replyList,
          hasMoreReplies: totalReplyCount > 20,
          remainingReplyCount: min(totalReplyCount - replyList.length, 20),
        ));
        return;
      }

      final Result<DataResponse<List<Comment>>, Exception> replyListRes = await _getReplyList(
        commentId: commentId,
        postId: postId,
        boardGroupType: boardGroupType,
        stockCode: stockCode,
        page: event.page,
        size: state.paging.size,
        sort: BoardSortType.createdAtAsc,
      );

      replyListRes.when((DataResponse<List<Comment>> successData) {
        emit(state.copyWithNull(
          isLoading: false,
          replyList: [...state.replyList, ...(successData.data ?? [])],
          replyPaging: successData.paging ?? Paging.initial(),
          hasMoreReplies: successData.paging?.endOfPage == false,
          remainingReplyCount: min(totalReplyCount - [...state.replyList, ...(successData.data ?? [])].length, 20),
        ));
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '답글을 불러오는 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnToggleIsWritingReply>((event, emit) async {
      emit(state.copyWithNull(isWritingReply: !state.isWritingReply));
    });

    on<_OnToggleAnonymousWriting>((event, emit) async {
      emit(state.copyWithNull(isWritingAnonymousReply: !state.isWritingAnonymousReply));
    });

    on<_OnLikeReply>((event, emit) async {
      if (state.isLoading) return;

      final Result res = await _likeReply(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: event.replyId,
      );

      res.when((success) {
        final Comment? likedReply = state.replyList.firstWhereOrNull(
          (Comment element) => element.id == event.replyId,
        );
        if (likedReply == null) return;

        final int index = state.replyList.indexOf(likedReply);
        final List<Comment> replaceReplyList = [...state.replyList];
        replaceReplyList[index] = likedReply.copyWith(
          likeCount: likedReply.likeCount + 1,
          liked: true,
        );

        emit(state.copyWithNull(
          isLoading: false,
          replyList: replaceReplyList,
        ));
      }, (error) {
        emit(state.copyWithNull(
          errorToastMessage: '답글 좋아요 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnUnLikeReply>((event, emit) async {
      if (state.isLoading) return;

      final Result res = await _unlikeReply(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: event.replyId,
      );

      res.when((success) {
        final Comment? unLikedReply = state.replyList.firstWhereOrNull(
          (Comment element) => element.id == event.replyId,
        );
        if (unLikedReply == null) return;

        final int index = state.replyList.indexOf(unLikedReply);
        final List<Comment> replaceReplyList = [...state.replyList];
        replaceReplyList[index] = unLikedReply.copyWith(
          likeCount: unLikedReply.likeCount - 1,
          liked: false,
        );

        emit(state.copyWithNull(
          isLoading: false,
          replyList: replaceReplyList,
        ));
      }, (error) {
        emit(state.copyWithNull(
          errorToastMessage: '답글 좋아요 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnToggleUpdatingWriting>((event, emit) async {
      emit(state.copyWithNull(updatingReplyId: event.replyId));
    });

    on<_OnUpdateReply>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWithNull(
        isLoading: true,
      ));

      final int replyId = event.replyId;
      final Result<Comment, Exception> updateReplyRes = await _updateReply(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: replyId,
        content: event.content,
        isAnonymous: event.isAnonymous,
      );

      updateReplyRes.when((Comment successData) {
        final List<Comment> updateReplies = [...state.replyList];
        final int index = updateReplies.indexWhere((e) => e.id == replyId);
        if (index >= 0) {
          updateReplies.removeAt(index);
          updateReplies.insert(index, successData);
        }

        emit(state.copyWithNull(
          isLoading: false,
          replyList: updateReplies,
        ));
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '답글을 수정하는 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnDeleteReply>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWithNull(
        isLoading: true,
      ));

      final Result deleteReplyRes = await _deleteReply(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: event.replyId,
      );

      deleteReplyRes.when((success) {
        final List<Comment> updatedReplies = [...state.replyList];
        final index = updatedReplies.indexWhere((e) => e.id == event.replyId);
        if (index > -1) {
          updatedReplies.removeAt(index);
          updatedReplies.insert(index, state.replyList[index].copyWith(deleted: true, content: '삭제된 답글입니다.'));
        }

        emit(state.copyWithNull(
          isLoading: false,
          replyList: updatedReplies,
        ));
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '답글을 삭제하는 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnBlockReply>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWithNull(
        isLoading: true,
      ));

      final Result blockUserRes = await _blockUser(
        targetUserId: event.userId,
      );

      blockUserRes.when((success) {
        List<Comment> updatedReplies = [...state.replyList];
        updatedReplies = updatedReplies.where((e) => e.userId != event.userId).toList();

        emit(state.copyWithNull(
          isLoading: false,
          replyList: updatedReplies,
        ));
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '사용자를 차단하는 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnReportReply>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWithNull(
        isLoading: true,
      ));

      final Result reportReplyRes = await _reportReply(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        postId: postId,
        commentId: event.replyId,
        reason: event.reason,
      );

      reportReplyRes.when((success) {
        final List<Comment> updatedReplies = [...state.replyList];
        final index = updatedReplies.indexWhere((e) => e.id == event.replyId);
        if (index > -1) {
          updatedReplies.removeAt(index);
          updatedReplies.insert(index, state.replyList[index].copyWith(deleted: true, content: '신고된 답글입니다.'));
        }

        emit(state.copyWithNull(
          isLoading: false,
          replyList: updatedReplies,
        ));
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '답글을 신고하는 중 오류가 발생했습니다.',
        ));
      });
    });

    on<_OnRefresh>((event, emit) async {
      add(ActReplyListWidgetEvent.fetchReplyList(
        page: state.paging.page,
        size: state.paging.size,
      ));
    });

    on<_OnLoadMore>((event, emit) async {
      add(ActReplyListWidgetEvent.fetchReplyList(
        page: state.paging.page + 1,
        size: state.paging.size,
      ));
    });

    on<_OnCreateReply>((event, emit) async {
      emit(state.copyWithNull(isLoading: true));

      final Result<Comment, Exception> createReplyRes = await _createReply(
        commentId: commentId,
        postId: postId,
        boardGroupType: boardGroupType,
        stockCode: stockCode,
        content: event.content,
        isAnonymous: state.isWritingAnonymousReply,
      );

      createReplyRes.when((Comment successData) {
        if (state.paging.endOfPage && state.paging.page != 1) {
          emit(state.copyWithNull(
            isLoading: false,
            replyList: [...state.replyList, successData],
          ));
        } else {
          if (state.paging.page == 1) {
            if (replyList.length < 20) replyList.add(successData);
            emit(state.copyWithNull(
              isLoading: false,
              remainingReplyCount: min(state.remainingReplyCount + 1, 17),
            ));
          } else {
            emit(state.copyWithNull(
              isLoading: false,
              remainingReplyCount: min(state.remainingReplyCount + 1, 20),
            ));
          }
        }
      }, (error) {
        emit(state.copyWithNull(
          isLoading: false,
          errorToastMessage: '답글을 작성하는 중 오류가 발생했습니다.',
        ));
      });
    });
  }
}

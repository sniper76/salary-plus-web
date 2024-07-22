import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/data/response/paging.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/enum/poll_view_type.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/model/post/write_count.dart';
import 'package:act_web/domain/usecase/comment/create_comment.dart';
import 'package:act_web/domain/usecase/comment/delete_comment.dart';
import 'package:act_web/domain/usecase/comment/get_comment_list.dart';
import 'package:act_web/domain/usecase/comment/like_comment.dart';
import 'package:act_web/domain/usecase/comment/report_comment.dart';
import 'package:act_web/domain/usecase/comment/unlike_comment.dart';
import 'package:act_web/domain/usecase/comment/update_comment.dart';
import 'package:act_web/domain/usecase/post/answer_on_post_poll.dart';
import 'package:act_web/domain/usecase/post/delete_post.dart';
import 'package:act_web/domain/usecase/post/get_post_detail.dart';
import 'package:act_web/domain/usecase/post/like_post.dart';
import 'package:act_web/domain/usecase/post/report_post.dart';
import 'package:act_web/domain/usecase/post/unlike_post.dart';
import 'package:act_web/domain/usecase/user/block_user.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final BlockUser _blockUser = GetIt.I<BlockUser>();

  // post
  final GetPostDetail _getPostDetail = GetIt.I<GetPostDetail>();
  final LikePost _likePost = GetIt.I<LikePost>();
  final UnlikePost _unlikePost = GetIt.I<UnlikePost>();
  final ReportPost _reportPost = GetIt.I<ReportPost>();
  final DeletePost _deletePost = GetIt.I<DeletePost>();
  final AnswerOnPostPoll _answerOnPostPoll = GetIt.I<AnswerOnPostPoll>();
  // comment
  final GetCommentList _getCommentList = GetIt.I<GetCommentList>();
  final CreateComment _createComment = GetIt.I<CreateComment>();
  final UpdateComment _updateComment = GetIt.I<UpdateComment>();
  final DeleteComment _deleteComment = GetIt.I<DeleteComment>();
  final LikeComment _likeComment = GetIt.I<LikeComment>();
  final UnlikeComment _unlikeComment = GetIt.I<UnlikeComment>();
  final ReportComment _reportComment = GetIt.I<ReportComment>();

  final String stockCode;
  final String boardGroupName;
  final int postId;

  // for toggling post like
  bool _togglingPostLike = false;
// for toggling comment like
  bool _togglingCommentLike = false;

  PostDetailBloc({
    required this.stockCode,
    required this.boardGroupName,
    required this.postId,
  }) : super(PostDetailState.initial()) {
    on<_OnInit>((event, emit) async {
      add(const PostDetailEvent.fetchPost());
      add(PostDetailEvent.fetchCommentList(page: state.commentPaging.page, isLoadMore: false));
    });

    on<_OnDeletePost>((event, emit) async {
      Result<void, Exception> deleteRes = await _deletePost(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        stockCode: stockCode,
      );

      deleteRes.when(
        (_) {
          emit(state.copyWithNull(
            onPopScreen: true,
            notiToastMessage: '게시글이 삭제되었습니다.',
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnLikePost>((event, emit) async {
      if (_togglingPostLike) return;

      _togglingPostLike = true;

      Result<Post, Exception> likeRes = await _likePost(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        stockCode: stockCode,
      );

      likeRes.when(
        (Post post) {
          emit(state.copyWithNull(
            post: post,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );

      _togglingPostLike = false;
    });

    on<_OnUnLikePost>((event, emit) async {
      if (_togglingPostLike) return;

      _togglingPostLike = true;

      Result<Post, Exception> unlikeRes = await _unlikePost(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        stockCode: stockCode,
      );

      unlikeRes.when(
        (Post post) {
          emit(state.copyWithNull(
            post: post,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );

      _togglingPostLike = false;
    });

    on<_OnReportPost>((event, emit) async {
      Result<void, Exception> reportRes = await _reportPost(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        reason: event.reason,
        stockCode: stockCode,
      );

      reportRes.when(
        (_) {
          emit(state.copyWithNull(
            onPopScreen: true,
            notiToastMessage: '신고가 접수되었습니다.',
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnBlockPost>((event, emit) async {
      Result<void, Exception> blockRes = await _blockUser(
        targetUserId: event.userId,
      );

      blockRes.when(
        (_) {
          emit(state.copyWithNull(
            onPopScreen: true,
            notiToastMessage: '사용자를 차단했습니다.',
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnVotePoll>((event, emit) async {
      if (state.isLoading || state.post == null || state.post?.polls == null) return;

      final poll = state.post!.polls?.singleWhere((poll) => poll.id == event.pollId);
      if (poll?.targetStartDate?.toUtc().isBefore(DateTime.now().toUtc()) == false) {
        emit(state.copyWithNull(
          errorToastMessage: '진행하기 전 투표입니다',
        ));
        return;
      }

      if (poll?.targetEndDate?.toUtc().isAfter(DateTime.now().toUtc()) == false) {
        emit(state.copyWithNull(
          errorToastMessage: '종료된 투표입니다',
        ));
        return;
      }

      emit(state.copyWithNull(
        isLoading: true,
      ));

      final res = await _answerOnPostPoll(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        pollId: event.pollId,
        pollAnswerIds: event.answerIdList,
        isUpdate: poll?.answers?.isNotEmpty == true,
      );

      res.when(
        (_) {
          add(const PostDetailEvent.fetchPost());
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnReVotePoll>((event, emit) {
      List<Poll>? newPolls = state.post?.polls;
      if (newPolls?.isNotEmpty == true && state.post != null) {
        emit(state.copyWithNull(
            post: state.post!.copyWith(
          polls: newPolls!.map((Poll poll) {
            if (poll.id == event.pollId) {
              return poll.copyWith(viewType: PollViewType.vote);
            } else {
              return poll;
            }
          }).toList(),
        )));
      }
    });

    on<_OnChangeCommentSortType>((event, emit) {
      emit(state.copyWithNull(
        sortType: event.sortType,
      ));

      add(const PostDetailEvent.fetchCommentList(page: 1, isLoadMore: false));
    });

    on<_OnToggleAnonymousCommentWriting>((event, emit) {
      emit(state.copyWithNull(
        isWritingAnonymousComment: !state.isWritingAnonymousComment,
      ));
    });

    on<_OnToggleUpdatingCommentWriting>((event, emit) {
      emit(state.copyWithNull(
        updatingCommentId: event.commentId,
      ));
    });

    on<_OnCreateComment>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<Comment, Exception> createCommentRes = await _createComment(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        content: event.content,
        isAnonymous: state.isWritingAnonymousComment,
      );

      createCommentRes.when(
        (Comment comment) {
          if (state.commentPaging.endOfPage) {
            emit(state.copyWithNull(
              isLoading: false,
              comments: [...state.comments, comment],
              commentPaging: state.commentPaging.copyWith(
                total: state.commentPaging.total + 1,
              ),
              isWritingAnonymousComment: false,
            ));
          } else {
            emit(state.copyWithNull(
              isLoading: false,
              commentPaging: state.commentPaging.copyWith(
                total: state.commentPaging.total + 1,
              ),
              isWritingAnonymousComment: false,
            ));
          }
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnUpdateComment>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<Comment, Exception> updateCommentRes = await _updateComment(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        stockCode: stockCode,
        postId: postId,
        commentId: event.commentId,
        content: event.content,
      );

      updateCommentRes.when(
        (Comment comment) {
          final List<Comment> updatedComments = [...state.comments];
          Comment? updatedComment = updatedComments.firstWhereOrNull((e) => e.id == event.commentId);

          if (updatedComment != null) {
            final int index = updatedComments.indexWhere((e) => e.id == event.commentId);
            if (index >= 0) {
              updatedComments.removeAt(index);
              updatedComments.insert(index, comment);
            }
          }

          emit(state.copyWithNull(
            isLoading: false,
            comments: updatedComments,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnDeleteComment>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<void, Exception> deleteCommentRes = await _deleteComment(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        stockCode: stockCode,
        postId: postId,
        commentId: event.commentId,
      );

      deleteCommentRes.when(
        (_) {
          final List<Comment> updatedComments = [...state.comments];
          Comment? updatedComment = updatedComments.firstWhereOrNull((e) => e.id == event.commentId);

          if (updatedComment != null) {
            updatedComment = updatedComment.copyWith(deleted: true, content: '삭제된 댓글입니다.');
            final int index = updatedComments.indexWhere((e) => e.id == event.commentId);
            if (index >= 0) {
              updatedComments.removeAt(index);
              updatedComments.insert(index, updatedComment);
            }
          }

          emit(state.copyWithNull(
            comments: updatedComments,
            isLoading: false,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnLikeComment>((event, emit) async {
      if (_togglingCommentLike) return;

      _togglingCommentLike = true;

      Result<void, Exception> likeCommentRes = await _likeComment(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        stockCode: stockCode,
        postId: postId,
        commentId: event.commentId,
      );

      likeCommentRes.when(
        (_) {
          final List<Comment> updatedComments = [...state.comments];
          Comment? updatedComment = updatedComments.firstWhereOrNull((e) => e.id == event.commentId);

          if (updatedComment != null) {
            updatedComment = updatedComment.copyWith(
              likeCount: updatedComment.likeCount + 1,
              liked: true,
            );
            final int index = updatedComments.indexWhere((e) => e.id == event.commentId);
            if (index >= 0) {
              updatedComments.removeAt(index);
              updatedComments.insert(index, updatedComment);
            }
          }

          emit(state.copyWithNull(
            comments: updatedComments,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );

      _togglingCommentLike = false;
    });

    on<_OnUnLikeComment>((event, emit) async {
      if (_togglingCommentLike) return;

      _togglingCommentLike = true;

      Result<void, Exception> unlikeCommentRes = await _unlikeComment(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        stockCode: stockCode,
        postId: postId,
        commentId: event.commentId,
      );

      unlikeCommentRes.when(
        (_) {
          final List<Comment> updatedComments = [...state.comments];
          Comment? updatedComment = updatedComments.firstWhereOrNull((e) => e.id == event.commentId);

          if (updatedComment != null) {
            updatedComment = updatedComment.copyWith(
              likeCount: updatedComment.likeCount - 1,
              liked: false,
            );
            final int index = updatedComments.indexWhere((e) => e.id == event.commentId);
            if (index >= 0) {
              updatedComments.removeAt(index);
              updatedComments.insert(index, updatedComment);
            }
          }
          emit(state.copyWithNull(
            comments: updatedComments,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );

      _togglingCommentLike = false;
    });

    on<_OnReportComment>((event, emit) async {
      Result<void, Exception> reportCommentRes = await _reportComment(
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        stockCode: stockCode,
        postId: postId,
        commentId: event.commentId,
        reason: event.reason,
      );

      reportCommentRes.when(
        (_) {
          final List<Comment> updatedComments = [...state.comments];
          Comment? updatedComment = updatedComments.firstWhereOrNull((e) => e.id == event.commentId);

          if (updatedComment != null) {
            updatedComment = updatedComment.copyWith(
              deleted: true,
              content: '신고된 댓글입니다.',
            );
            final int index = updatedComments.indexWhere((e) => e.id == event.commentId);
            if (index >= 0) {
              updatedComments.removeAt(index);
              updatedComments.insert(index, updatedComment);
            }
          }

          emit(state.copyWithNull());
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnBlockComment>((event, emit) async {
      Result<void, Exception> blockRes = await _blockUser(
        targetUserId: event.userId,
      );

      blockRes.when(
        (_) {
          List<Comment> updatedComments = [...state.comments];
          updatedComments = updatedComments.where((e) => e.userId != event.userId).toList();

          emit(state.copyWithNull(
            comments: updatedComments,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnLoadMoreComment>((event, emit) async {
      add(PostDetailEvent.fetchCommentList(page: state.commentPaging.page + 1, isLoadMore: true));
    });

    on<_OnFetchPost>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<Post, Exception> postRes = await _getPostDetail(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
      );

      postRes.when(
        (Post post) {
          emit(state.copyWithNull(
            post: post.copyWith(
                polls: post.polls
                    ?.map((Poll poll) => poll.copyWith(
                        viewType: poll.answers?.isNotEmpty == true ? PollViewType.result : PollViewType.vote))
                    .toList()),
            isLoading: false,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));
        },
      );
    });

    on<_OnFetchCommentList>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<DataResponse<List<Comment>>, Exception> commentRes = await _getCommentList(
        stockCode: stockCode,
        boardGroupType: BoardGroupType.values.byName(boardGroupName.toLowerCase()),
        postId: postId,
        page: event.page,
        sort: state.sortType,
      );

      commentRes.when(
        (DataResponse<List<Comment>> commentData) {
          emit(state.copyWithNull(
            comments:
                event.isLoadMore == true ? [...state.comments, ...(commentData.data ?? [])] : commentData.data ?? [],
            commentPaging: commentData.paging ?? Paging.initial(),
            isLoading: false,
          ));
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));
        },
      );
    });
  }
}

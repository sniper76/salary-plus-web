part of 'reply_list_bloc.dart';

@immutable
abstract class ReplyListEvent {
  const ReplyListEvent._();

  const factory ReplyListEvent.init() = ReplyListOnInit;

  const factory ReplyListEvent.saveReply({
    required String text,
    required bool isAnonymous,
    required int commentId,
    required String boardGroup,
    required int postId,
    required String stockCode,
  }) = ReplyListOnSaveReply;

  const factory ReplyListEvent.toggleCommentLike(Comment comment) = ReplyListOnCommentToggleLike;

  const factory ReplyListEvent.toggleReplyLike(Comment reply) = ReplyListOnReplyToggleLike;

  const factory ReplyListEvent.reportReply(Comment reply, String reason) = ReplyListOnReplyReport;

  const factory ReplyListEvent.deleteReply(Comment reply) = ReplyListOnReplyDelete;

  const factory ReplyListEvent.loadMore() = ReplyListOnLoadMore;

  const factory ReplyListEvent.sort(BoardSortType sortType) = ReplyListOnSort;

  const factory ReplyListEvent.deleteComment({
    required Comment comment,
    required String boardGroup,
    required int postId,
    required String stockCode,
  }) = ReplyListOnCommentDelete;

  const factory ReplyListEvent.activeComment({
    required Comment comment,
    required String boardGroup,
    required int postId,
    required String stockCode,
  }) = ReplyListOnCommentActive;

  const factory ReplyListEvent.editComment({
    required String editedContent,
    required String boardGroup,
    required int postId,
    required int commentId,
    required String stockCode,
  }) = ReplyListOnCommentEdit;

  const factory ReplyListEvent.activateCommentEditingMode(bool isEditingComment, Comment curUpdatingComment) =
      ReplyListOnActivateCommentUpdatingMode;

  const factory ReplyListEvent.updateComment({
    required int commentId,
    required bool isActive,
    required String content,
  }) = ReplyListOnCommentUpdate;
}

class ReplyListOnInit extends ReplyListEvent {
  const ReplyListOnInit() : super._();
}

class ReplyListOnSaveReply extends ReplyListEvent {
  final String text;
  final bool isAnonymous;
  final int commentId;
  final String stockCode;
  final int postId;
  final String boardGroup;

  const ReplyListOnSaveReply({
    required this.text,
    required this.isAnonymous,
    required this.commentId,
    required this.boardGroup,
    required this.postId,
    required this.stockCode,
  }) : super._();
}

class ReplyListOnCommentToggleLike extends ReplyListEvent {
  final Comment comment;

  const ReplyListOnCommentToggleLike(this.comment) : super._();
}

class ReplyListOnReplyToggleLike extends ReplyListEvent {
  final Comment reply;

  const ReplyListOnReplyToggleLike(this.reply) : super._();
}

class ReplyListOnReplyReport extends ReplyListEvent {
  final Comment reply;
  final String reason;

  const ReplyListOnReplyReport(this.reply, this.reason) : super._();
}

class ReplyListOnReplyDelete extends ReplyListEvent {
  final Comment reply;

  const ReplyListOnReplyDelete(this.reply) : super._();
}

class ReplyListOnLoadMore extends ReplyListEvent {
  const ReplyListOnLoadMore() : super._();
}

class ReplyListOnSort extends ReplyListEvent {
  final BoardSortType sortType;

  const ReplyListOnSort(this.sortType) : super._();
}

class ReplyListOnCommentDelete extends ReplyListEvent {
  final Comment comment;
  final String boardGroup;
  final int postId;
  final String stockCode;

  const ReplyListOnCommentDelete({
    required this.comment,
    required this.boardGroup,
    required this.postId,
    required this.stockCode,
  }) : super._();
}

class ReplyListOnCommentActive extends ReplyListEvent {
  final Comment comment;
  final String boardGroup;
  final int postId;
  final String stockCode;

  const ReplyListOnCommentActive({
    required this.comment,
    required this.boardGroup,
    required this.postId,
    required this.stockCode,
  }) : super._();
}

class ReplyListOnCommentEdit extends ReplyListEvent {
  final String editedContent;
  final String boardGroup;
  final int postId;
  final int commentId;
  final String stockCode;

  const ReplyListOnCommentEdit({
    required this.editedContent,
    required this.boardGroup,
    required this.postId,
    required this.commentId,
    required this.stockCode,
  }) : super._();
}

class ReplyListOnCommentUpdate extends ReplyListEvent {
  final int commentId;
  final bool isActive;
  final String content;

  const ReplyListOnCommentUpdate({
    required this.commentId,
    required this.isActive,
    required this.content,
  }) : super._();
}

class ReplyListOnActivateCommentUpdatingMode extends ReplyListEvent {
  final bool isUpdatingComment;
  final Comment curUpdatingComment;

  const ReplyListOnActivateCommentUpdatingMode(this.isUpdatingComment, this.curUpdatingComment) : super._();
}

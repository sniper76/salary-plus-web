part of 'act_comment_list_bloc.dart';

@immutable
abstract class ActCommentListEvent {
  const ActCommentListEvent._();

  const factory ActCommentListEvent.init() = ActCommentListOnInit;

  const factory ActCommentListEvent.refresh() = ActCommentListOnRefresh;

  const factory ActCommentListEvent.updateComment({
    required int commentId,
    required bool isActive,
    required String content,
  }) = ActCommentListOnCommentUpdate;

  const factory ActCommentListEvent.sortComments(BoardSortType sortType) = ActCommentListOnSortComment;

  const factory ActCommentListEvent.loadMoreComments() = ActCommentListOnLoadMoreComment;

  const factory ActCommentListEvent.saveComment({
    required String text,
    required bool isAnonymous,
    required String boardGroup,
    required int postId,
    required String stockCode,
  }) = ActCommentListOnCommentSave;

  const factory ActCommentListEvent.toggleCommentLike(Comment comment) = ActCommentListOnCommentToggleLike;

  const factory ActCommentListEvent.reportComment(Comment comment, String reason) = ActCommentListOnCommentReport;

  const factory ActCommentListEvent.deleteComment({
    required Comment comment,
    required String boardGroup,
    required int postId,
    required String stockCode,
  }) = ActCommentListOnCommentDelete;

  const factory ActCommentListEvent.activeComment({
    required Comment comment,
    required String boardGroup,
    required int postId,
    required String stockCode,
  }) = ActCommentListOnCommentActive;

  const factory ActCommentListEvent.editComment({
    required String editedContent,
    required String boardGroup,
    required int postId,
    required int commentId,
    required String stockCode,
  }) = ActCommentListOnCommentEdit;

  const factory ActCommentListEvent.activateCommentEditingMode(bool isEditingComment, Comment curUpdatingComment) =
      ActCommentListOnActivateCommentUpdatingMode;

  const factory ActCommentListEvent.getCommentsList({int? page, BoardSortType? boardSortType}) =
      ActCommentListOnGetCommentsList;
}

class ActCommentListOnInit extends ActCommentListEvent {
  const ActCommentListOnInit() : super._();
}

class ActCommentListOnRefresh extends ActCommentListEvent {
  const ActCommentListOnRefresh() : super._();
}

class ActCommentListOnCommentUpdate extends ActCommentListEvent {
  final int commentId;
  final bool isActive;
  final String content;

  const ActCommentListOnCommentUpdate({
    required this.commentId,
    required this.isActive,
    required this.content,
  }) : super._();
}

class ActCommentListOnSortComment extends ActCommentListEvent {
  final BoardSortType sortType;

  const ActCommentListOnSortComment(this.sortType) : super._();
}

class ActCommentListOnLoadMoreComment extends ActCommentListEvent {
  const ActCommentListOnLoadMoreComment() : super._();
}

class ActCommentListOnCommentSave extends ActCommentListEvent {
  final String text;
  final bool isAnonymous;
  final String boardGroup;
  final int postId;
  final String stockCode;

  const ActCommentListOnCommentSave({
    required this.text,
    required this.isAnonymous,
    required this.boardGroup,
    required this.postId,
    required this.stockCode,
  }) : super._();
}

class ActCommentListOnCommentToggleLike extends ActCommentListEvent {
  final Comment comment;

  const ActCommentListOnCommentToggleLike(this.comment) : super._();
}

class ActCommentListOnCommentReport extends ActCommentListEvent {
  final Comment comment;
  final String reason;

  const ActCommentListOnCommentReport(this.comment, this.reason) : super._();
}

class ActCommentListOnCommentDelete extends ActCommentListEvent {
  final Comment comment;
  final String boardGroup;
  final int postId;
  final String stockCode;

  const ActCommentListOnCommentDelete({
    required this.comment,
    required this.boardGroup,
    required this.postId,
    required this.stockCode,
  }) : super._();
}

class ActCommentListOnCommentActive extends ActCommentListEvent {
  final Comment comment;
  final String boardGroup;
  final int postId;
  final String stockCode;

  const ActCommentListOnCommentActive({
    required this.comment,
    required this.boardGroup,
    required this.postId,
    required this.stockCode,
  }) : super._();
}

class ActCommentListOnCommentEdit extends ActCommentListEvent {
  final String editedContent;
  final String boardGroup;
  final int postId;
  final int commentId;
  final String stockCode;

  const ActCommentListOnCommentEdit({
    required this.editedContent,
    required this.boardGroup,
    required this.postId,
    required this.commentId,
    required this.stockCode,
  }) : super._();
}

class ActCommentListOnActivateCommentUpdatingMode extends ActCommentListEvent {
  final bool isUpdatingComment;
  final Comment curUpdatingComment;

  const ActCommentListOnActivateCommentUpdatingMode(this.isUpdatingComment, this.curUpdatingComment) : super._();
}

class ActCommentListOnGetCommentsList extends ActCommentListEvent {
  final int? page;
  final BoardSortType? boardSortType;

  const ActCommentListOnGetCommentsList({this.page, this.boardSortType}) : super._();
}

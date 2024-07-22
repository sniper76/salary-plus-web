part of 'bloc.dart';

@freezed
class PostDetailEvent with _$PostDetailEvent {
  const factory PostDetailEvent.init() = _OnInit;

  const factory PostDetailEvent.fetchPost() = _OnFetchPost;

  const factory PostDetailEvent.deletePost(int postId) = _OnDeletePost;

  const factory PostDetailEvent.likePost(int postId) = _OnLikePost;

  const factory PostDetailEvent.unLikePost(int postId) = _OnUnLikePost;

  const factory PostDetailEvent.reportPost(int postId, String reason) = _OnReportPost;

  const factory PostDetailEvent.blockPost(int userId) = _OnBlockPost;

  const factory PostDetailEvent.votePoll(List<int> answerIdList, int pollId) = _OnVotePoll;

  const factory PostDetailEvent.reVotePoll(int pollId) = _OnReVotePoll;

  // Comment

  const factory PostDetailEvent.changeCommentSortType(BoardSortType sortType) = _OnChangeCommentSortType;

  const factory PostDetailEvent.fetchCommentList({required int page, int? size, bool? isLoadMore}) =
      _OnFetchCommentList;

  const factory PostDetailEvent.toggleAnonymousCommentWriting() = _OnToggleAnonymousCommentWriting;

  const factory PostDetailEvent.toggleUpdatingComment(int? commentId) = _OnToggleUpdatingCommentWriting;

  const factory PostDetailEvent.createComment(String content) = _OnCreateComment;

  const factory PostDetailEvent.updateComment({required int commentId, required String content}) = _OnUpdateComment;

  const factory PostDetailEvent.deleteComment({required int commentId}) = _OnDeleteComment;

  const factory PostDetailEvent.likeComment(int commentId) = _OnLikeComment;

  const factory PostDetailEvent.unLikeComment(int commentId) = _OnUnLikeComment;

  const factory PostDetailEvent.reportComment(int commentId, String reason) = _OnReportComment;

  const factory PostDetailEvent.blockComment(int userId) = _OnBlockComment;

  const factory PostDetailEvent.loadMoreComment() = _OnLoadMoreComment;
}

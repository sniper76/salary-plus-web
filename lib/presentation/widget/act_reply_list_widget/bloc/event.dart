part of 'bloc.dart';

@freezed
class ActReplyListWidgetEvent with _$ActReplyListWidgetEvent {
  const factory ActReplyListWidgetEvent.init() = _OnInit;

  const factory ActReplyListWidgetEvent.refresh() = _OnRefresh;

  const factory ActReplyListWidgetEvent.fetchReplyList({required int page, int? size}) = _OnFetchReplyList;

  const factory ActReplyListWidgetEvent.toggleIsWritingReply() = _OnToggleIsWritingReply;

  const factory ActReplyListWidgetEvent.toggleUpdatingReply(int? replyId) = _OnToggleUpdatingWriting;

  const factory ActReplyListWidgetEvent.toggleAnonymousWriting() = _OnToggleAnonymousWriting;

  const factory ActReplyListWidgetEvent.createReply(String content) = _OnCreateReply;

  const factory ActReplyListWidgetEvent.updateReply(
      {required int replyId, required String content, required bool isAnonymous}) = _OnUpdateReply;

  const factory ActReplyListWidgetEvent.deleteReply({required int replyId}) = _OnDeleteReply;

  const factory ActReplyListWidgetEvent.like(int replyId) = _OnLikeReply;

  const factory ActReplyListWidgetEvent.unLike(int replyId) = _OnUnLikeReply;

  const factory ActReplyListWidgetEvent.reportReply(int replyId, String reason) = _OnReportReply;

  const factory ActReplyListWidgetEvent.blockReply(int userId) = _OnBlockReply;

  const factory ActReplyListWidgetEvent.loadMore() = _OnLoadMore;
}

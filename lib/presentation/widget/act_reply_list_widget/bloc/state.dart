part of 'bloc.dart';

@freezed
class ActReplyListWidgetState with _$ActReplyListWidgetState, BaseStateMixin, PagingState {
  const ActReplyListWidgetState._();

  const factory ActReplyListWidgetState({
    required List<Comment> replyList,
    required bool isLoading,
    required Paging replyPaging,
    required int remainingReplyCount,
    @Default(false) bool hasMoreReplies,
    @Default(false) bool isWritingReply,
    @Default(false) bool isWritingAnonymousReply,
    @Default(null) int? updatingReplyId,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
  }) = _ActPostListWidgetState;

  factory ActReplyListWidgetState.initial() {
    return ActReplyListWidgetState(
      remainingReplyCount: 0,
      isLoading: false,
      replyList: [],
      replyPaging: Paging.initial().copyWith(size: 20),
      errorToastMessage: null,
      notiToastMessage: null,
    );
  }

  @override
  Paging get paging => replyPaging;
}

extension ActReplyListWidgetStateExtension on ActReplyListWidgetState {
  ActReplyListWidgetState copyWithNull({
    List<Comment>? replyList,
    bool? isLoading,
    Paging? replyPaging,
    int? remainingReplyCount,
    bool? hasMoreReplies,
    bool? isWritingReply,
    bool? isWritingAnonymousReply,
    int? updatingReplyId,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return ActReplyListWidgetState(
      replyList: replyList ?? this.replyList,
      isLoading: isLoading ?? this.isLoading,
      replyPaging: replyPaging ?? this.replyPaging,
      remainingReplyCount: remainingReplyCount ?? this.remainingReplyCount,
      hasMoreReplies: hasMoreReplies ?? this.hasMoreReplies,
      isWritingReply: isWritingReply ?? this.isWritingReply,
      isWritingAnonymousReply: isWritingAnonymousReply ?? this.isWritingAnonymousReply,
      updatingReplyId: updatingReplyId ?? this.updatingReplyId,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}

part of 'bloc.dart';

@freezed
class PostDetailState with _$PostDetailState, BaseStateMixin {
  factory PostDetailState({
    required bool isLoading,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
    @Default(null) Post? post,
    required BoardSortType sortType,
    required List<Comment> comments,
    @Default(null) int? updatingCommentId,
    required Paging commentPaging,
    required bool onPopScreen,
    @Default(false) bool isWritingAnonymousComment,
    @Default(null) WriteCount? anonymousCommentWriteCount,
  }) = _PostDetailState;

  factory PostDetailState.initial() {
    return PostDetailState(
      isLoading: true,
      onPopScreen: false,
      errorToastMessage: null,
      notiToastMessage: null,
      sortType: BoardSortType.createdAtAsc,
      comments: [],
      commentPaging: Paging.initial(),
    );
  }
}

extension PostDetailStateExtension on PostDetailState {
  PostDetailState copyWithNull({
    bool? isLoading,
    String? errorToastMessage,
    String? notiToastMessage,
    Post? post,
    BoardSortType? sortType,
    List<Comment>? comments,
    int? updatingCommentId,
    Paging? commentPaging,
    bool? onPopScreen,
    bool? isWritingAnonymousComment,
    WriteCount? anonymousCommentWriteCount,
  }) {
    return PostDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
      post: post ?? this.post,
      sortType: sortType ?? this.sortType,
      comments: comments ?? this.comments,
      updatingCommentId: updatingCommentId ?? this.updatingCommentId,
      commentPaging: commentPaging ?? this.commentPaging,
      onPopScreen: onPopScreen ?? false,
      isWritingAnonymousComment: isWritingAnonymousComment ?? this.isWritingAnonymousComment,
      anonymousCommentWriteCount: anonymousCommentWriteCount ?? this.anonymousCommentWriteCount,
    );
  }
}

part of 'reply_list_bloc.dart';

@immutable
class ReplyListState extends BaseState {
  final User? userMe;
  final Comment? comment;
  final BoardSortType sortType;
  final List<Comment> replies;
  final bool isLoadMore;
  final bool isSuccessReplySaved;
  final bool isEditingComment;
  final Comment? curEditingComment;

  const ReplyListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.userMe,
    this.sortType = BoardSortType.createdAtAsc,
    this.comment,
    this.replies = const [],
    this.isLoadMore = false,
    this.isSuccessReplySaved = false,
    this.isEditingComment = false,
    this.curEditingComment,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  ReplyListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    User? userMe,
    BoardSortType? sortType,
    Comment? comment,
    List<Comment>? replies,
    bool? isLoadMore,
    bool? isSuccessReplySaved,
    bool? isEditingComment,
    Comment? curEditingComment,
  }) {
    return ReplyListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      userMe: userMe ?? this.userMe,
      sortType: sortType ?? this.sortType,
      comment: comment ?? this.comment,
      replies: replies ?? this.replies,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      isSuccessReplySaved: isSuccessReplySaved ?? this.isSuccessReplySaved,
      isEditingComment: isEditingComment ?? this.isEditingComment,
      curEditingComment: curEditingComment ?? this.curEditingComment,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        userMe,
        sortType,
        comment,
        replies,
        isLoadMore,
        isSuccessReplySaved,
        isEditingComment,
        curEditingComment,
      ];
}

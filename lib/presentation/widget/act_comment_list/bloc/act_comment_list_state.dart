part of 'act_comment_list_bloc.dart';

@immutable
class ActCommentListState extends BaseState implements PagingState {
  final User? userMe;
  final Post post;
  final Comment? curEditingComment;
  final BoardSortType sortType;
  final List<Comment> comments;
  @override
  final Paging paging;
  final bool isNotFound;
  final bool isOwner;
  final bool isCommentMoreLoading;
  final bool isSuccessCommentSaved;
  final bool isNotification;
  final bool isActive;
  final bool isEditingComment;
  final bool onPopScreen;
  final String? digitalProxyEmbeddedUrl;

  const ActCommentListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.userMe,
    required this.post,
    this.curEditingComment,
    this.sortType = BoardSortType.createdAtAsc,
    this.comments = const [],
    this.paging = const Paging(page: 1, size: 20),
    this.isNotFound = false,
    this.isOwner = false,
    this.isCommentMoreLoading = false,
    this.isSuccessCommentSaved = false,
    this.onPopScreen = false,
    this.isNotification = false,
    this.isActive = true,
    this.isEditingComment = false,
    this.digitalProxyEmbeddedUrl,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  ActCommentListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    User? userMe,
    Post? post,
    BoardSortType? sortType,
    List<Comment>? comments,
    Paging? paging,
    bool? isNotFound,
    bool? isOwner,
    bool? isSuccessCommentSaved,
    bool? isCommentMoreLoading,
    bool? isSuccessPollAnswer,
    bool? onPopScreen,
    bool? isNotification,
    bool? isActive,
    bool? isEditingComment,
    String? digitalProxyEmbeddedUrl,
    DigitalDocument? digitalDocument,
    Comment? curEditingComment,
  }) {
    return ActCommentListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      userMe: userMe ?? this.userMe,
      post: post ?? this.post,
      sortType: sortType ?? this.sortType,
      comments: comments ?? this.comments,
      paging: paging ?? this.paging,
      isNotFound: isNotFound ?? this.isNotFound,
      isOwner: isOwner ?? this.isOwner,
      isCommentMoreLoading: isCommentMoreLoading ?? this.isCommentMoreLoading,
      isSuccessCommentSaved: isSuccessCommentSaved ?? this.isSuccessCommentSaved,
      onPopScreen: onPopScreen ?? this.onPopScreen,
      digitalProxyEmbeddedUrl: digitalProxyEmbeddedUrl ?? this.digitalProxyEmbeddedUrl,
      isNotification: isNotification ?? this.isNotification,
      isActive: isActive ?? this.isActive,
      isEditingComment: isEditingComment ?? this.isEditingComment,
      curEditingComment: curEditingComment ?? this.curEditingComment,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        userMe,
        post,
        sortType,
        comments,
        paging,
        isNotFound,
        isOwner,
        isSuccessCommentSaved,
        isCommentMoreLoading,
        onPopScreen,
        digitalProxyEmbeddedUrl,
        isNotification,
        isActive,
        isEditingComment,
        curEditingComment,
      ];
}

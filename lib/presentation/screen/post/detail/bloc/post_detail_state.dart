part of 'post_detail_bloc.dart';

@immutable
class PostDetailState extends BaseState {
  final User? userMe;
  final Post? post;
  final bool isNotFound;
  final bool isOwner;
  final bool isSuccessPollAnswer;
  final bool isNotification;
  final bool isActive;
  final bool onPopScreen;
  final bool isShowingSolidarityApplication;
  final String? digitalProxyEmbeddedUrl;
  final String? holderListReadAndCopyDownloadLink;
  final DigitalDocument? digitalDocument;
  final SolidarityLeaderElectionApplication? electionApplication;

  const PostDetailState({
    bool isLoading = false,
    String? errorToastMessage,
    this.userMe,
    this.post,
    this.isNotFound = false,
    this.isOwner = false,
    this.isSuccessPollAnswer = false,
    this.onPopScreen = false,
    this.isNotification = false,
    this.isActive = true,
    this.isShowingSolidarityApplication = false,
    this.digitalProxyEmbeddedUrl,
    this.holderListReadAndCopyDownloadLink,
    this.digitalDocument,
    this.electionApplication,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostDetailState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    User? userMe,
    Post? post,
    BoardSortType? sortType,
    List<Comment>? comments,
    bool? isNotFound,
    bool? isOwner,
    int? totalCommentCount,
    bool? isCommentMore,
    bool? isSuccessCommentSaved,
    bool? isCommentMoreLoading,
    bool? isSuccessPollAnswer,
    bool? onPopScreen,
    bool? isNotification,
    bool? isActive,
    bool? isShowingSolidarityApplication,
    String? digitalProxyEmbeddedUrl,
    String? holderListReadAndCopyDownloadLink,
    DigitalDocument? digitalDocument,
    SolidarityLeaderElectionApplication? electionApplication,
  }) {
    return PostDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      userMe: userMe ?? this.userMe,
      post: post ?? this.post,
      isNotFound: isNotFound ?? this.isNotFound,
      isOwner: isOwner ?? this.isOwner,
      isSuccessPollAnswer: isSuccessPollAnswer ?? this.isSuccessPollAnswer,
      onPopScreen: onPopScreen ?? this.onPopScreen,
      digitalProxyEmbeddedUrl: digitalProxyEmbeddedUrl ?? this.digitalProxyEmbeddedUrl,
      holderListReadAndCopyDownloadLink: holderListReadAndCopyDownloadLink ?? '',
      digitalDocument: digitalDocument ?? this.digitalDocument,
      isNotification: isNotification ?? this.isNotification,
      isShowingSolidarityApplication: isShowingSolidarityApplication ?? this.isShowingSolidarityApplication,
      isActive: isActive ?? this.isActive,
      electionApplication: electionApplication ?? this.electionApplication,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        userMe,
        post,
        isNotFound,
        isOwner,
        onPopScreen,
        digitalProxyEmbeddedUrl,
        holderListReadAndCopyDownloadLink,
        digitalDocument,
        isNotification,
        isShowingSolidarityApplication,
        isActive,
        electionApplication
      ];
}

part of 'bloc.dart';

@immutable
class ActionState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final List<Post> postList;
  final String searchKeyword;
  final BoardGroupType boardGroup;
  final BoardSearchType searchType;
  final BoardGroupCategory? boardCategory;
  final List<BoardGroupCategory> boardCategoryList;
  final PostStatusType postStatusType;
  final List<SimpleStock> sourceCandidateStockList;
  final bool refreshPage;
  final SimpleStock? selectedSimpleStock;
  final bool isZipLoading;
  final Post? selectedPost;
  final Post? selectedPostDetail;
  final int retryCount;
  final bool isSuccessChangeReferenceDay;

  const ActionState({
    this.boardGroup = BoardGroupType.action,
    this.searchType = BoardSearchType.title,
    this.postList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.searchKeyword = "",
    this.boardCategory,
    this.boardCategoryList = const [],
    this.postStatusType = PostStatusType.all,
    this.refreshPage = false,
    this.sourceCandidateStockList = const [],
    this.selectedSimpleStock,
    this.isZipLoading = false,
    this.selectedPost,
    this.selectedPostDetail,
    this.retryCount = 0,
    this.isSuccessChangeReferenceDay = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  ActionState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<Post>? postList,
    String? searchKeyword,
    Paging? paging,
    BoardSearchType? searchType,
    BoardGroupType? boardGroupType,
    BoardGroupCategory? boardCategory,
    List<BoardGroupCategory>? boardCategoryList,
    PostStatusType? postStatusType,
    bool? refreshPage,
    List<SimpleStock>? sourceCandidateStockList,
    SimpleStock? selectedSimpleStock,
    bool clearSimpleStock = false,
    bool? isZipLoading,
    Post? selectedPost,
    Post? selectedPostDetail,
    int? retryCount,
    bool? isSuccessChangeReferenceDay,
  }) {
    return ActionState(
      boardGroup: boardGroupType ?? boardGroup,
      searchType: searchType ?? this.searchType,
      postList: postList ?? this.postList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      searchKeyword: searchKeyword ?? this.searchKeyword,
      paging: paging ?? this.paging,
      boardCategory: boardCategory ?? this.boardCategory,
      boardCategoryList: boardCategoryList ?? this.boardCategoryList,
      postStatusType: postStatusType ?? this.postStatusType,
      refreshPage: refreshPage ?? this.refreshPage,
      sourceCandidateStockList: sourceCandidateStockList ?? this.sourceCandidateStockList,
      selectedSimpleStock: clearSimpleStock ? null : selectedSimpleStock ?? this.selectedSimpleStock,
      isZipLoading: isZipLoading ?? this.isZipLoading,
      selectedPost: selectedPost ?? this.selectedPost,
      selectedPostDetail: selectedPostDetail ?? this.selectedPostDetail,
      retryCount: retryCount ?? this.retryCount,
      isSuccessChangeReferenceDay: isSuccessChangeReferenceDay ?? this.isSuccessChangeReferenceDay,
    );
  }

  List<Post> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        postList,
        searchKeyword,
        searchType,
        boardCategory,
        boardCategoryList,
        postStatusType,
        refreshPage,
        selectedSimpleStock,
        sourceCandidateStockList,
        isZipLoading,
        selectedPost,
        selectedPostDetail,
        retryCount,
        isSuccessChangeReferenceDay,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}

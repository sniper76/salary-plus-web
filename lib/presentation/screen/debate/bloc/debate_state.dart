part of 'debate_bloc.dart';

@immutable
class PostState extends BaseState implements PagingState {
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
  final SimpleStock? selectedSimpleStock;
  final bool refreshPage;

  const PostState({
    this.boardGroup = BoardGroupType.debate,
    this.searchType = BoardSearchType.title,
    this.postList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.searchKeyword = "",
    this.boardCategory,
    this.boardCategoryList = const [],
    this.postStatusType = PostStatusType.all,
    this.sourceCandidateStockList = const [],
    this.selectedSimpleStock,
    this.refreshPage = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostState copyWith({
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
    List<SimpleStock>? sourceCandidateStockList,
    SimpleStock? selectedSimpleStock,
    bool? refreshPage,
  }) {
    return PostState(
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
      sourceCandidateStockList: sourceCandidateStockList ?? this.sourceCandidateStockList,
      selectedSimpleStock: selectedSimpleStock ?? this.selectedSimpleStock,
      refreshPage: refreshPage ?? this.refreshPage,
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
        sourceCandidateStockList,
        selectedSimpleStock,
        refreshPage,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}

part of 'bloc.dart';

@immutable
class PostState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final int paginatorIndex;
  final List<Post> postList;
  final String searchKeyword;
  final BoardGroupType boardGroup;
  final BoardSearchType searchType;
  final BoardGroupCategory? boardCategory;
  final List<BoardGroupCategory> boardCategoryList;
  final PostStatusType postStatusType;
  final bool refreshPage;

  const PostState({
    this.boardGroup = BoardGroupType.globalboard,
    this.searchType = BoardSearchType.title,
    this.postList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.paginatorIndex = 0,
    this.searchKeyword = "",
    this.boardCategory,
    this.boardCategoryList = const [],
    this.postStatusType = PostStatusType.all,
    this.refreshPage = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<Post>? postList,
    String? searchKeyword,
    Paging? paging,
    int? paginatorIndex,
    BoardSearchType? searchType,
    BoardGroupType? boardGroupType,
    BoardGroupCategory? boardCategory,
    List<BoardGroupCategory>? boardCategoryList,
    PostStatusType? postStatusType,
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
      paginatorIndex: paginatorIndex ?? this.paginatorIndex,
      boardCategory: boardCategory ?? this.boardCategory,
      boardCategoryList: boardCategoryList ?? this.boardCategoryList,
      postStatusType: postStatusType ?? this.postStatusType,
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
        paginatorIndex,
        searchType,
        boardCategory,
        boardCategoryList,
        postStatusType,
        refreshPage,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}

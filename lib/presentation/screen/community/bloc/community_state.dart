part of 'community_bloc.dart';

@immutable
class CommunityState extends BaseState implements PagingState {
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

  const CommunityState({
    this.boardGroup = BoardGroupType.globalcommunity,
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

  CommunityState copyWith({
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
    return CommunityState(
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

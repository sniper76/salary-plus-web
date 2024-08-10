part of 'bloc.dart';

@immutable
class PostState extends BaseState implements PagingState {
  @override
  final Paging paging;

  final BoardGroupType boardGroup;
  final BoardGroupCategory? boardCategory;

  final BoardSearchType sourceSearchType;
  final List<SimpleStock> sourceCandidateStockList;
  final SimpleStock? sourceSimpleStock;
  final Post? sourceSelectedPost;
  final List<Post> sourcePostList;
  final String sourceSearchKeyword;

  final SimpleStockGroup? targetStockGroup;
  final BoardTargetSearchType targetSearchType;
  final List<SimpleStock> targetCandidateStockList;
  final List<SimpleStockGroup> targetCandidateStockGroupList;
  final SimpleStock? targetSimpleStock;
  final String targetSearchKeyword;

  final bool isComplete;

  const PostState({
    required this.boardGroup,
    this.boardCategory,
    this.sourceSearchType = BoardSearchType.title,
    this.sourceCandidateStockList = const [],
    this.sourceSelectedPost,
    this.sourcePostList = const [],
    this.sourceSimpleStock,
    this.sourceSearchKeyword = "",
    this.targetStockGroup,
    this.targetSearchType = BoardTargetSearchType.stockname,
    this.targetCandidateStockList = const [],
    this.targetCandidateStockGroupList = const [],
    this.targetSimpleStock,
    this.targetSearchKeyword = "",
    this.paging = const Paging(page: 1, size: apiLoadSize),
    bool isLoading = false,
    String? errorToastMessage,
    this.isComplete = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostState copyWith({
    Paging? paging,
    BoardGroupType? boardGroup,
    BoardGroupCategory? boardCategory,
    BoardSearchType? sourceSearchType,
    List<SimpleStock>? sourceCandidateStockList,
    SimpleStock? sourceSimpleStock,
    Post? sourceSelectedPost,
    List<Post>? sourcePostList,
    String? sourceSearchKeyword,
    SimpleStockGroup? targetStockGroup,
    BoardTargetSearchType? targetSearchType,
    List<SimpleStock>? targetCandidateStockList,
    List<SimpleStockGroup>? targetCandidateStockGroupList,
    SimpleStock? targetSimpleStock,
    String? targetSearchKeyword,
    bool? isLoading,
    String? errorToastMessage,
    bool? isComplete,
  }) {
    return PostState(
      boardGroup: boardGroup ?? this.boardGroup,
      boardCategory: boardCategory ?? this.boardCategory,
      sourceSearchType: sourceSearchType ?? this.sourceSearchType,
      sourceCandidateStockList: sourceCandidateStockList ?? this.sourceCandidateStockList,
      sourceSimpleStock: sourceSimpleStock ?? this.sourceSimpleStock,
      sourceSelectedPost: sourceSelectedPost ?? this.sourceSelectedPost,
      sourcePostList: sourcePostList ?? this.sourcePostList,
      sourceSearchKeyword: sourceSearchKeyword ?? this.sourceSearchKeyword,
      targetStockGroup: targetStockGroup ?? this.targetStockGroup,
      targetSearchType: targetSearchType ?? this.targetSearchType,
      targetCandidateStockList: targetCandidateStockList ?? this.targetCandidateStockList,
      targetCandidateStockGroupList: targetCandidateStockGroupList ?? this.targetCandidateStockGroupList,
      targetSimpleStock: targetSimpleStock ?? this.targetSimpleStock,
      targetSearchKeyword: targetSearchKeyword ?? this.targetSearchKeyword,
      paging: paging ?? this.paging,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? this.errorToastMessage,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  List<Post> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        paging,
        boardGroup,
        boardCategory,
        sourceSearchType,
        sourceCandidateStockList,
        sourceSimpleStock,
        sourceSelectedPost,
        sourcePostList,
        sourceSearchKeyword,
        targetStockGroup,
        targetSearchType,
        targetSimpleStock,
        targetCandidateStockList,
        targetCandidateStockGroupList,
        targetSearchKeyword,
        isLoading,
        errorToastMessage,
        isComplete,
      ];

//
}

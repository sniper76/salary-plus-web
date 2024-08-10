part of 'bloc.dart';

@immutable
class PostState extends BaseState {
  // 기본 설정
  final BoardGroupType boardGroupType;

  // 종목 설정
  final String? stockSearchKeyword;
  final List<SimpleStock> candiatedStockList;
  final List<SimpleStockGroup> candidateStockGroupList;

  // 게시판 선택
  final List<BoardGroupCategory> boardGroupCategories;
  final List<BoardGroupCategory> boardCategoryList;
  final BoardGroupCategory? selectedBoardGroupCategory;

  // 노출/미노출
  final bool isActive;

  // 주주만 공개 / 전체 공개
  final bool isExclusiveToHolders;

  // 알림
  final bool isNotification;

  // 기간
  final DateTime? pollTargetDate;
  final DateTime? digitalProxyTargetDate;
  final DateTime? digitalDocumentTargetDate;

  // 제목
  final String? title;
  final String? campaignTitle;

  final Post? updatedPost;
  final SimpleStock? stockCode;
  final SimpleStockGroup? stockCodeGroup;

  final String? content;
  final List<UploadImageFile> uploadImageFiles;
  final bool onClose;

  final bool isComplete;

  const PostState({
    bool isLoading = false,
    String? errorToastMessage,
    this.boardGroupCategories = const [],
    this.selectedBoardGroupCategory,
    this.uploadImageFiles = const [],
    this.updatedPost,
    this.stockCode,
    this.stockCodeGroup,
    this.isActive = true,
    this.isNotification = false,
    this.isExclusiveToHolders = false,
    this.boardGroupType = BoardGroupType.globalboard,
    this.title,
    this.campaignTitle,
    this.content,
    this.stockSearchKeyword,
    this.candiatedStockList = const [],
    this.candidateStockGroupList = const [],
    this.boardCategoryList = const [],
    this.onClose = false,
    this.pollTargetDate,
    this.digitalProxyTargetDate,
    this.digitalDocumentTargetDate,
    this.isComplete = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<BoardGroupCategory>? boardGroupCategories,
    BoardGroupCategory? selectedBoardGroupCategory,
    List<UploadImageFile>? uploadImageFiles,
    Post? updatedPost,
    SimpleStock? stockCode,
    SimpleStockGroup? stockCodeGroup,
    bool? isActive,
    bool? isNotification,
    bool? isExclusiveToHolders,
    BoardGroupType? boardGroupType,
    String? title,
    String? campaignTitle,
    String? content,
    String? stockSearchKeyword,
    List<SimpleStock>? candiatedStockList,
    List<SimpleStockGroup>? candidateStockGroupList,
    List<BoardGroupCategory>? boardCategoryList,
    bool? onClose,
    DateTime? pollTargetDate,
    DateTime? digitalProxyTargetDate,
    DateTime? digitalDocumentTargetDate,
    bool? isComplete,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      boardGroupCategories: boardGroupCategories ?? this.boardGroupCategories,
      selectedBoardGroupCategory: selectedBoardGroupCategory ?? this.selectedBoardGroupCategory,
      uploadImageFiles: uploadImageFiles ?? this.uploadImageFiles,
      updatedPost: updatedPost ?? this.updatedPost,
      stockCode: stockCode ?? this.stockCode,
      stockCodeGroup: stockCodeGroup ?? this.stockCodeGroup,
      isActive: isActive ?? this.isActive,
      isNotification: isNotification ?? this.isNotification,
      isExclusiveToHolders: isExclusiveToHolders ?? this.isExclusiveToHolders,
      boardGroupType: boardGroupType ?? this.boardGroupType,
      title: title ?? this.title,
      campaignTitle: campaignTitle ?? this.campaignTitle,
      content: content ?? this.content,
      stockSearchKeyword: stockSearchKeyword ?? this.stockSearchKeyword,
      candiatedStockList: candiatedStockList ?? this.candiatedStockList,
      candidateStockGroupList: candidateStockGroupList ?? this.candidateStockGroupList,
      boardCategoryList: boardCategoryList ?? this.boardCategoryList,
      onClose: onClose ?? this.onClose,
      pollTargetDate: pollTargetDate ?? this.pollTargetDate,
      digitalProxyTargetDate: digitalProxyTargetDate ?? this.digitalProxyTargetDate,
      digitalDocumentTargetDate: digitalDocumentTargetDate ?? this.digitalDocumentTargetDate,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        boardGroupType,
        stockSearchKeyword,
        candiatedStockList,
        boardGroupCategories,
        boardCategoryList,
        selectedBoardGroupCategory,
        isActive,
        isNotification,
        isExclusiveToHolders,
        title,
        campaignTitle,
        updatedPost,
        stockCode,
        stockCodeGroup,
        content,
        uploadImageFiles,
        onClose,
        pollTargetDate,
        digitalProxyTargetDate,
        digitalDocumentTargetDate,
        isComplete,
        candidateStockGroupList
      ];
}

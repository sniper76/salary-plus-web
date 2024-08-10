part of 'bloc.dart';

@immutable
class PostState extends BaseState {
  // 기본 설정
  final BoardGroupType boardGroupType;
  final List<ActionDocumentType> actionDocumentTypeList;
  final ActionDocumentType? selectedActionDocumentType;
  final List<Poll>? polls;
  final DigitalDocument? digitalDocument;
  final DigitalProxy? digitalProxy;
  final DigitalDocumentType selectedDigitalDocumentCategory;
  final bool isActive;
  final List<SimpleStock> targetCandidateStockList;
  final List<SimpleStockGroup> targetCandidateStockGroupList;
  final String? title;
  final String? campaignTitle;
  final Post? updatedPost;
  final SimpleStock? stockCode;
  final SimpleStockGroup? stockGroup;
  final String? content;
  final List<UploadImageFile> uploadImageFiles;
  final List<BoardTargetSearchType> searchTypeList;
  final BoardTargetSearchType targetSearchType;
  final String startDate;
  final String endDate;
  final List<DigitalDocumentType> digitalDocumentCategoryList;
  final bool isPreviewOn;
  final String? pdf;
  final StockDetail? stockDetail;
  final User? user;
  final ActionPostType? postType;
  final List<StockReferenceDate> stockReferenceDateList;
  final StockReferenceDate? selectedReferenceDay;
  final String completeMsg;
  final bool isNotification;
  final StockReferenceDate? selectReferenceTime;
  final List<PollRegisterResult> pollResults;

  const PostState({
    this.user,
    this.postType,
    this.stockDetail,
    this.title,
    this.campaignTitle,
    this.updatedPost,
    this.content,
    this.uploadImageFiles = const [],
    this.boardGroupType = BoardGroupType.action,
    this.actionDocumentTypeList = const [
      ActionDocumentType.poll,
      ActionDocumentType.digitalDocument,
      ActionDocumentType.allsign
    ],
    this.selectedActionDocumentType = ActionDocumentType.poll,
    this.selectedDigitalDocumentCategory = DigitalDocumentType.digitalProxy,
    this.digitalDocumentCategoryList = const [
      DigitalDocumentType.digitalProxy,
      DigitalDocumentType.jointOwnership,
      DigitalDocumentType.etc
    ],
    this.stockCode,
    this.stockGroup,
    this.polls = const [],
    this.pollResults = const [],
    this.digitalDocument,
    this.digitalProxy,
    bool isLoading = false,
    String? errorToastMessage,
    this.isActive = false,
    this.targetCandidateStockList = const [],
    this.targetCandidateStockGroupList = const [],
    this.searchTypeList = const [BoardTargetSearchType.stockname, BoardTargetSearchType.groupname],
    this.targetSearchType = BoardTargetSearchType.stockname,
    this.startDate = "2023/02/11",
    this.endDate = "2023/02/11",
    this.isPreviewOn = false,
    this.selectReferenceTime,
    this.pdf,
    this.stockReferenceDateList = const [],
    this.selectedReferenceDay,
    this.completeMsg = "",
    this.isNotification = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PostState copyWith({
    List<ActionDocumentType>? actionDocumentTypeList,
    bool? isLoading,
    String? errorToastMessage,
    BoardGroupType? boardGroupType,
    ActionDocumentType? selectedActionDocumentType,
    SimpleStock? selectedStock,
    DigitalDocument? digitalDocument,
    DigitalProxy? digitalProxy,
    DigitalDocumentType? selectedDigitalDocumentCategory,
    bool? isActive,
    List<SimpleStock>? targetCandidateStockList,
    List<SimpleStockGroup>? targetCandidateStockGroupList,
    String? title,
    String? campaignTitle,
    Post? updatedPost,
    SimpleStock? stockCode,
    SimpleStockGroup? stockGroup,
    StockDetail? stockDetail,
    String? content,
    List<UploadImageFile>? uploadImageFiles,
    List<BoardTargetSearchType>? searchTypeList,
    BoardTargetSearchType? targetSearchType,
    String? startDate,
    String? endDate,
    List<DigitalDocumentType>? digitalDocumentCategoryList,
    bool? isPreviewOn,
    String? pdf,
    User? user,
    ActionPostType? postType,
    List<StockReferenceDate>? stockReferenceDateList,
    StockReferenceDate? selectedReferenceDay,
    String? completeMsg,
    bool? isNotification,
    StockReferenceDate? selectReferenceTime,
    List<PollRegisterResult>? pollResults,
  }) {
    return PostState(
      user: user ?? this.user,
      stockDetail: stockDetail ?? this.stockDetail,
      actionDocumentTypeList: actionDocumentTypeList ?? this.actionDocumentTypeList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      boardGroupType: boardGroupType ?? this.boardGroupType,
      selectedActionDocumentType: selectedActionDocumentType ?? this.selectedActionDocumentType,
      polls: polls ?? polls,
      digitalDocument: digitalDocument ?? this.digitalDocument,
      digitalProxy: digitalProxy ?? this.digitalProxy,
      selectedDigitalDocumentCategory: selectedDigitalDocumentCategory ?? this.selectedDigitalDocumentCategory,
      isActive: isActive ?? this.isActive,
      targetCandidateStockList: targetCandidateStockList ?? this.targetCandidateStockList,
      targetCandidateStockGroupList: targetCandidateStockGroupList ?? this.targetCandidateStockGroupList,
      title: title ?? this.title,
      campaignTitle: campaignTitle ?? this.campaignTitle,
      updatedPost: updatedPost ?? this.updatedPost,
      stockCode: stockCode ?? this.stockCode,
      stockGroup: stockGroup ?? this.stockGroup,
      content: content ?? this.content,
      searchTypeList: searchTypeList ?? this.searchTypeList,
      targetSearchType: targetSearchType ?? this.targetSearchType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      digitalDocumentCategoryList: digitalDocumentCategoryList ?? this.digitalDocumentCategoryList,
      isPreviewOn: isPreviewOn ?? this.isPreviewOn,
      pdf: pdf ?? this.pdf,
      stockReferenceDateList: stockReferenceDateList ?? this.stockReferenceDateList,
      selectedReferenceDay: selectedReferenceDay ?? this.selectedReferenceDay,
      completeMsg: completeMsg ?? this.completeMsg,
      isNotification: isNotification ?? this.isNotification,
      postType: postType ?? this.postType,
      selectReferenceTime: selectReferenceTime ?? this.selectReferenceTime,
      pollResults: pollResults ?? this.pollResults,
    );
  }

  @override
  List<Object?> get props => [
        actionDocumentTypeList,
        isLoading,
        errorToastMessage,
        boardGroupType,
        selectedActionDocumentType,
        polls,
        digitalDocument,
        digitalProxy,
        selectedDigitalDocumentCategory,
        isActive,
        targetCandidateStockList,
        targetCandidateStockGroupList,
        title,
        campaignTitle,
        updatedPost,
        stockCode,
        stockGroup,
        content,
        searchTypeList,
        targetSearchType,
        startDate,
        endDate,
        digitalDocumentCategoryList,
        isPreviewOn,
        pdf,
        user,
        stockReferenceDateList,
        selectedReferenceDay,
        completeMsg,
        isNotification,
        selectReferenceTime,
        postType,
        pollResults,
      ];
}

part of 'bloc.dart';

@immutable
class PopupState extends BaseState {
  final PopupStockTargetType targetStockType;
  final PopupLinkType targetLinkType;

  final PopupDisplayTargetType displayTargetType;
  final String targetSearchKeyword;
  final List<SimpleStock> targetCandidateStockList;
  final String? selectedStockCode;
  final int? selectedStockGroupId;
  final List<SimpleStockGroup> targetCandidateStockGroupList;

  final DateTime? targetStartDatetime;
  final DateTime? targetEndDatetime;

  final String? linkTitle;
  final int? linkPostId;
  final String title;
  final String content;

  final bool isComplete;

  const PopupState({
    this.targetStockType = PopupStockTargetType.stock,
    this.targetLinkType = PopupLinkType.link,
    this.displayTargetType = PopupDisplayTargetType.main_home,
    this.targetSearchKeyword = "",
    this.targetCandidateStockList = const [],
    this.targetCandidateStockGroupList = const [],
    this.targetStartDatetime,
    this.targetEndDatetime,
    this.linkPostId,
    this.linkTitle,
    this.selectedStockCode,
    this.selectedStockGroupId,
    this.title = "",
    this.content = "",
    bool isLoading = false,
    String? errorToastMessage,
    this.isComplete = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PopupState copyWith({
    PopupStockTargetType? targetStockType,
    PopupLinkType? targetLinkType,
    PopupDisplayTargetType? displayTargetType,
    String? targetSearchKeyword,
    List<SimpleStock>? targetCandidateStockList,
    List<SimpleStockGroup>? targetCandidateStockGroupList,
    String? selectedStockCode,
    bool clearSelectedSimpleStock = false, // 추가된 플래그
    int? selectedStockGroupId,
    bool clearSelectedSimpleStockGroup = false, // 추가된 플래그
    DateTime? targetStartDatetime,
    DateTime? targetEndDatetime,
    String? content,
    String? title,
    int? linkPostId,
    String? linkTitle,
    bool? isLoading,
    String? errorToastMessage,
    bool? isComplete,
  }) {
    return PopupState(
      targetStockType: targetStockType ?? this.targetStockType,
      targetLinkType: targetLinkType ?? this.targetLinkType,
      displayTargetType: displayTargetType ?? this.displayTargetType,
      targetSearchKeyword: targetSearchKeyword ?? this.targetSearchKeyword,
      targetCandidateStockList: targetCandidateStockList ?? this.targetCandidateStockList,
      targetCandidateStockGroupList: targetCandidateStockGroupList ?? this.targetCandidateStockGroupList,
      targetStartDatetime: targetStartDatetime ?? this.targetStartDatetime,
      targetEndDatetime: targetEndDatetime ?? this.targetEndDatetime,
      content: content ?? this.content,
      title: title ?? this.title,
      linkPostId: linkPostId ?? this.linkPostId,
      linkTitle: linkTitle ?? this.linkTitle,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      isComplete: isComplete ?? this.isComplete,
      selectedStockCode: selectedStockCode ?? this.selectedStockCode,
      selectedStockGroupId: selectedStockGroupId ?? this.selectedStockGroupId,
    );
  }

  List<Popup> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Popup>((json) => Popup.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        targetStockType,
        targetLinkType,
        targetSearchKeyword,
        targetCandidateStockList,
        displayTargetType,
        targetCandidateStockGroupList,
        targetStartDatetime,
        targetEndDatetime,
        selectedStockCode,
        selectedStockGroupId,
        content,
        title,
        isLoading,
        errorToastMessage,
        isComplete,
        linkTitle,
        linkPostId,
      ];

  bool get isReadyToSend {
    return true;
  }
}

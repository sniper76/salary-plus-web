part of 'bloc.dart';

@immutable
class PushState extends BaseState {
  final PushTargetType targetSearchType;
  final String targetSearchKeyword;
  final List<SimpleStock> targetCandidateStockList;
  final List<SimpleStockGroup> targetCandidateStockGroupList;
  final SimpleStock? selectedSimpleStock;
  final SimpleStockGroup? selectedSimpleStockGroup;
  final PushLinkType targetLinkType;

  final PushSendType sendType;
  final DateTime? targetDatetime;

  final String content;
  final String title;
  final String? postId;

  final bool isComplete;

  const PushState({
    this.targetSearchType = PushTargetType.stock,
    this.targetSearchKeyword = "",
    this.targetCandidateStockList = const [],
    this.targetLinkType = PushLinkType.link,
    this.targetCandidateStockGroupList = const [],
    this.selectedSimpleStock,
    this.selectedSimpleStockGroup,
    this.sendType = PushSendType.immediately,
    this.targetDatetime,
    this.postId = '',
    this.content = "",
    this.title = "",
    bool isLoading = false,
    String? errorToastMessage,
    this.isComplete = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PushState copyWith({
    PushTargetType? targetSearchType,
    String? targetSearchKeyword,
    List<SimpleStock>? targetCandidateStockList,
    PushLinkType? targetLinkType,
    List<SimpleStockGroup>? targetCandidateStockGroupList,
    SimpleStock? selectedSimpleStock,
    bool clearSelectedSimpleStock = false, // 추가된 플래그
    SimpleStockGroup? selectedSimpleStockGroup,
    bool clearSelectedSimpleStockGroup = false, // 추가된 플래그
    PushSendType? sendType,
    DateTime? targetDatetime,
    String? content,
    String? title,
    bool? isLoading,
    String? errorToastMessage,
    bool? isComplete,
    String? postId,
  }) {
    return PushState(
      targetSearchType: targetSearchType ?? this.targetSearchType,
      targetSearchKeyword: targetSearchKeyword ?? this.targetSearchKeyword,
      targetCandidateStockList: targetCandidateStockList ?? this.targetCandidateStockList,
      targetCandidateStockGroupList: targetCandidateStockGroupList ?? this.targetCandidateStockGroupList,
      selectedSimpleStock: clearSelectedSimpleStock ? null : selectedSimpleStock ?? this.selectedSimpleStock,
      selectedSimpleStockGroup:
          clearSelectedSimpleStockGroup ? null : selectedSimpleStockGroup ?? this.selectedSimpleStockGroup,
      sendType: sendType ?? this.sendType,
      targetDatetime: targetDatetime ?? this.targetDatetime,
      content: content ?? this.content,
      title: title ?? this.title,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      isComplete: isComplete ?? this.isComplete,
      targetLinkType: targetLinkType ?? this.targetLinkType,
      postId: postId ?? this.postId,
    );
  }

  @override
  List<Object?> get props => [
        targetSearchType,
        targetSearchKeyword,
        targetCandidateStockList,
        targetCandidateStockGroupList,
        selectedSimpleStock,
        selectedSimpleStockGroup,
        sendType,
        targetDatetime,
        content,
        isLoading,
        errorToastMessage,
        isComplete,
        targetLinkType,
        postId,
        title,
      ];

  bool get isReadyToSend {
    if (content.isEmpty || title.isEmpty) {
      return false;
    }

    if (targetLinkType == PushLinkType.link && postId!.isEmpty) {
      return false;
    }

    switch (targetSearchType) {
      case PushTargetType.stock:
        return selectedSimpleStock != null && selectedSimpleStockGroup == null;
      case PushTargetType.stock_group:
        return selectedSimpleStock == null && selectedSimpleStockGroup != null;
      case PushTargetType.all:
        return selectedSimpleStock == null && selectedSimpleStockGroup == null;
      default:
        return false;
    }
  }
}

part of 'cms_group_bloc.dart';

@immutable
class CmsStockGroupState extends BaseState {
  final List<SimpleStockGroup> matchedStockGroupList;
  final List<SimpleStock> matchedStockList;
  final List<SimpleStock> matchedBatchStockList;
  final List<String> nonMatchedBatchStockList;
  final Set<SimpleStock> candidateStockList;
  final String? groupName;
  final StockGroup? newStockGroup;
  final String? groupDescription;
  final bool isCreateMode;
  final bool isEditable;
  final int totalCount;

  const CmsStockGroupState({
    this.newStockGroup,
    bool isLoading = false,
    String? errorToastMessage,
    this.matchedStockList = const [],
    this.matchedStockGroupList = const [],
    this.matchedBatchStockList = const [],
    this.nonMatchedBatchStockList = const [],
    this.candidateStockList = const {},
    this.groupName,
    this.groupDescription,
    this.isCreateMode = true,
    this.isEditable = true,
    this.totalCount = 0,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CmsStockGroupState copyWith({
    StockGroup? newStockGroup,
    bool? isLoading,
    String? errorToastMessage,
    List<SimpleStockGroup>? matchedStockGroupList,
    List<SimpleStock>? matchedStockList,
    List<SimpleStock>? matchedBatchStockList,
    List<String>? nonMatchedBatchStockList,
    Set<SimpleStock>? candidateStockList,
    String? groupName,
    String? groupDescription,
    bool? isCreateMode,
    bool? isEditable,
    int? totalCount,
  }) {
    return CmsStockGroupState(
      newStockGroup: newStockGroup ?? this.newStockGroup,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      matchedStockGroupList: matchedStockGroupList ?? this.matchedStockGroupList,
      matchedStockList: matchedStockList ?? this.matchedStockList,
      matchedBatchStockList: matchedBatchStockList ?? this.matchedBatchStockList,
      nonMatchedBatchStockList: nonMatchedBatchStockList ?? this.nonMatchedBatchStockList,
      candidateStockList: candidateStockList ?? this.candidateStockList,
      groupName: groupName ?? this.groupName,
      groupDescription: groupDescription ?? this.groupDescription,
      isCreateMode: isCreateMode ?? this.isCreateMode,
      isEditable: isEditable ?? this.isEditable,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  List<User> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        newStockGroup,
        isLoading,
        errorToastMessage,
        matchedStockGroupList,
        matchedStockList,
        matchedBatchStockList,
        nonMatchedBatchStockList,
        candidateStockList,
        groupName,
        groupDescription,
        isCreateMode,
        isEditable,
        totalCount,
      ];
}

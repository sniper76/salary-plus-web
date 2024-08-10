part of 'bloc.dart';

@immutable
class StopWordsState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final int paginatorIndex;
  final List<StopWord> stopWordList;
  final String curSearchKeyWord;
  final int totalCount;
  final String errorDialogMessage;
  final List<StopWordSortType> stopWordSortTypeList;
  final List<StopWordSortTypeWrapper> stopWordSortTypeWrapperList;
  final StopWordSortType selectedSortType;
  final List<StopWordFilterType> stopWordFilterTypeList;
  final List<StopWordFilterTypeWrapper> stopWordFilterTypeWrapperList;
  final StopWordFilterType selectedFilterType;
  final int? reActivateTargetPopupId;

  StopWordsState({
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.paginatorIndex = 0,
    this.stopWordList = const [],
    this.curSearchKeyWord = '',
    this.totalCount = 0,
    String? errorDialogMessage,
    this.stopWordSortTypeList = StopWordSortType.values,
    this.stopWordFilterTypeList = StopWordFilterType.values,
    this.selectedSortType = StopWordSortType.createdAtDesc,
    this.selectedFilterType = StopWordFilterType.all,
    this.reActivateTargetPopupId,
  })  : errorDialogMessage = errorDialogMessage ?? '',
        stopWordSortTypeWrapperList = stopWordSortTypeList
            .map((StopWordSortType stopWordSortType) => StopWordSortTypeWrapper(stopWordSortType: stopWordSortType))
            .toList(),
        stopWordFilterTypeWrapperList = stopWordFilterTypeList
            .map((StopWordFilterType stopWordFilterType) =>
                StopWordFilterTypeWrapper(stopWordFilterType: stopWordFilterType))
            .toList(),
        super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  StopWordsState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<StopWord>? stopWordList,
    String? curSearchKeyWord,
    Paging? paging,
    int? paginatorIndex,
    String? errorDialogMessage,
    int? totalCount,
    StopWordSortType? selectedSortType,
    StopWordFilterType? selectedFilterType,
    int? reActivateTargetPopupId,
  }) {
    return StopWordsState(
      stopWordList: stopWordList ?? this.stopWordList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      errorDialogMessage: errorDialogMessage ?? this.errorDialogMessage,
      paging: paging ?? this.paging,
      curSearchKeyWord: curSearchKeyWord ?? this.curSearchKeyWord,
      paginatorIndex: paginatorIndex ?? this.paginatorIndex,
      totalCount: totalCount ?? this.totalCount,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      selectedFilterType: selectedFilterType ?? this.selectedFilterType,
      reActivateTargetPopupId: reActivateTargetPopupId,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        stopWordList,
        curSearchKeyWord,
        errorToastMessage,
        errorDialogMessage,
        paginatorIndex,
        totalCount,
        selectedSortType,
        selectedFilterType,
        reActivateTargetPopupId,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}

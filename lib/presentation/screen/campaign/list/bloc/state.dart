part of 'bloc.dart';

@immutable
class CampaignListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final CampaignSearchType searchType;
  final String searchKeyword;
  final BoardGroupCategory? boardCategory;
  final List<Campaign> campaigns;
  final List<UploadImageFile> uploadImageFiles;
  final Campaign? selectedCampaignDetail;

  const CampaignListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.searchType = CampaignSearchType.title,
    this.campaigns = const [],
    this.uploadImageFiles = const [],
    this.boardCategory = const BoardGroupCategory(name: 'ALL', displayName: '전체'),
    this.searchKeyword = '',
    this.selectedCampaignDetail,
    this.paging = const Paging(page: 1, size: apiLoadSize),
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CampaignListState copyWith(
      {bool? isLoading,
      String? errorToastMessage,
      CampaignSearchType? searchType,
      BoardGroupCategory? boardCategory,
      List<UploadImageFile>? uploadImageFiles,
      Paging? paging,
      String? searchKeyword,
      Campaign? selectedCampaignDetail,
      List<Campaign>? campaigns}) {
    return CampaignListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      searchType: searchType ?? this.searchType,
      boardCategory: boardCategory ?? this.boardCategory,
      uploadImageFiles: uploadImageFiles ?? this.uploadImageFiles,
      paging: paging ?? this.paging,
      campaigns: campaigns ?? this.campaigns,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      selectedCampaignDetail: selectedCampaignDetail ?? this.selectedCampaignDetail,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, errorToastMessage, searchType, boardCategory, campaigns, paging, uploadImageFiles, searchKeyword];
}

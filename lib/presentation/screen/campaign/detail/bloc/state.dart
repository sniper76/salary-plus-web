part of 'bloc.dart';

@immutable
class CampaignDetailState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final Campaign? detailCampaign;
  final Post? detailPost;
  final CampaignPost? selectedStock;
  final List<CampaignPost> simpleStockList;
  final BoardSortType sortType;
  final User? userMe;

  const CampaignDetailState(
      {bool isLoading = false,
      String? errorToastMessage,
      this.detailCampaign,
      this.detailPost,
      this.paging = const Paging(page: 1, size: apiLoadSize),
      this.selectedStock,
      this.sortType = BoardSortType.createdAtAsc,
      this.simpleStockList = const [],
      this.userMe})
      : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CampaignDetailState copyWith({
    bool? isLoading,
    Paging? paging,
    Campaign? detailCampaign,
    Post? detailPost,
    List<Comment>? comments,
    CampaignPost? selectedStock,
    String? errorToastMessage,
    BoardSortType? sortType,
    bool? isCommentMoreLoading,
    User? userMe,
    List<CampaignPost>? simpleStockList,
  }) {
    return CampaignDetailState(
        paging: paging ?? this.paging,
        detailCampaign: detailCampaign ?? this.detailCampaign,
        detailPost: detailPost ?? this.detailPost,
        selectedStock: selectedStock ?? this.selectedStock,
        userMe: userMe ?? this.userMe,
        sortType: sortType ?? this.sortType,
        isLoading: isLoading ?? this.isLoading,
        errorToastMessage: errorToastMessage ?? this.errorToastMessage,
        simpleStockList: simpleStockList ?? this.simpleStockList);
  }

  @override
  List<Object?> get props =>
      [isLoading, errorToastMessage, paging, detailCampaign, selectedStock, simpleStockList, detailPost];
}

part of 'bloc.dart';

@immutable
class CorporationListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final CorporationSearchType searchType;
  final List<CorporationUser> corporations;

  const CorporationListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.searchType = CorporationSearchType.corporationName,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.corporations = const [],
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CorporationListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    CorporationSearchType? searchType,
    List<CorporationUser>? corporations,
    Paging? paging,
  }) {
    return CorporationListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      searchType: searchType ?? this.searchType,
      corporations: corporations ?? this.corporations,
      paging: paging ?? this.paging,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorToastMessage, searchType, paging, corporations];
}

part of 'bloc.dart';

@immutable
class AcceptanceListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final BoardSearchType searchType;
  final String searchKeyword;
  final List<Post> documentList;

  const AcceptanceListState({
    this.searchType = BoardSearchType.title,
    this.searchKeyword = "",
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.documentList = const [],
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(
          isLoading: isLoading,
          errorToastMessage: errorToastMessage ?? '',
        );

  AcceptanceListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    Paging? paging,
    BoardSearchType? searchType,
    String? searchKeyword,
    List<Post>? documentList,
  }) =>
      AcceptanceListState(
        documentList: documentList ?? this.documentList,
        paging: paging ?? this.paging,
        searchType: searchType ?? this.searchType,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        errorToastMessage: errorToastMessage ?? '',
      );

  @override
  List<Object> get props => [isLoading, errorToastMessage, paging, documentList, searchKeyword];
}

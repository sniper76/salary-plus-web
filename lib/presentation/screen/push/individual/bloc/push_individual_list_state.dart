part of 'push_individual_list_bloc.dart';

@immutable
class PushIndividualListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final PushSearchType searchType;
  final List<IndividualPush> pushes;

  const PushIndividualListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.searchType = PushSearchType.pushContent,
    this.pushes = const [],
    this.paging = const Paging(),
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PushIndividualListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    PushSearchType? searchType,
    List<IndividualPush>? pushes,
    Paging? paging,
  }) {
    return PushIndividualListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      searchType: searchType ?? this.searchType,
      pushes: pushes ?? this.pushes,
      paging: paging ?? this.paging,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        searchType,
        pushes,
        paging,
      ];
}

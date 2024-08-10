part of 'bloc.dart';

@immutable
class CorporationDetailState extends BaseState {
  final CorporationUser corporationUser;

  @override
  const CorporationDetailState({
    required this.corporationUser,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CorporationDetailState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    CorporationSearchType? searchType,
    CorporationUser? corporationUser,
  }) {
    return CorporationDetailState(
      corporationUser: corporationUser ?? this.corporationUser,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [isLoading, errorToastMessage, corporationUser];
}

part of 'bloc.dart';

@immutable
class CorporationRegisterState extends BaseState {
  final bool isComplete;

  const CorporationRegisterState({
    this.isComplete = false,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(
          isLoading: isLoading,
          errorToastMessage: errorToastMessage ?? '',
        );

  CorporationRegisterState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    bool? isComplete,
  }) {
    return CorporationRegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
      ];
}

part of 'bloc.dart';

@immutable
class PopupDetailState extends BaseState {
  final Popup? updatePopup;

  const PopupDetailState({
    this.updatePopup,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PopupDetailState copyWith({
    Popup? updatePopup,
    bool? isLoading,
    String? errorToastMessage,
    bool? isComplete,
  }) {
    return PopupDetailState(
      updatePopup: updatePopup ?? this.updatePopup,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [
        updatePopup,
        isLoading,
        errorToastMessage,
      ];
}

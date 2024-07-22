part of 'bloc.dart';

@freezed
class ActSearchWidgetState with _$ActSearchWidgetState, BaseStateMixin {
  const ActSearchWidgetState._();

  const factory ActSearchWidgetState({
    required bool isLoading,
    required List<BaseStock> stocks,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
  }) = _ActPostListWidgetState;

  factory ActSearchWidgetState.initial() {
    return const ActSearchWidgetState(
      isLoading: true,
      stocks: [],
      errorToastMessage: null,
      notiToastMessage: null,
    );
  }
}

extension ActSearchWidgetStateExtension on ActSearchWidgetState {
  ActSearchWidgetState copyWithNull({
    bool? isLoading,
    List<BaseStock>? stocks,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return ActSearchWidgetState(
      isLoading: isLoading ?? this.isLoading,
      stocks: stocks ?? this.stocks,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}

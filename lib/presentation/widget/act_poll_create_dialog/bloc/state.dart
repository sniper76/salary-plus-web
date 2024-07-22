part of 'bloc.dart';

@freezed
class ActPollCreateState with _$ActPollCreateState, BaseStateMixin {
  factory ActPollCreateState({
    required bool isLoading,
    @Default(false) bool isEdit,
    @Default(PollVoteType.shareholder) PollVoteType selectedVoteType,
    @Default(false) bool isMultipleChoiceAllowd,
    DateTime? pollStartDateTime,
    DateTime? pollEndDateTime,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
    @Default([]) List<String> pollItemList,
  }) = _ActPollCreateDialogState;

  factory ActPollCreateState.initial() {
    return ActPollCreateState(
      isLoading: true,
    );
  }
}

extension ActPollCreateStateExtension on ActPollCreateState {
  ActPollCreateState copyWithNull({
    bool? isLoading,
    bool? isEdit,
    PollVoteType? selectedVoteType,
    bool? isMultipleChoiceAllowd,
    DateTime? pollStartDateTime,
    DateTime? pollEndDateTime,
    String? errorToastMessage,
    String? notiToastMessage,
    List<String>? pollItemList,
  }) {
    return ActPollCreateState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      selectedVoteType: selectedVoteType ?? this.selectedVoteType,
      isMultipleChoiceAllowd: isMultipleChoiceAllowd ?? this.isMultipleChoiceAllowd,
      pollStartDateTime: pollStartDateTime ?? this.pollStartDateTime,
      pollEndDateTime: pollEndDateTime ?? this.pollEndDateTime,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
      pollItemList: pollItemList ?? this.pollItemList,
    );
  }
}

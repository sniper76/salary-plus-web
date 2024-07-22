part of 'bloc.dart';

@freezed
class ActPollCreateEvent with _$ActPollCreateEvent {
  const factory ActPollCreateEvent.init() = _OnInit;

  const factory ActPollCreateEvent.addPollItem() = _OnAddPollItem;

  const factory ActPollCreateEvent.changePollItem(int index, String pollItemString) = _OnChangePollItem;

  const factory ActPollCreateEvent.deletePollItem(int index) = _OnDeletePollItem;

  const factory ActPollCreateEvent.toggleMultipleChoice() = _OnToggleMultipleChoice;

  const factory ActPollCreateEvent.changePollStartDateTime(DateTime startedAtDateTime) = _OnChangePollStartDateTime;

  const factory ActPollCreateEvent.changePollEndDateTime(DateTime endedAtDateTime) = _OnChangePollEndDateTime;

  const factory ActPollCreateEvent.changeVoteType(PollVoteType pollVoteType) = _OnChangeVoteType;
}

import 'package:act_web/domain/enum/poll_selection_type.dart';
import 'package:act_web/domain/enum/poll_vote_type.dart';
import 'package:act_web/domain/model/post/poll_register_result.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class ActPollCreateBloc extends Bloc<ActPollCreateEvent, ActPollCreateState> {
  PollRegisterResult? receivedResult;

  ActPollCreateBloc(this.receivedResult) : super(ActPollCreateState.initial()) {
    on<_OnInit>((event, emit) async {
      if (receivedResult != null) {
        emit(state.copyWithNull(
          isEdit: true,
          selectedVoteType: receivedResult!.voteType,
          isMultipleChoiceAllowd: receivedResult!.selectionType == PollSelectionType.multiple,
          pollItemList: receivedResult!.items,
          pollStartDateTime: receivedResult!.startedAt,
          pollEndDateTime: receivedResult!.endedAt,
        ));
      } else {
        emit(state.copyWithNull(
          isEdit: false,
          pollItemList: ['', ''],
        ));
      }
    });

    on<_OnAddPollItem>((event, emit) {
      final List<String> newPollItemList = [...state.pollItemList];
      newPollItemList.add('');

      emit(state.copyWithNull(
        pollItemList: newPollItemList,
      ));
    });

    on<_OnChangePollItem>((event, emit) {
      final List<String> newPollItemList = [...state.pollItemList];
      newPollItemList[event.index] = event.pollItemString;

      emit(state.copyWithNull(
        pollItemList: newPollItemList,
      ));
    });

    on<_OnDeletePollItem>((event, emit) {
      final List<String> newPollItemList = [...state.pollItemList];
      newPollItemList.removeAt(event.index);

      emit(state.copyWithNull(
        pollItemList: newPollItemList,
      ));
    });

    on<_OnToggleMultipleChoice>((event, emit) {
      emit(state.copyWithNull(
        isMultipleChoiceAllowd: !state.isMultipleChoiceAllowd,
      ));
    });

    on<_OnChangePollStartDateTime>((event, emit) {
      emit(state.copyWithNull(
        pollStartDateTime: event.startedAtDateTime,
      ));
    });

    on<_OnChangePollEndDateTime>((event, emit) {
      emit(state.copyWithNull(
        pollEndDateTime: event.endedAtDateTime,
      ));
    });

    on<_OnChangeVoteType>((event, emit) {
      emit(state.copyWithNull(
        selectedVoteType: event.pollVoteType,
      ));
    });
  }
}

part of 'widget.dart';

void _onPollItemAddPressed(BuildContext context, int maxItemCount) {
  final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

  if (bloc.state.pollItemList.length >= maxItemCount) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('설문항목은 최대 $maxItemCount개까지 입니다'),
    ));
    return;
  }

  bloc.add(const ActPollCreateEvent.addPollItem());
}

void _onMultipleChoiceCheckedChanged() {
  final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

  bloc.add(const ActPollCreateEvent.toggleMultipleChoice());
}

void _onPickerStartedDateTime(BuildContext context, TextEditingController startedAtTextController) async {
  final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

  showDatePicker(
    context: context,
    initialDate: bloc.state.pollStartDateTime ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 60)),
  ).then((dateRet) async {
    if (dateRet != null) {
      final timeRet = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
        initialEntryMode: TimePickerEntryMode.dialOnly,
      );

      if (timeRet != null) {
        final DateTime newPollStartDateTime = dateRet.copyWith(hour: timeRet.hour, minute: timeRet.minute, second: 00);
        startedAtTextController.text = newPollStartDateTime.toFormatString(pattern: 'yyyy-MM-dd HH:mm:ss');
        bloc.add(ActPollCreateEvent.changePollStartDateTime(newPollStartDateTime));
      }
    }
  });
}

void _onPickerEndedDate(BuildContext context, TextEditingController endedAtTextController) async {
  final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

  showDatePicker(
    context: context,
    initialDate: bloc.state.pollEndDateTime ?? DateTime.now().add(const Duration(days: 7)),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 60)),
  ).then((dateRet) async {
    if (dateRet != null) {
      final timeRet = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
        initialEntryMode: TimePickerEntryMode.dialOnly,
      );

      if (timeRet != null) {
        final DateTime newPollEndDateTime = dateRet.copyWith(hour: timeRet.hour, minute: timeRet.minute, second: 00);
        endedAtTextController.text = newPollEndDateTime.toFormatString(pattern: 'yyyy-MM-dd HH:mm:ss');
        bloc.add(ActPollCreateEvent.changePollEndDateTime(newPollEndDateTime));
      }
    }
  });
}

void _onPollItemClearPressed(BuildContext context, int index, int minItemCount) {
  final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

  if (bloc.state.pollItemList.length == minItemCount) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('설문항목은 최소 $minItemCount 입니다'),
    ));
    return;
  }

  bloc.add(ActPollCreateEvent.deletePollItem(index));
}

extension ActPollCreateDialogStateExtension on ActPollCreateDialogState {
  bool _validChoices() {
    final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

    final int validPollItemList =
        bloc.state.pollItemList.where((String pollItemString) => pollItemString.isNotEmpty).length;
    return validPollItemList > 1;
  }

  bool _checkSameText() {
    final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

    final List<String> validPollItemList =
        bloc.state.pollItemList.where((String pollItemString) => pollItemString.isNotEmpty).toList();
    return validPollItemList.length != validPollItemList.toSet().length;
  }

  void _onPollSave() {
    final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();

    if (_titleTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('제목을 입력해주세요'),
      ));
      return;
    }

    if (!_validChoices()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('설문항목은 2개 이상 입력하셔야 합니다'),
      ));
      return;
    }

    if (_checkSameText()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('동일한 설문항목이 있습니다'),
      ));
      return;
    }

    if (bloc.state.pollStartDateTime == null || bloc.state.pollEndDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('시작일과 종료일을 설정해주세요'),
      ));

      return;
    }

    final List<String> validPollItemList =
        bloc.state.pollItemList.where((String pollItemString) => pollItemString.isNotEmpty).toList();

    final result = PollRegisterResult(
      title: _titleTextController.text,
      content: _contentTextController.text,
      items: validPollItemList,
      startedAt: bloc.state.pollStartDateTime!,
      endedAt: bloc.state.pollEndDateTime!,
      voteType: bloc.state.selectedVoteType,
      selectionType: bloc.state.isMultipleChoiceAllowd ? PollSelectionType.multiple : PollSelectionType.single,
    );
    context.router.maybePop(result);
  }
}

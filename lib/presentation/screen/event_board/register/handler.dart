part of 'screen.dart';

extension _EventBoardRegisterScreenStateExtension on _EventBoardRegisterScreenState {
  void _onComplete(BuildContext context, String commandTitle) async {
    final result = await context.showAlertDialog(title: "게시글 $commandTitle", message: "게시글이 $commandTitle 되었습니다.");
    if (result) {
      if (!context.mounted) return;
      context.router.pop(true);
    }
  }

  Future<void> _saveEventBoardPost({
    required EventBoardRegisterBloc bloc,
    required EventBoardRegisterState state,
    required TextEditingController titleController,
    required HtmlEditorController contentController,
    required TextEditingController pushTitleTextController,
    required TextEditingController pushContentTextController,
  }) async {
    bool confirmResult = true;

    if (state.updatePost == null && state.selectedNoticePushSendStatus == NoticePushSendStatus.send) {
      confirmResult = await PushCheckDialog.show(context, state) ?? false;
    }

    if (confirmResult == true) {
      bloc.add(EventBoardRegisterEvent.save(
        title: titleController.text,
        content: await contentController.getText(),
        isActive: state.isActive,
        isNotification: state.isNotification,
        activeStartDate: state.activeStartDate,
        activeEndDate: state.activeEndDate,
        pushRequest: state.selectedNoticePushSendStatus == NoticePushSendStatus.send
            ? PushRequest(
                title: pushTitleTextController.text,
                content: pushContentTextController.text,
              )
            : null,
      ));
    }
  }

  void _onTitleTextChanged(EventBoardRegisterBloc bloc, String? titleString) {
    bloc.add(EventBoardRegisterEvent.setData(title: titleString));
  }

  void _onContentTextChanged(EventBoardRegisterBloc bloc, String? contentString) {
    bloc.add(EventBoardRegisterEvent.setData(content: contentString));
  }

  void _onPushTitleTextChanged(EventBoardRegisterBloc bloc, String? pushTitleString) {
    bloc.add(
      EventBoardRegisterEvent.setData(
        push: PushRequest(
          title: pushTitleString ?? '',
          content: bloc.state.pushRequest?.content,
        ),
      ),
    );
  }

  void _onPushContentTextChanged(EventBoardRegisterBloc bloc, String? pushContentString) {
    bloc.add(
      EventBoardRegisterEvent.setData(
        push: PushRequest(
          title: bloc.state.pushRequest?.title ?? '',
          content: pushContentString,
        ),
      ),
    );
  }

  void _onTapCancelButton() {
    context.router.pop();
  }
}

void _onTapStartDatePicker(BuildContext context, EventBoardRegisterBloc bloc) {
  Future<DateTime?> selectedDate = showDatePicker(
    context: context,
    initialDate: bloc.state.activeStartDate,
    firstDate: DateTime(2021),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(),
        child: child!,
      );
    },
  );
  selectedDate.then((DateTime? selectedDateTime) async {
    if (selectedDateTime == null) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
    );

    if (selectedTime == null) return null;

    final DateTime newActiveStartDate =
        selectedDateTime.copyWith(hour: selectedTime.hour, minute: selectedTime.minute, second: 00);

    if (bloc.state.updatePost == null && newActiveStartDate.isBefore(DateTime.now())) {
      EasyLoading.showToast('현재보다 과거인 시점으로는 등록할 수 없습니다.');
      return;
    }

    bloc.add(EventBoardRegisterEvent.setData(activeStartDate: newActiveStartDate));
  });
}

void _onTapEndDatePicker(BuildContext context, EventBoardRegisterBloc bloc) {
  Future<DateTime?> selectedDate = showDatePicker(
    context: context,
    initialDate: bloc.state.activeEndDate,
    firstDate: DateTime(2021),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(),
        child: child!,
      );
    },
  );
  selectedDate.then((DateTime? selectedDateTime) async {
    if (selectedDateTime == null) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
    );
    if (selectedTime == null) return null;

    bloc.add(EventBoardRegisterEvent.setData(
        activeEndDate: selectedDateTime.copyWith(hour: selectedTime.hour, minute: selectedTime.minute, second: 00)));
  });
}

void onTapActivateButton(EventBoardRegisterBloc bloc) {
  bloc.add(EventBoardRegisterEvent.setActiveStatus(true));
}

Future<void> onTapDeActivateButton(BuildContext context, EventBoardRegisterBloc bloc) async {
  bool confirmResult = true;
  if (bloc.state.updatePost != null) {
    confirmResult = await context.showConfirmDialog(
      title: '정보',
      message: '미노출로 변경후 수정하면 예약된 팝업이 자동 취소됩니다. 미노출로 변경하시겠습니까?',
      positiveButtonText: '변경',
    );
  }
  if (confirmResult) bloc.add(EventBoardRegisterEvent.setActiveStatus(false));
}

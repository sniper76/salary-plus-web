part of 'screen.dart';

_onCreateStopWord(BuildContext context, TextEditingController dialogController) async {
  final bloc = context.read<StopWordsBloc>();
  dialogController.clear();

  final String enteredString = await showDialog<String?>(
        context: context,
        builder: (context) {
          return PointerInterceptor(
            child: AlertDialog(
              title: Text(
                '${AppConfig.stopWordText} 등록',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 22),
              content: TextField(
                controller: dialogController,
                decoration: const InputDecoration(hintText: '등록할 ${AppConfig.stopWordText}를 입력해 주세요.'),
              ),
              contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 22),
              actions: [
                TextButton(
                  onPressed: () => context.router.pop(),
                  child: Text(
                    '취소',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () => context.router.pop(dialogController.text),
                  child: Text(
                    '등록',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
      ) ??
      '';

  if (enteredString.isNotEmpty) {
    bloc.add(StopWordsEvent.createStopWord(enteredString));
  }
}

_onChangeStopWordStatus(BuildContext context, StopWord stopWord) async {
  final bloc = context.read<StopWordsBloc>();

  final bool showInActiveButton = stopWord.status == StopWordStatus.active;
  final StopWordStatus targetStatus = showInActiveButton ? StopWordStatus.inactiveByAdmin : StopWordStatus.active;
  final String actionString = targetStatus.label;

  final bool isConfirmed = await context.showConfirmDialog(
    title: '${AppConfig.stopWordText} $actionString',
    message: '해당 ${AppConfig.stopWordText}를 $actionString하시겠습니까?',
    positiveButtonText: actionString,
  );

  if (isConfirmed) {
    bloc.add(StopWordsEvent.changeStopWordStatus(
      stopWordId: stopWord.id,
      beforeStatus: stopWord.status,
      afterStatus: targetStatus,
    ));
  }
}

_onDeleteStopWord(BuildContext context, StopWord stopWord) async {
  final bloc = context.read<StopWordsBloc>();

  final bool isConfirmed = await context.showConfirmDialog(
    title: '${AppConfig.stopWordText} 삭제',
    message: '해당 ${AppConfig.stopWordText}를 삭제하시겠습니까?',
    positiveButtonText: '삭제',
  );

  if (isConfirmed) bloc.add(StopWordsEvent.deleteStopWord(stopWord.id));
}

_listenStateChange(BuildContext context, TextEditingController dialogController) async {
  final bloc = context.read<StopWordsBloc>();

  if (bloc.state.reActivateTargetPopupId != null) {
    final bool isConfirmed = await context.showConfirmDialog(
      title: '이미 등록된 ${AppConfig.stopWordText} 입니다.',
      message: '이미 등록되어 비활성화 되어있습니다. 활성화하시겠습니까?',
      positiveButtonText: '활성화',
    );

    if (isConfirmed) {
      bloc.add(StopWordsEvent.changeStopWordStatus(
        stopWordId: bloc.state.reActivateTargetPopupId!,
        beforeStatus: StopWordStatus.inactiveByAdmin,
        afterStatus: StopWordStatus.active,
      ));
    }
  }
}

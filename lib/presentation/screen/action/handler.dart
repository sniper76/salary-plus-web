part of 'screen.dart';

extension _ActionStateExtension on _ActionState {
  onSuccessChangeReferenceDay(BuildContext context) {
    final bloc = _scaffoldKey.currentContext?.read<ActionBloc>();
    if (bloc == null) return;
    context.showAlertDialog(title: "기준일이 변경되었습니다. ").then((value) => bloc.add(const ActionEvent.pageRefresh()));
  }

  void _createFile(Post post, isLock) {
    final bloc = _scaffoldKey.currentContext?.read<ActionBloc>();
    if (bloc == null) return;
    bloc.add(ActionEvent.requestZipFile(post, isLock));
  }

  void _onHandleReferenceDate(BuildContext context, ActionBloc bloc, Post post) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ActionBloc, ActionState>(
            bloc: bloc,
            builder: (context, state) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(40),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              '기준일 변경',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text('-'),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text('기존 기준일'),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(((post.digitalDocument?.stock?.referenceDate) == null)
                                ? '기준일이 설정되어 있지 않습니다. '
                                : post.digitalDocument!.stock!.referenceDate!.toFormatString()),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => context.router.pop(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 400,
                      height: 300,
                      child: SfDateRangePicker(
                        minDate: DateTime(DateTime.now().year, DateTime.now().month - 2, 1),
                        maxDate: DateTime(DateTime.now().year + 1, 12, 31),
                        initialSelectedDate: post.digitalDocument?.stock?.referenceDate ?? DateTime.now(),
                        initialDisplayDate: post.digitalDocument?.stock?.referenceDate ?? DateTime.now(),
                        showActionButtons: true,
                        showNavigationArrow: true,
                        showTodayButton: true,
                        confirmText: "변경",
                        cancelText: "취소",
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                          dayFormat: 'EEE',
                        ),
                        monthFormat: 'MMM',
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(fontSize: 16, color: AppTheme.primaryColor),
                        ),
                        onSubmit: (p0) {
                          if (post.digitalDocument?.stock != null) {
                            bloc.add(ActionEvent.updateReferenceDay(
                              post.digitalDocument!.stock!.referenceDateId!,
                              post.digitalDocument!.stock!.code,
                              p0 as DateTime,
                              post.digitalDocument!.id,
                            ));
                          }
                          context.router.pop('success');
                        },
                        selectionMode: DateRangePickerSelectionMode.single,
                        onCancel: () {
                          context.router.pop('cancel');
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    ).then((value) {
      return null;
    });
  }

  void _onHandleDownload(BuildContext context, ActionBloc postBloc, Post post) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<DialogBloc>(
                create: (context) => DialogBloc(ActionPostType.campaign),
              ),
              BlocProvider<ActionBloc>(
                create: (context) => ActionBloc(),
              ),
            ],
            child: BlocBuilder<ActionBloc, ActionState>(
              builder: (context, state) {
                return ZipFileDownloadDialog(
                  id: post.id,
                  type: ActionPostType.action,
                  stockCode: post.stock?.code,
                  boardGroupType: post.boardGroupType,
                  digitalDocumentDownload: state.selectedPostDetail?.digitalDocument?.digitalDocumentDownload,
                  onRequestFile: (bool isLock) {
                    _createFile(post, isLock);
                  },
                );
              },
            ));
      },
    );
    postBloc.add(const ActionEvent.removeZipFileStatus());
  }

  void _onRefresh() {
    final bloc = _scaffoldKey.currentContext?.read<ActionBloc>();
    if (bloc == null) return;

    bloc.add(const ActionEvent.pageRefresh());
  }

  void _moveDetailScreen(Post post) {
    context.router
        .push(
      PostDetailRoute(
        stockCode: post.stock!.code,
        stockName: post.stock!.name,
        boardGroup: post.boardGroupType!.value,
        postId: post.id,
        boardGroupCategory: post.boardGroupCategory,
      ),
    )
        .then((value) {
      if (value == true) _onRefresh();
    });
  }
}

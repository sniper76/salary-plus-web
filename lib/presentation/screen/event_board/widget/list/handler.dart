part of 'widget.dart';

extension _EventBoardListStateExtension on _EventBoardListState {
  _onTapEventBoard(DataGridCellDetails details, EventBoardListBloc bloc) {
    final EventBoardListState state = bloc.state;
    final int rowIndex = details.rowColumnIndex.rowIndex - 1;

    if (rowIndex < 0) {
      return;
    }

    context.router
        .push(
          PostDetailRoute(
            stockCode: state.eventBoardList[rowIndex].stock!.code,
            stockName: state.eventBoardList[rowIndex].stock!.name,
            boardGroup: state.eventBoardList[rowIndex].boardGroupType!.value,
            postId: state.eventBoardList[rowIndex].id,
            boardGroupCategory: state.eventBoardList[rowIndex].boardGroupCategory,
          ),
        )
        .then(
          (_) => bloc.add(const EventBoardListEvent.refresh()),
        );
  }

  _onPageChanged(int page, EventBoardListBloc bloc) {
    bloc.add(EventBoardListEvent.loadMore(page));
  }

  _onSearch(EventBoardListBloc bloc) {
    bloc.add(EventBoardListEvent.search(searchController.text));
  }

  _onSearchTypeChanged(BoardSearchType? newSearchType, EventBoardListBloc bloc) {
    if (bloc.state.selectedSearchType != newSearchType) {
      bloc.add(EventBoardListEvent.selectSearchType(newSearchType!));
    }
  }

  Future<DateTime?> _onTapDatePicker(EventBoardListBloc bloc) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: bloc.state.selectedSearchStartDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return null;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
    );

    if (selectedTime == null) return null;

    return selectedDate.copyWith(hour: selectedTime.hour, minute: selectedTime.minute, second: 00);
  }

  Future<void> _onTapStartDatePicker(EventBoardListBloc bloc) async {
    final DateTime? selectedDateTime = await _onTapDatePicker(bloc);
    if (selectedDateTime == null) return;
    bloc.add(EventBoardListEvent.selectSearchStartDate(selectedDateTime));
  }

  Future<void> _onTapEndDatePicker(EventBoardListBloc bloc) async {
    final DateTime? selectedDateTime = await _onTapDatePicker(bloc);
    if (selectedDateTime == null) return;
    bloc.add(EventBoardListEvent.selectSearchEndDate(selectedDateTime));
  }
}

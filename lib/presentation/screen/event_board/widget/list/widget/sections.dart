part of '../widget.dart';

class _EventBoardSearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final EventBoardListBloc bloc;
  final Function() onSearch;
  final Function(BoardSearchType?) onSearchTypeChanged;

  const _EventBoardSearchSection({
    required this.searchController,
    required this.bloc,
    required this.onSearch,
    required this.onSearchTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      controller: searchController,
      onSearch: onSearch,
      onChange: (value) {},
      prefixWidget: Row(
        children: [
          // 추후 이벤트의 종류가 생긴다면 사용할 수도 있어서 만들어 놓음(기획서)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade400,
            ),
            width: 150,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '전체',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 150,
            child: CustomDropdown<BoardSearchType>(
              value: bloc.state.selectedSearchType,
              items: bloc.state.eventBoardSearchCategoires,
              getText: (BoardSearchType searchType) => searchType.title,
              onChanged: onSearchTypeChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _DropDownSection extends StatelessWidget {
  final Function() onTapStartDatePicker;
  final Function() onTapEndDatePicker;
  final EventBoardListBloc bloc;

  final periodStatus = ValueNotifier<PeriodCheckStatus>(PeriodCheckStatus.all);

  _DropDownSection({
    required this.onTapStartDatePicker,
    required this.onTapEndDatePicker,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 15.0,
      runSpacing: 8.0,
      children: [
        _DropdownItem(
          title: '상태',
          state: bloc.state,
          currentValue: bloc.state.selectedPostStatusType,
          items: const [
            PostStatusType.all,
            PostStatusType.active,
            PostStatusType.inactive_by_admin,
            PostStatusType.inactive_by_user,
          ],
          getText: (PostStatusType postStatusType) => postStatusType.title,
          onChanged: (PostStatusType? newPostStatusType) {
            bloc.add(EventBoardListEvent.selectPostStatusType(newPostStatusType!));
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DropdownItem(
              title: '기간 조회',
              state: bloc.state,
              currentValue: bloc.state.selectedPeriodCheckStatus,
              items: PeriodCheckStatus.values.toList(),
              getText: (PeriodCheckStatus periodCheckStatus) => periodCheckStatus.title,
              onChanged: (PeriodCheckStatus? newPeriodCheckStatus) {
                bloc.add(EventBoardListEvent.selectPeriodCheck(newPeriodCheckStatus!));
              },
            ),
            bloc.state.selectedPeriodCheckStatus == PeriodCheckStatus.all
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      const SizedBox(width: 10),
                      _PickDateItem(
                        onTapFunction: () {
                          onTapStartDatePicker();
                        },
                        selectedDateTime: bloc.state.selectedSearchStartDate,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '~',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _PickDateItem(
                        onTapFunction: () {
                          onTapEndDatePicker();
                        },
                        selectedDateTime: bloc.state.selectedSearchEndDate,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }
}

class _EventBoardDataGridSection extends StatelessWidget {
  final EventBoardListBloc bloc;
  final Function(DataGridCellDetails) onCellTap;

  const _EventBoardDataGridSection({
    required this.bloc,
    required this.onCellTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final List<CustomColumn> columns = refineColumns([
            CustomColumn(width: 100, columnName: 'No', labelText: 'No'),
            CustomColumn(width: 100, columnName: 'category', labelText: '카테고리'),
            CustomColumn(columnName: 'title', labelText: '제목'),
            CustomColumn(width: 130, columnName: 'startAt', labelText: '시작일'),
            CustomColumn(width: 130, columnName: 'endAt', labelText: '종료일'),
            CustomColumn(width: 100, columnName: 'views', labelText: '조회수'),
            CustomColumn(width: 100, columnName: 'like', labelText: '좋아요'),
            CustomColumn(width: 100, columnName: 'comment', labelText: '댓글'),
            CustomColumn(width: 100, columnName: 'exposure', labelText: '상태')
          ], max(1200, constraints.maxWidth));

          return ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ActDataGrid(
                  onCellTap: onCellTap,
                  rowHeight: 56.0,
                  columns: columns,
                  dataSource: GenericDataSource<Post>(
                    data: bloc.state.eventBoardList,
                    columnNames: columns.map((CustomColumn column) => column.columnName).toList(),
                    valueExtractors: {
                      'No': (Post event, int index) => event.id,
                      'category': (Post event, int index) => event.boardGroupCategory?.displayName,
                      'title': (Post event, int index) => event.title,
                      'content': (Post event, int index) => event.content,
                      'startAt': (Post event, int index) =>
                          event.activeStartDate?.toFormatString(pattern: 'yyyy-MM-dd HH:mm') ?? '-',
                      'endAt': (Post event, int index) =>
                          event.activeEndDate?.toFormatString(pattern: 'yyyy-MM-dd HH:mm') ?? '-',
                      'views': (Post event, int index) => event.viewCount,
                      'like': (Post event, int index) => event.likeCount,
                      'comment': (Post event, int index) => event.commentCount,
                      'exposure': (Post event, int index) => event.status.title,
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

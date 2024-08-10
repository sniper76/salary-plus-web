part of '../screen.dart';

class _UserProfileSection extends StatelessWidget {
  final UserDetailBloc bloc;
  late final UserDetailState state = bloc.state;

  _UserProfileSection({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: 800,
        padding: const EdgeInsets.symmetric(vertical: 54, horizontal: 54),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xffD9D9D9), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
              spreadRadius: 0, // 그림자의 범위를 설정합니다.
              blurRadius: 11, // 흐림 정도를 설정합니다.
              offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: state.userData != null
              ? [
                  _UserInfoListWidget(user: state.userData!),
                  Column(
                    children: [
                      _UserTermListWidget(user: state.userData!),
                      _UserBadgeListWidget(user: state.userData!),
                    ],
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}

class _DummyStocksSection extends StatelessWidget {
  final UserDetailBloc bloc;
  late final UserDetailState state = bloc.state;

  final List<CustomColumn> _columns = [
    CustomColumn(width: 250, columnName: 'name', labelText: '종목명'),
    CustomColumn(width: 150, columnName: 'quantity', labelText: '주식수'),
    CustomColumn(width: 200, columnName: 'referenceDate', labelText: '기준일'),
    CustomColumn(width: 100, columnName: 'deleteButton', labelText: ''),
  ];

  _DummyStocksSection({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return _StockContainer(
      children: [
        ActDataGrid(
          columns: _columns,
          dataSource: GenericDataSource<UserStockData>(
              data: state.userStockDummyData,
              columnNames: _columns.map((e) => e.columnName).toList(),
              valueExtractors: {
                'name': (UserStockData item, int index) => item.name,
                'quantity': (UserStockData item, int index) => item.quantity,
                'referenceDate': (UserStockData item, int index) => item.referenceDate.toFormatString(),
                'deleteButton': (UserStockData item, int index) => item,
              },
              columnAlignments: {
                'title': Alignment.centerLeft,
              },
              customWidgets: {
                'deleteButton': (UserStockData stock) {
                  return ActDeleteButton(
                      titleWidget: const Text('삭제'),
                      onPressed: () => _onOpenDeleteDummyStockDialog(context, stock.code));
                }
              }),
        ),
        if (state.userStockDummyData.isNotEmpty)
          ActPagination<UserDetailBloc, UserDetailState>(
            paging: state.dummyPaging,
            onPageChange: (int page) {
              bloc.add(UserDetailEvent.fetchUserDummyStocks(page: page, userId: bloc.userId));
            },
          ),
        ElevatedButton(onPressed: () => _onMoveDummyStockScreen(context, bloc.userId), child: const Text('더미종목 등록')),
      ],
    );
  }
}

class _UserStockSection extends StatelessWidget {
  final UserDetailBloc bloc;
  late final UserDetailState state = bloc.state;

  final List<CustomColumn> _columns = [
    CustomColumn(width: 250, columnName: 'name', labelText: '종목명'),
    CustomColumn(width: 150, columnName: 'quantity', labelText: '주식수'),
    CustomColumn(width: 200, columnName: 'referenceDate', labelText: '기준일'),
    CustomColumn(width: 200, columnName: 'registerDate', labelText: '등록일'),
  ];

  _UserStockSection({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return _StockContainer(
      children: [
        ActDataGrid(
          columns: _columns,
          dataSource: GenericDataSource<UserStockData>(
            data: state.userStockData,
            columnNames: _columns.map((e) => e.columnName).toList(),
            valueExtractors: {
              'name': (UserStockData item, int index) => item.name,
              'quantity': (UserStockData item, int index) => item.quantity,
              'referenceDate': (UserStockData item, int index) => item.referenceDate.toFormatString(),
              'registerDate': (UserStockData item, int index) => item.registerDate.toFormatString(),
            },
            columnAlignments: {
              'title': Alignment.centerLeft,
            },
          ),
        ),
        if (state.userStockData.isNotEmpty)
          ActPagination<UserDetailBloc, UserDetailState>(
            paging: state.paging,
            onPageChange: (int page) {
              bloc.add(UserDetailEvent.fetchUserDetailLoadMore(
                page: page,
              ));
            },
          )
      ],
    );
  }
}

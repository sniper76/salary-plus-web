import 'dart:math';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/popup/popup_display_target_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_search_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_status.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'bloc/popup_list_bloc.dart';

@RoutePage()
class PopupListScreen extends StatefulWidget {
  const PopupListScreen({super.key});

  @override
  State<PopupListScreen> createState() => _PopupListState();
}

class _PopupListState extends State<PopupListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final _numberPaginatorController = NumberPaginatorController();
  final textFieldSourceKey = GlobalKey();

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    _numberPaginatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PopupListBloc, PopupListState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PopupListBloc()
        ..add(
          const PopupListEvent.init(),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildUserScreen(context, bloc, state);
      },
    );
  }

  Widget _buildUserScreen(BuildContext context, PopupListBloc bloc, PopupListState state) {
    return BlocListener<PopupListBloc, PopupListState>(
      listenWhen: (previousState, currentState) {
        return previousState.refreshPage != currentState.refreshPage;
      },
      listener: (context, state) {
        bloc.add(const PopupListEvent.refresh());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: '팝업',
          trailingWidgets: [
            Text(
              "총 ${max(state.paging.total, state.totalCount).toNumberFormat}개",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff666666),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearch(context, bloc, state),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.router.push(PopupRegisterRoute()).then((value) {
                        if (value == true) {
                          bloc.add(const PopupListEvent.refresh());
                        }
                      });
                    },
                    child: const Text("팝업생성"),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(
                  children: [
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        double gridWidth = constraints.maxWidth - 500;
                        final columns = [
                          CustomColumn(width: 150, columnName: 'createdAt', labelText: '등록일'),
                          CustomColumn(width: 150, columnName: 'displayTargetType', labelText: '위치'),
                          CustomColumn(columnName: 'title', labelText: '제목', width: gridWidth),
                          CustomColumn(width: 100, columnName: 'status', labelText: '상태'),
                          CustomColumn(width: 100, columnName: 'button', labelText: ''),
                        ];
                        return ActDataGrid(
                          dataSource: GenericDataSource<Popup>(
                            data: state.popups,
                            columnNames: columns.map((e) => e.columnName).toList(),
                            valueExtractors: {
                              'createdAt': (Popup item, int index) => item.createdAt?.toFormatString(),
                              'displayTargetType': (Popup item, int index) => item,
                              'title': (Popup item, int index) => item.title,
                              'status': (Popup item, int index) => item.popupStatus.title,
                              'button': (Popup item, int index) => item,
                            },
                            columnAlignments: {
                              'title': Alignment.centerLeft,
                            },
                            customWidgets: {
                              'displayTargetType': (Popup item) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "[${item.displayTargetType.title}]",
                                    style: const TextStyle(
                                        fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xff439CFB)),
                                  ),
                                );
                              },
                              'button': (Popup item) {
                                final isProcessing = item.popupStatus == PopupStatus.processing;
                                return isProcessing == true
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          final isConfirm =
                                              await context.showConfirmDialog(title: '팝업', message: '팝업을 취소하시겠습니까?');
                                          if (isConfirm) {
                                            bloc.add(PopupOnCancelPopup(item.id));
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(MaterialState.disabled)) {
                                                return const Color(0xffD9D9D9);
                                              }
                                              return const Color(0xffFFA621);
                                            },
                                          ),
                                        ),
                                        child: const Text(
                                          "취소",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      )
                                    : Container();
                              }
                            },
                          ),
                          columns: columns,
                          onCellTap: (details) {
                            final rowIndex = details.rowColumnIndex.rowIndex - 1;
                            if (rowIndex < 0) {
                              return;
                            }
                            context.router.pushNamed('popup/${state.popups[rowIndex].id}').then((value) {
                              if (value == true) {
                                bloc.add(const PopupListEvent.refresh());
                              }
                            });
                          },
                        );
                      },
                    ),
                    _buildPagination(context, bloc, state)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context, PopupListBloc bloc, PopupListState state) {
    return BlocListener<PopupListBloc, PopupListState>(
      listenWhen: (previousState, currentState) {
        return previousState.sourceCandidateStockList != currentState.sourceCandidateStockList;
      },
      listener: (context, state) {},
      child: SizedBox(
          height: 50.0,
          child: CustomSearchBar(
            controller: _controller,
            onSearch: () {
              bloc.add(PopupListEvent.loadMore(
                searchKeyword: _controller.text,
                page: 1,
                size: apiLoadSize,
              ));
            },
            onChange: (value) {},
            prefixWidget: _buildDropDown(context, bloc, state),
          )),
    );
  }

  Widget _buildDropDown(BuildContext context, PopupListBloc bloc, PopupListState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 200,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PopupSearchType>(
          focusColor: Colors.white,
          padding: const EdgeInsets.only(left: 24.0, right: 16.0),
          value: state.searchType,
          hint: const Text('카테고리 선택'),
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (PopupSearchType? newValue) {
            bloc.add(PopupListEvent.changedSearchType(newValue!));
            _controller.text = "";
          },
          items: [
            PopupSearchType.popup_title,
          ].map<DropdownMenuItem<PopupSearchType>>((PopupSearchType value) {
            return DropdownMenuItem<PopupSearchType>(
              value: value,
              child: Text(
                value.title,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            );
          }).toList(),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, PopupListBloc bloc, PopupListState state) {
    if (state.popups.isNotEmpty) {
      return ActPagination<PopupListBloc, PopupListState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(PopupListEvent.loadMore(
            page: page,
          ));
        },
      );
    }

    return Container();
  }
}

class PopupDataSource extends DataGridSource {
  final void Function(int) func;
  final BuildContext context;
  static const textStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);

  String formatViewCount(int? viewCount) {
    if (viewCount == null) return '0';
    return NumberFormat('#,###').format(viewCount);
  }

  String formatDateTime(DateTime dateTime) {
    return dateTime.toFormatString(pattern: dateTimeFormatPattern2);
  }

  PopupDataSource(List<Popup> popups, this.context, this.func) {
    dataGridRows = popups
        .map<DataGridRow>((popup) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'createdAt', value: formatDateTime(popup.createdAt!)),
              DataGridCell<String>(columnName: 'displayTargetType', value: popup.displayTargetType.title),
              DataGridCell<String>(columnName: 'title', value: popup.title),
              DataGridCell<String>(columnName: 'status', value: popup.popupStatus.title),
              DataGridCell<Popup>(columnName: 'button', value: popup),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      return Container(
          alignment: Alignment.center,
          padding: cell.columnName == 'button' ? const EdgeInsets.all(2.0) : const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
          child: _buildCell(cell));
    }).toList());
  }

  Widget? _buildCell(DataGridCell cell) {
    switch (cell.columnName) {
      case 'button':
        return _buildButtonCell(cell);
      case 'displayTargetType':
        return _buildCategoryCell(cell);
      default:
        return _buildDefaultCell(cell);
    }
  }

  ElevatedButton? _buildButtonCell(DataGridCell cell) {
    final isProcessing = cell.value.popupStatus == PopupStatus.processing;
    return isProcessing
        ? ElevatedButton(
            onPressed: () async {
              final isConfirm = await context.showConfirmDialog(title: '팝업', message: '팝업을 취소하시겠습니까?');
              if (isConfirm) {
                func(cell.value.id);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return const Color(0xffD9D9D9);
                  }
                  return const Color(0xffFFA621);
                },
              ),
            ),
            child: const Text(
              "취소",
              style: TextStyle(fontSize: 10),
            ),
          )
        : null;
  }

  Widget _buildCategoryCell(DataGridCell cell) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "[${cell.value ?? " "}]",
        style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xff439CFB)),
      ),
    );
  }

  Widget _buildDefaultCell(DataGridCell cell) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          cell.value.toString(),
          style: textStyle,
        ),
      ],
    );
  }
}

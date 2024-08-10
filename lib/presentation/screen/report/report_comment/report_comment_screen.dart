import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/report_status_type.dart';
import 'package:act_cms/domain/model/report_list.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/base/base_constant.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_filter_button.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'bloc/report_comment_bloc.dart';

@RoutePage()
class ReportCommentScreen extends StatefulWidget {
  const ReportCommentScreen({super.key});

  @override
  State<ReportCommentScreen> createState() => _ReportReportCommentState();
}

class _ReportReportCommentState extends State<ReportCommentScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final _numberPaginatorController = NumberPaginatorController();

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<ReportCommentBloc, ReportCommentState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => ReportCommentBloc()
        ..add(
          const ReportCommentEvent.init(),
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

  Widget _buildUserScreen(BuildContext context, ReportCommentBloc bloc, ReportCommentState state) {
    return BlocListener<ReportCommentBloc, ReportCommentState>(
      listenWhen: (previousState, currentState) {
        return previousState.reportStatus != currentState.reportStatus ||
            previousState.paginatorIndex != currentState.paginatorIndex ||
            previousState.refreshPage != currentState.refreshPage;
      },
      listener: (context, state) {
        // bloc.add(ReportCommentEvent.fetchReportComment(
        //     reportStatus: state.reportStatus.value));
        bloc.add(ReportCommentEvent.fetchReportComment(
            reportStatus: state.reportStatus.value, page: state.paginatorIndex, size: apiLoadSize));
        if (state.paginatorIndex != _numberPaginatorController.currentPage) {
          _numberPaginatorController.currentPage = state.paginatorIndex;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: "신고 (댓글/답글)",
          trailingWidgets: [
            Text(
              "총 ${state.paging.total.toNumberFormat}개",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilterList(context, bloc, state),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView(
                  children: [
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        // SfDataGrid의 최대 너비를 1200, 최소 너비를 800으로 설정합니다.
                        double gridWidth = constraints.maxWidth > 1200
                            ? 1200 - 700
                            : constraints.maxWidth < 800
                                ? 800 - 700
                                : constraints.maxWidth - 700;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: constraints.maxWidth),
                            child: SfDataGrid(
                              shrinkWrapColumns: true,
                              shrinkWrapRows: true,
                              columnWidthMode: ColumnWidthMode.none,
                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'category',
                                    label: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: sfTableBoxStyle,
                                      child: const Center(
                                          child: Text(
                                        '종목',
                                        style: sfTableTextStyle,
                                      )),
                                    ),
                                    width: 150),
                                GridColumn(
                                    columnName: 'status',
                                    label: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: sfTableBoxStyle,
                                      child: const Center(
                                          child: Text(
                                        '상태',
                                        style: sfTableTextStyle,
                                      )),
                                    ),
                                    width: 100),
                                GridColumn(
                                    columnName: 'title',
                                    label: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: sfTableBoxStyle,
                                      child: const Center(
                                          child: Text(
                                        '제목',
                                        style: sfTableTextStyle,
                                      )),
                                    ),
                                    width: gridWidth),
                                GridColumn(
                                  columnName: 'createAt',
                                  label: Container(
                                    padding: const EdgeInsets.all(4.0), // Padding 추가
                                    decoration: sfTableBoxStyle,
                                    child: const Center(
                                        child: Text(
                                      '작성일',
                                      style: sfTableTextStyle,
                                    )),
                                  ),
                                  width: 150,
                                ),
                                GridColumn(
                                  columnName: 'viewCount',
                                  label: Container(
                                    padding: const EdgeInsets.all(4.0), // Padding 추가
                                    decoration: sfTableBoxStyle,
                                    child: const Center(
                                        child: Text(
                                      '조회수',
                                      style: sfTableTextStyle,
                                    )),
                                  ),
                                  width: 100,
                                ),
                                GridColumn(
                                  columnName: 'likeCount',
                                  label: Container(
                                    padding: const EdgeInsets.all(4.0), // Padding 추가
                                    decoration: sfTableBoxStyle,
                                    child: const Center(
                                        child: Text(
                                      '좋아요',
                                      style: sfTableTextStyle,
                                    )),
                                  ),
                                  width: 100,
                                ),
                                GridColumn(
                                  columnName: 'commentCount',
                                  label: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4.0), // Padding 추가
                                    decoration: sfTableBoxStyle,
                                    child: const Center(
                                        child: Text(
                                      '댓글',
                                      style: sfTableTextStyle,
                                    )),
                                  ),
                                  width: 100,
                                ),
                              ],
                              onCellTap: (details) {
                                final rowIndex = details.rowColumnIndex.rowIndex - 1;
                                if (rowIndex < 0) {
                                  return;
                                }
                                context.router
                                    .push(ReportPostDetailRoute(
                                        reportType: "COMMENT", reportId: state.reportList[rowIndex].reportId))
                                    .then((value) => bloc.add(const ReportCommentEvent.pageRefresh()));
                              },
                              headerRowHeight: 32,
                              rowHeight: 32,
                              headerGridLinesVisibility: GridLinesVisibility.none,
                              gridLinesVisibility: GridLinesVisibility.none,
                              source: PostDataSource(state.reportList),
                            ),
                          ),
                        );
                      },
                    ),
                    _buildPagination(context, bloc, state),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterList(BuildContext context, ReportCommentBloc bloc, ReportCommentState state) {
    List<ReportStatusType> statusTypeList = [
      ReportStatusType.all,
      ReportStatusType.ready,
      ReportStatusType.processing,
      ReportStatusType.complete,
      ReportStatusType.reject
    ];
    return Column(
      children: [
        // 첫 번째 라인의 필터
        // 두 번째 라인의 필터
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...statusTypeList
                .map((item) => ActFilterButton(
                      text: item.title,
                      isSelected: state.reportStatus == item,
                      onPressed: () {
                        bloc.add(ReportCommentEvent.setReportStatus(item));
                      },
                    ))
                .toList()
          ],
        ),
      ],
    );
  }

  Widget _buildPagination(BuildContext context, ReportCommentBloc bloc, ReportCommentState state) {
    if (state.reportList.isNotEmpty) {
      return ActPagination<ReportCommentBloc, ReportCommentState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(ReportCommentEvent.fetchReportComment(
            page: page,
          ));
        },
      );
    }

    return Container();
  }
}

class PostDataSource extends DataGridSource {
  static const testStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);

  String formatViewCount(int? viewCount) {
    if (viewCount == null) return '0';
    return NumberFormat('#,###').format(viewCount);
  }

  PostDataSource(List<ReportList> postList) {
    dataGridRows = postList
        .map<DataGridRow>((item) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'category', value: item.stockName),
              DataGridCell<String>(columnName: 'status', value: item.reportStatus),
              DataGridCell<String>(columnName: 'title', value: item.title),
              DataGridCell<String>(columnName: 'createAt', value: item.createdAt.toFormatString()),
              DataGridCell<String>(columnName: 'viewCount', value: formatViewCount(item.viewCount)),
              DataGridCell<String>(columnName: 'likeCount', value: formatViewCount(item.likeCount)),
              DataGridCell<String>(columnName: 'commentCount', value: formatViewCount(item.commentCount)),
              // 다른 필드를 여기에 추가할 수 있습니다.
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
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: cell.columnName == "category"
            ? Container(
                alignment: cell.columnName == 'title' ? Alignment.centerLeft : Alignment.center,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
                child: Text(
                  "[${cell.value.toString()}]",
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xff439CFB)),
                ),
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
                child: Text(
                  cell.value.toString(),
                  style: testStyle,
                ),
              ),
      );
    }).toList());
  }
}

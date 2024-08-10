import 'dart:math';

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/enum/push/push_send_status.dart';
import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/screen/push/group/bloc/push_group_list_bloc.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:number_paginator/number_paginator.dart';

@RoutePage()
class PushGroupListScreen extends StatefulWidget {
  const PushGroupListScreen({super.key});

  @override
  State<PushGroupListScreen> createState() => _PushListState();
}

class _PushListState extends State<PushGroupListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final _numberPaginatorController = NumberPaginatorController();
  OverlayEntry? overlayEntry;
  final textFieldSourceKey = GlobalKey();

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    _numberPaginatorController.dispose();
    overlayEntry?.remove();
    overlayEntry = null;
    super.dispose();
  }

  void _onMovePushRegister() {
    final bloc = _scaffoldKey.currentContext?.read<PushGroupListBloc>();
    if (bloc == null) return;

    context.router.push(const PushRegisterRoute()).then((value) {
      bloc.add(const PushGroupListEvent.refresh());
    });
  }

  void _cancelPush(int id) async {
    final bloc = _scaffoldKey.currentContext?.read<PushGroupListBloc>();
    if (bloc == null) return;

    final ret = await context.showConfirmDialog(title: "푸시 발송", message: "푸쉬 발송을 취소 하시겠습니까?");
    if (ret) {
      bloc.add(PushGroupOnCancelPush(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PushGroupListBloc, PushGroupListState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PushGroupListBloc()
        ..add(
          const PushGroupListEvent.init(),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildScreen(context, bloc, state);
      },
    );
  }

  Widget _buildScreen(BuildContext context, PushGroupListBloc bloc, PushGroupListState state) {
    return BlocListener<PushGroupListBloc, PushGroupListState>(
      listenWhen: (previousState, currentState) {
        return previousState.refreshPage != currentState.refreshPage;
      },
      listener: (context, state) {
        bloc.add(const PushGroupListEvent.refresh());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: "푸시",
          trailingWidgets: [
            Text(
              "총 ${max(state.paging.total, state.totalCount).toNumberFormat}개",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStockSearch(context, bloc, state),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(onPressed: _onMovePushRegister, child: const Text("푸시발송")),
              ]),
              const SizedBox(height: 16),
              _buildDataGrid(context, bloc, state)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockSearch(BuildContext context, PushGroupListBloc bloc, PushGroupListState state) {
    return BlocListener<PushGroupListBloc, PushGroupListState>(
      listenWhen: (previousState, currentState) {
        return previousState.sourceCandidateStockList != currentState.sourceCandidateStockList;
      },
      listener: (context, state) {
        if (state.searchType != PushSearchType.stockName) return;
        overlayEntry = createSimpleStockOverlay(
          context: context,
          textFieldKey: textFieldSourceKey,
          simpleStockList: state.sourceCandidateStockList,
          onListTap: (i) {
            _controller.text = state.sourceCandidateStockList[i].name;
            bloc.add(PushGroupListEvent.setSearchKeyword(state.sourceCandidateStockList[i].name));
            overlayEntry?.remove();
            overlayEntry = null;
          },
          oldOverlayEntry: overlayEntry,
          removeOverlay: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          sidebarSize: 300,
        );
      },
      child: CustomSearchBar(
        controller: _controller,
        onSearch: () {
          bloc.add(PushGroupListEvent.loadMore(
            searchKeyword: _controller.text,
            page: 1,
            size: apiLoadSize,
          ));
        },
        onChange: (value) {
          bloc.add(PushGroupListEvent.setSearchKeyword(value));
        },
        prefixWidget: _buildDropDown(context, bloc, state),
      ),
    );
  }

  Widget _buildDropDown(BuildContext context, PushGroupListBloc bloc, PushGroupListState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 200,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PushSearchType>(
          focusColor: Colors.white,
          padding: const EdgeInsets.only(left: 24.0, right: 16.0),
          value: state.searchType,
          hint: const Text('카테고리 선택'),
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (PushSearchType? newValue) {
            bloc.add(PushGroupListEvent.changedSearchType(newValue!));
            _controller.text = "";
          },
          items: [PushSearchType.stockName, PushSearchType.pushTitle, PushSearchType.pushContent]
              .map<DropdownMenuItem<PushSearchType>>((PushSearchType value) {
            return DropdownMenuItem<PushSearchType>(
              value: value,
              child: Text(value.title, style: const TextStyle(fontSize: 16.0)),
            );
          }).toList(),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _buildDataGrid(BuildContext context, PushGroupListBloc bloc, PushGroupListState state) {
    return Expanded(
      child: ListView(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final columns = refineColumns([
                CustomColumn(width: 150, columnName: 'targetDatetime', labelText: '등록일'),
                CustomColumn(width: 150, columnName: 'category', labelText: '카테고리'),
                CustomColumn(width: 200, columnName: 'title', labelText: '제목'),
                CustomColumn(columnName: 'content', labelText: '내용'),
                CustomColumn(width: 100, columnName: 'cancel', labelText: ''),
              ], constraints.maxWidth);

              return ActDataGrid(
                dataSource: GenericDataSource<GroupPush>(
                    data: state.pushes,
                    columnNames: columns.map((e) => e.columnName).toList(),
                    valueExtractors: {
                      'targetDatetime': (GroupPush item, int index) => item.createdAt.toFormatString(),
                      'category': (GroupPush item, int index) => item.category,
                      'title': (GroupPush item, int index) => item.title,
                      'content': (GroupPush item, int index) => item.content,
                      'cancel': (GroupPush item, int index) => item,
                    },
                    customWidgets: {
                      'cancel': (GroupPush item) {
                        return _buildCancelReservation(item);
                      }
                    }),
                columns: columns,
                onCellTap: (details) {},
              );
            },
          ),
          _buildPagination(context, bloc, state)
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, PushGroupListBloc bloc, PushGroupListState state) {
    if (state.pushes.isNotEmpty) {
      return ActPagination<PushGroupListBloc, PushGroupListState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(PushGroupListEvent.loadMore(
            page: page,
          ));
        },
      );
    }

    return Container();
  }

  Widget _buildCancelReservation(GroupPush item) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        onPressed: item.sendStatus == PushSendStatus.ready && item.sendType == PushSendType.schedule
            ? () => _cancelPush(item.id)
            : null,
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
        child: const Text("예약취소", style: TextStyle(fontSize: 10)),
      ),
    );
  }
}

import 'dart:math';

import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/individual_push.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/push/individual/bloc/push_individual_list_bloc.dart';
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
class PushIndividualListScreen extends StatefulWidget {
  const PushIndividualListScreen({super.key});

  @override
  State<PushIndividualListScreen> createState() => _PushIndividualListState();
}

class _PushIndividualListState extends State<PushIndividualListScreen> {
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
    return BaseBlocLayout<PushIndividualListBloc, PushIndividualListState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PushIndividualListBloc()
        ..add(
          const PushIndividualListEvent.init(),
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

  Widget _buildScreen(BuildContext context, PushIndividualListBloc bloc, PushIndividualListState state) {
    return BlocListener<PushIndividualListBloc, PushIndividualListState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: "푸시",
          trailingWidgets: [
            Text(
              "총 ${max(state.paging.total, 0).toNumberFormat}개",
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
              _buildDataGrid(context, bloc, state)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockSearch(BuildContext context, PushIndividualListBloc bloc, PushIndividualListState state) {
    return CustomSearchBar(
      controller: _controller,
      onSearch: () => bloc.add(PushIndividualListEvent.getPushList(searchKeyword: _controller.text)),
      onChange: (value) {},
      prefixWidget: _buildDropDown(context, bloc, state),
    );
  }

  Widget _buildDropDown(BuildContext context, PushIndividualListBloc bloc, PushIndividualListState state) {
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
            bloc.add(PushIndividualListEvent.setSearchType(newValue!));
            _controller.text = "";
          },
          items: _buildDropdownItemList(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<PushSearchType>> _buildDropdownItemList() {
    return [PushSearchType.pushContent, PushSearchType.userName, PushSearchType.nickName]
        .map<DropdownMenuItem<PushSearchType>>((PushSearchType value) {
      return DropdownMenuItem<PushSearchType>(
        value: value,
        child: Text(value.title, style: const TextStyle(fontSize: 16.0)),
      );
    }).toList();
  }

  Widget _buildDataGrid(BuildContext context, PushIndividualListBloc bloc, PushIndividualListState state) {
    return Expanded(
      child: ListView(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final columns = refineColumns([
                CustomColumn(width: 200, columnName: 'targetDatetime', labelText: '발송일시'),
                CustomColumn(width: 200, columnName: 'userName', labelText: '이름(닉네임)'),
                CustomColumn(columnName: 'content', labelText: '내용'),
              ], constraints.maxWidth);

              return ActDataGrid(
                dataSource: GenericDataSource<IndividualPush>(
                  data: state.pushes,
                  columnNames: columns.map((e) => e.columnName).toList(),
                  valueExtractors: {
                    'targetDatetime': (IndividualPush item, int index) => item.createdAt.toFormatString(),
                    'userName': (IndividualPush item, int index) => '${item.user.name} (${item.user.nickname})',
                    'content': (IndividualPush item, int index) => item.content,
                  },
                  columnAlignments: {
                    'title': Alignment.centerLeft,
                  },
                ),
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

  Widget _buildPagination(BuildContext context, PushIndividualListBloc bloc, PushIndividualListState state) {
    if (state.pushes.isNotEmpty) {
      return ActPagination<PushIndividualListBloc, PushIndividualListState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(PushIndividualListEvent.getPushList(page: page));
        },
      );
    }

    return Container();
  }
}

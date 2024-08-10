import 'dart:math';

import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/period_check.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/event_board/widget/list/bloc/bloc.dart';
import 'package:act_cms/presentation/screen/event_board/widget/list/bloc/event.dart';
import 'package:act_cms/presentation/screen/event_board/widget/list/bloc/state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/button/act_event_button.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'handler.dart';
part 'widget/sections.dart';
part 'widget/drop_down_item.dart';
part 'widget/pick_date_item.dart';

class EventBoardList extends StatefulWidget {
  final BoardGroupCategory boardGroupCategory;

  EventBoardList({required this.boardGroupCategory, super.key})
      : assert(boardGroupCategory.name == BoardGroupCategory.event().name ||
            boardGroupCategory.name == BoardGroupCategory.campaign().name ||
            boardGroupCategory.name == BoardGroupCategory.notice().name);

  @override
  State<EventBoardList> createState() => _EventBoardListState();
}

class _EventBoardListState extends State<EventBoardList> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton(
      EventBoardListBloc(
        boardGroupCategory: widget.boardGroupCategory,
      )..add(const EventBoardListEvent.init()),
      instanceName: widget.boardGroupCategory.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<EventBoardListBloc, EventBoardListState>(
      create: (context) => GetIt.I.get<EventBoardListBloc>(
        instanceName: widget.boardGroupCategory.name,
      ),
      builder: (context, bloc, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _EventBoardSearchSection(
                searchController: searchController,
                bloc: bloc,
                onSearch: () {
                  _onSearch(bloc);
                },
                onSearchTypeChanged: (BoardSearchType? newSearchType) {
                  _onSearchTypeChanged(newSearchType, bloc);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 155,
                ),
                child: _DropDownSection(
                  onTapStartDatePicker: () {
                    _onTapStartDatePicker(bloc);
                  },
                  onTapEndDatePicker: () {
                    _onTapEndDatePicker(bloc);
                  },
                  bloc: bloc,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: ActEventButton(
                  onPressed: () async {
                    await context.router.push(EventBoardRegisterRoute(
                      boardGroupCategory: widget.boardGroupCategory,
                    ));
                    bloc.add(const EventBoardListEvent.refresh());
                  },
                  size: const Size(180, 50),
                  title: '${widget.boardGroupCategory.displayName} 등록',
                ),
              ),
              _EventBoardDataGridSection(
                bloc: bloc,
                onCellTap: (DataGridCellDetails details) {
                  _onTapEventBoard(details, bloc);
                },
              ),
              if (state.eventBoardList.isNotEmpty)
                ActPagination<EventBoardListBloc, EventBoardListState>(
                  paging: state.paging,
                  onPageChange: (int page) {
                    _onPageChanged(page, bloc);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    GetIt.I.unregister<EventBoardListBloc>(
      instanceName: widget.boardGroupCategory.name,
    );
    super.dispose();
  }
}

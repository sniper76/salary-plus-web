import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/dialog/zip_file_download_dialog/bloc/bloc.dart';
import 'package:act_cms/presentation/dialog/zip_file_download_dialog/zip_file_download_dialog.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/widget/act_filter_button.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/action_data_grid.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/duplicate_post_button.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'bloc/bloc.dart';

part 'handler.dart';
part 'widget/action_filter_list.dart';
part 'widget/action_pagination.dart';

@RoutePage()
class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  State<ActionScreen> createState() => _ActionState();
}

class _ActionState extends State<ActionScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _numberPaginatorController = NumberPaginatorController();
  final _textController = TextEditingController();
  final textFieldSourceKey = GlobalKey();

  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton(ActionBloc());
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<ActionBloc, ActionState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => GetIt.I<ActionBloc>()..add(const ActionEvent.init()),
      listener: (context, state) {
        if (state.isSuccessChangeReferenceDay) {
          onSuccessChangeReferenceDay(context);
        }
      },
      builder: (context, bloc, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: MainAppBar(
            mainTitle: "액션",
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
                BlocListener<ActionBloc, ActionState>(
                  listenWhen: (previousState, currentState) {
                    return previousState.sourceCandidateStockList != currentState.sourceCandidateStockList;
                  },
                  listener: (context, state) {
                    if (state.searchType == BoardSearchType.title) return;
                    overlayEntry = createSimpleStockOverlay(
                      context: context,
                      textFieldKey: textFieldSourceKey,
                      simpleStockList: state.sourceCandidateStockList,
                      onListTap: (i) {
                        final selectedSourceStock = state.sourceCandidateStockList[i];
                        bloc.add(ActionEvent.setSelectedSimpleStock(selectedSourceStock));
                        _textController.text = selectedSourceStock.name;
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
                    controller: _textController,
                    key: textFieldSourceKey,
                    onSearch: () {
                      bloc.add(ActionEvent.getPosts(searchKeyword: _textController.text));
                    },
                    onChange: (value) {
                      bloc.add(ActionEvent.postOnSetSearchKeyword(value));
                    },
                    hintText: state.searchType == BoardSearchType.title ? "제목을 입력하세요." : "종목명 또는 종목코드를 입력하세요.",
                    prefixWidget: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: 200,
                      child: CustomDropdown<BoardSearchType>(
                        value: state.searchType,
                        items: BoardSearchType.values
                            .where((searchType) => searchType != BoardSearchType.unknown)
                            .toList(),
                        getText: (BoardSearchType value) => value.title,
                        onChanged: (BoardSearchType? newValue) {
                          bloc.add(ActionEvent.postOnSetSearchType(newValue!));
                          _textController.text = "";
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      _ActionFilterList(),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          context.router.push(ActionPostRegisterRoute()).then((value) {
                            bloc.add(const ActionEvent.pageRefresh());
                          });
                        },
                        child: const Text("액션 등록"),
                      ),
                      const SizedBox(width: 8),
                      DuplicatePostButton(
                        route: () => PostDuplicateRoute(boardGroupType: BoardGroupType.action),
                        doneCallback: (value) => bloc.add(const ActionEvent.pageRefresh()),
                        title: "액션 복제",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ActionDataGrid(
                  postList: state.postList,
                  pagination: ActionPagination(),
                  onMoveDetailScreen: _moveDetailScreen,
                  onHandleReferenceDate: (Post post) {
                    _onHandleReferenceDate(context, bloc, post);
                  },
                  onDownloadExcel: (Post post) {
                    bloc.add(
                      ActionEvent.downloadExcel(post.digitalDocument!.id),
                    );
                  },
                  onDownloadZipFile: (Post post) {
                    _onHandleDownload(context, bloc, post);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<ActionBloc>();

    EasyLoading.dismiss();
    _textController.dispose();
    _numberPaginatorController.dispose();
    overlayEntry?.remove();
    overlayEntry = null;
    super.dispose();
  }
}

import 'dart:async';
import 'dart:html';

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/action/pdf_screen/sfpdf_screen.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:number_paginator/number_paginator.dart';

import 'bloc/doc_bloc.dart';

@RoutePage()
class DigitalDocumentUsersScreen extends StatefulWidget {
  final int? id;
  final String? title;

  const DigitalDocumentUsersScreen({super.key, @queryParam this.id, @queryParam this.title});

  @override
  State<DigitalDocumentUsersScreen> createState() => _DigitalDocumentState();
}

class _DigitalDocumentState extends State<DigitalDocumentUsersScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final _numberPaginatorController = NumberPaginatorController();
  OverlayEntry? overlayEntry;
  final textFieldSourceKey = GlobalKey();
  StreamSubscription<PopStateEvent>? _popStateSubscription;

  void _registerPopStateListener() {
    _popStateSubscription = window.onPopState.listen((event) {
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.id == null || widget.title == null) {
      _onDismiss();
    }
    _registerPopStateListener();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    _numberPaginatorController.dispose();
    overlayEntry?.remove();
    overlayEntry = null;
    _popStateSubscription?.cancel();
    super.dispose();
  }

  _onDismiss() async {
    await context.showAlertDialog(title: '게시글 없음', message: '게시글을 찾을 수 없습니다.');
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<DigitalDocumentBloc, DigitalDocumentState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => DigitalDocumentBloc(widget.id!)
        ..add(
          const DigitalDocumentEvent.init(),
        ),
      backgroundColor: const Color(0xfff5f5f5),
      appBar: MainAppBar(mainTitle: "전자문서 확인하기", context: context),
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }
        return _buildScreen(context, bloc, state);
      },
    );
  }

  Widget _buildScreen(BuildContext context, DigitalDocumentBloc bloc, DigitalDocumentState state) {
    return Container(
      margin: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [_buildUserList(context, bloc, state), const SizedBox(width: 50), _buildPdf(context, bloc, state)],
      ),
    );
  }

  Widget _buildUserList(BuildContext context, DigitalDocumentBloc bloc, DigitalDocumentState state) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomSearchBar(
            controller: _controller,
            onSearch: () {
              bloc.add(DigitalDocumentEvent.fetchList(
                searchKeyword: _controller.text,
                page: 1,
                size: apiLoadSize,
              ));
              _numberPaginatorController.currentPage = 0;
            },
            onChange: (value) {
              bloc.add(DigitalDocumentEvent.setSearchKeyword(value));
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final columns = refineColumns([
                  CustomColumn(width: 50, columnName: 'number', labelText: '번호'),
                  CustomColumn(columnName: 'name', labelText: '이름'),
                  CustomColumn(width: 100, columnName: 'phone', labelText: '전화번호'),
                  CustomColumn(width: 100, columnName: 'action', labelText: ''),
                ], constraints.maxWidth);
                return ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: ActDataGrid(
                      columns: columns,
                      dataSource: GenericDataSource<DigitalDocumentUser>(
                          data: state.userList,
                          columnNames: columns.map((e) => e.columnName).toList(),
                          valueExtractors: {
                            'number': (DigitalDocumentUser userData, int index) => userData.issuedNumber,
                            'name': (DigitalDocumentUser userData, int index) =>
                                "${userData.name}(${userData.birthDate.toFormatString(pattern: "yyMMdd")})",
                            'phone': (DigitalDocumentUser userData, int index) => userData.phoneNumber,
                            'action': (DigitalDocumentUser userData, int index) => userData,
                          },
                          customWidgets: {
                            'action': (DigitalDocumentUser userDate) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff439CFB), borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: const Text(
                                    "위임장",
                                    style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          }),
                      onCellTap: (details) {
                        final rowIndex = details.rowColumnIndex.rowIndex - 1;
                        if (rowIndex < 0) {
                          return;
                        }
                        bloc.add(DigitalDocumentEvent.getPDF(state.userList[rowIndex].userId!, state.documentId));
                      },
                    ));
              },
            ),
          ),
          if (state.userList.isNotEmpty)
            ActPagination<DigitalDocumentBloc, DigitalDocumentState>(
              paging: state.paging,
              onPageChange: (int page) {
                bloc.add(DigitalDocumentEvent.fetchList(
                  searchKeyword: state.searchKeyword,
                  page: page,
                ));
              },
            )
        ],
      ),
    );
  }

  Widget _buildPdf(BuildContext context, DigitalDocumentBloc bloc, DigitalDocumentState state) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black87, width: 1), borderRadius: BorderRadius.circular(8)),
        child: state.pdfUrl != null
            ? ClipRRect(borderRadius: BorderRadius.circular(8), child: SfPDFScreen(url: state.pdfUrl!))
            : SizedBox(
                height: MediaQuery.of(context).size.height - 240,
                child: Center(
                    child: Text(
                  "PDF Viewer",
                  style: TextStyle(color: Colors.grey[400], fontSize: 32, fontWeight: FontWeight.bold),
                )),
              ),
      ),
    );
  }
}

import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/core/util/file_download_utill.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/acception/list/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/action_data_grid.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AcceptanceListScreen extends StatefulWidget {
  const AcceptanceListScreen({super.key});

  @override
  State<AcceptanceListScreen> createState() => _AcceptanceListScreenState();
}

class _AcceptanceListScreenState extends State<AcceptanceListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  void _setSearchType(BoardSearchType? searchType) {
    final bloc = _scaffoldKey.currentContext?.read<AcceptanceListBloc>();
    if (bloc == null || searchType == null) return;

    bloc.add(AcceptanceListEvent.onSetSearchType(searchType));
  }

  void _onRefresh() {
    final bloc = _scaffoldKey.currentContext?.read<AcceptanceListBloc>();
    if (bloc == null) return;

    bloc.add(const AcceptanceListEvent.onInit());
  }

  void _onSearch() {
    final bloc = _scaffoldKey.currentContext?.read<AcceptanceListBloc>();
    if (bloc == null) return;

    bloc.add(AcceptanceListEvent.onGetAcceptanceList(searchKeyword: _controller.text));
  }

  void _onMovePage(int page) {
    final bloc = _scaffoldKey.currentContext?.read<AcceptanceListBloc>();
    if (bloc == null) return;

    bloc.add(AcceptanceListEvent.onGetAcceptanceList(page: page));
  }

  void _onDownloadExcel(Post post) {
    final bloc = _scaffoldKey.currentContext?.read<AcceptanceListBloc>();
    if (bloc == null) return;

    bloc.add(
      AcceptanceListEvent.onDownloadExcel(post.digitalDocument!.id),
    );
  }

  void _onDownloadFile(String zipFileKey) {
    FileDownloadUtils(context: context).downloadLink(key: zipFileKey);
  }

  String _getDateText(DateTime? date) {
    return date == null ? '생성 중' : '${date.toFormatString(pattern: 'yyyy-MM-dd HH:mm')} 생성';
  }

  void _onOpenDownloadZipFileDialog({required BuildContext context, required Post post}) async {
    final digitalDocsDownloadFile = post.digitalDocument?.digitalDocumentDownload;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: const Text('ZIP 다운로드', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            content: Text(
              _getDateText(digitalDocsDownloadFile?.updatedAt),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  onPressed: digitalDocsDownloadFile == null
                      ? null
                      : () {
                          _onDownloadFile(digitalDocsDownloadFile.zipFileKey!);
                        },
                  child: const Text('다운로드')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout(
      scaffoldKey: _scaffoldKey,
      appBar: MainAppBar(mainTitle: '의결권 위임'),
      create: (BuildContext context) => AcceptanceListBloc()..add(const AcceptanceListEvent.onInit()),
      builder: (BuildContext context, AcceptanceListBloc bloc, AcceptanceListState state) {
        return _buildScreen(context: context, bloc: bloc, state: state);
      },
    );
  }

  Widget _buildScreen(
      {required BuildContext context, required AcceptanceListBloc bloc, required AcceptanceListState state}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _buildSearchBar(state),
          const SizedBox(height: 20),
          _buildDataGrid(state),
        ],
      ),
    );
  }

  Widget _buildSearchBar(AcceptanceListState state) {
    return CustomSearchBar(
      controller: _controller,
      onSearch: () => _onSearch(),
      onChange: (value) => {},
      prefixWidget: CustomDropdown<BoardSearchType>(
        value: state.searchType,
        items: const [BoardSearchType.title],
        getText: (value) => value.title,
        onChanged: _setSearchType,
      ),
    );
  }

  Widget _buildDataGrid(AcceptanceListState state) {
    return ActionDataGrid(
      postList: state.documentList,
      filterList: const [ActionCategory.linkPaste, ActionCategory.status],
      pagination: _buildPagination(state),
      onMoveDetailScreen: (Post post) {
        context.router
            .push(
          PostDetailRoute(
            stockCode: post.stock!.code,
            stockName: post.stock!.name,
            boardGroup: post.boardGroupType!.value,
            postId: post.id,
            boardGroupCategory: post.boardGroupCategory,
          ),
        )
            .then((value) {
          if (value == true) _onRefresh();
        });
      },
      onDownloadExcel: _onDownloadExcel,
      onDownloadZipFile: (Post post) {
        _onOpenDownloadZipFileDialog(context: context, post: post);
      },
    );
  }

  Widget _buildPagination(AcceptanceListState state) {
    if (state.documentList.isNotEmpty) {
      return ActPagination<AcceptanceListBloc, AcceptanceListState>(
        paging: state.paging,
        onPageChange: (int page) => _onMovePage(page),
      );
    }

    return Container();
  }
}

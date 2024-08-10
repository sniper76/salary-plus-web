import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/model/enum/campaign_search_type.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/dialog/zip_file_download_dialog/bloc/bloc.dart';
import 'package:act_cms/presentation/dialog/zip_file_download_dialog/zip_file_download_dialog.dart';
import 'package:act_cms/presentation/screen/campaign/list/bloc/bloc.dart';
import 'package:act_cms/presentation/util/convert_column.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_filter_button.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CampaignWithDocsScreen extends StatefulWidget {
  const CampaignWithDocsScreen({super.key});

  @override
  State<CampaignWithDocsScreen> createState() => _CampaignWithDocsScreenState();
}

class _CampaignWithDocsScreenState extends State<CampaignWithDocsScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onOpenDownloadDialog(CampaignListBloc bloc, CampaignListState state, Campaign campaign) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<DialogBloc>(
                create: (context) => DialogBloc(ActionPostType.campaign),
              ),
              BlocProvider<CampaignListBloc>(
                create: (context) => CampaignListBloc(),
              ),
            ],
            child: BlocBuilder<CampaignListBloc, CampaignListState>(
              builder: (context, state) {
                return ZipFileDownloadDialog(
                  id: campaign.id,
                  type: ActionPostType.campaign,
                  digitalDocumentDownload: state.selectedCampaignDetail?.sourcePost?.digitalDocumentDownload,
                  onRequestFile: (bool isLock) {
                    bloc.add(CampaignListEvent.onRequestZipFile(campaign.id, isLock));
                  },
                );
              },
            ));
      },
    ).then((value) {
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CampaignListBloc, CampaignListState>(
      appBar: _buildAppBar(),
      create: (BuildContext context) => CampaignListBloc()
        ..add(
          const CampaignListEvent.onInit(),
        ),
      builder: (BuildContext context, CampaignListBloc bloc, CampaignListState state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildScreen(context, bloc, state);
      },
    );
  }

  AppBar _buildAppBar() {
    return MainAppBar(mainTitle: "캠페인");
  }

  Widget _buildScreen(BuildContext context, CampaignListBloc bloc, CampaignListState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: [
          CustomSearchBar(
            controller: _controller,
            onSearch: () {
              bloc.add(CampaignListEvent.onLoadMore(searchKeyword: _controller.text, page: 1));
            },
            onChange: (value) {},
            prefixWidget: CustomDropdown<CampaignSearchType>(
              value: state.searchType,
              items: const [CampaignSearchType.title, CampaignSearchType.stockGroupName],
              getText: (value) => value.title,
              onChanged: (newValue) {
                if (newValue != null) {
                  bloc.add(CampaignListEvent.onSetSearchType(newValue));
                }
              },
            ),
          ),
          Row(children: [
            _buildFilterList(state.boardCategory!, bloc),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  context.router.push(ActionPostRegisterRoute(postType: ActionPostType.campaign)).then((value) {
                    if (value == true) bloc.add(const CampaignListEvent.onInit());
                  });
                },
                child: const Text("캠페인 등록")),
          ]),
          _buildList(context, bloc, state),
        ],
      ),
    );
  }

  Widget _buildFilterList(BoardGroupCategory boardCategory, CampaignListBloc bloc) {
    return BlocListener<CampaignListBloc, CampaignListState>(
      listener: (context, state) {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BoardGroupCategory.defaultCategory(),
          BoardGroupCategory.surveys(),
          BoardGroupCategory.etc(),
        ].map((item) {
          return ActFilterButton(
              text: item.displayName,
              isSelected: boardCategory == item,
              onPressed: () {
                if (boardCategory != item) {
                  bloc.add(CampaignListEvent.onSetBoardCategory(item));
                }
              });
        }).toList(),
      ),
    );
  }

  Widget _buildList(BuildContext context, CampaignListBloc bloc, CampaignListState state) {
    return Expanded(
      child: ListView(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final columns = refineColumns([
                CustomColumn(width: 100, columnName: 'category', labelText: '카테고리'),
                CustomColumn(width: 200, columnName: 'sourceStockGroupName', labelText: '그룹명'),
                CustomColumn(columnName: 'title', labelText: '제목'),
                CustomColumn(width: 100, columnName: 'targetEndDate', labelText: '종료일'),
                CustomColumn(width: 100, columnName: 'mappedStocksCount', labelText: '참여종목'),
                CustomColumn(width: 150, columnName: 'joinUserCount', labelText: '참여인원'),
                CustomColumn(width: 150, columnName: 'download', labelText: ''),
              ], constraints.maxWidth);
              return ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: ActDataGrid(
                  dataSource: GenericDataSource<Campaign>(
                    data: state.campaigns,
                    columnNames: columns.map((e) => e.columnName).toList(),
                    valueExtractors: {
                      'category': (Campaign item, int index) => item.boardCategory?.title,
                      'sourceStockGroupName': (Campaign item, int index) => item.sourceStockGroupName,
                      'title': (Campaign item, int index) => item.title,
                      'targetEndDate': (Campaign item, int index) => item.targetEndDate?.toFormatString(),
                      'mappedStocksCount': (Campaign item, int index) => item.mappedStocksCount,
                      'joinUserCount': (Campaign item, int index) => ConvertColumn.formatNumber(item.joinUserCount),
                      'download': (Campaign item, int index) => item,
                    },
                    columnAlignments: {'title': Alignment.centerLeft},
                    customWidgets: {
                      'download': (Campaign item) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5)),
                          ),
                          child: _buildDownloadButton(context, bloc, state, item),
                        );
                      }
                    },
                  ),
                  columns: columns,
                  onCellTap: (details) {
                    final rowIndex = details.rowColumnIndex.rowIndex - 1;
                    if (rowIndex >= 0) {
                      onCampaignDetailPressed(bloc, state.campaigns[rowIndex]);
                    }
                  },
                ),
              );
            },
          ),
          if (state.campaigns.isNotEmpty) _buildPagination(context, bloc, state),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, CampaignListBloc bloc, CampaignListState state) {
    return ActPagination<CampaignListBloc, CampaignListState>(
      paging: state.paging,
      onPageChange: (int page) {
        bloc.add(CampaignListEvent.onLoadMore(page: page));
      },
    );
  }

  Widget _buildDownloadButton(BuildContext context, CampaignListBloc bloc, CampaignListState state, Campaign campaign) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () {
                bloc.add(CampaignListEvent.onDownloadCSV(campaign.id));
              },
              child: SvgPicture.asset('assets/images/ic_xlsx.svg'),
            ),
          ),
          (campaign.isPoll == true)
              ? const SizedBox(
                  width: 32,
                  child: Text(
                    "-",
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      _onOpenDownloadDialog(bloc, state, campaign);
                    },
                    child: SvgPicture.asset('assets/images/ic_download.svg'),
                  ),
                ),
        ],
      ),
    );
  }

  onCampaignDetailPressed(CampaignListBloc bloc, Campaign campaign) async {
    await context.router.push(CampaignDetailRoute(campaignId: campaign.id));
  }
}

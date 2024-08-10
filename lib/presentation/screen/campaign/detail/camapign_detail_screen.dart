import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/campaign/detail/bloc/bloc.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/widget/act_comment_list/act_comments_list.dart';
import 'package:act_cms/presentation/widget/act_comment_list/bloc/act_comment_list_bloc.dart';
import 'package:act_cms/presentation/widget/act_detail_post.dart';
import 'package:act_cms/presentation/widget/act_round_based_widget.dart';
import 'package:act_cms/presentation/widget/button/act_delete_button.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CampaignDetailScreen extends StatefulWidget {
  final int campaignId;

  const CampaignDetailScreen({super.key, @pathParam required this.campaignId});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  OverlayEntry? overlayEntry;
  final textFieldTargetKey = GlobalKey();
  final TextEditingController _controllerSearchStock = TextEditingController();

  _onDeleteCampaign({required int campaignId}) async {
    final bloc = _scaffoldKey.currentContext?.read<CampaignDetailBloc>();
    if (bloc == null) return;
    final confirm = await context.showConfirmDialog(title: '캠페인 삭제', message: '캠페인을 삭제하시겠습니까?');
    if (confirm) {
      bloc.add(CampaignDetailEvent.onDeleteCampaign(campaignId));
      context.router.pop(true);
    }
  }

  _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  _onCreateOverlayList() {
    final currentContext = _scaffoldKey.currentContext;
    if (currentContext == null) return;
    final bloc = BlocProvider.of<CampaignDetailBloc>(currentContext);
    final currentState = bloc.state;

    overlayEntry = createSimpleStockOverlay(
      context: context,
      textFieldKey: textFieldTargetKey,
      simpleStockList: currentState.simpleStockList.map((stock) => stock.stock).toList(),
      onListTap: (int i) {
        _controllerSearchStock.text = currentState.simpleStockList[i].stock.name;
        bloc.add(CampaignDetailEvent.onSetStock(currentState.simpleStockList[i]));
        overlayEntry?.remove();
        overlayEntry = null;
      },
      oldOverlayEntry: overlayEntry,
      removeOverlay: _removeOverlay,
      sidebarSize: 300,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CampaignDetailBloc, CampaignDetailState>(
        scaffoldKey: _scaffoldKey,
        create: (BuildContext context) => CampaignDetailBloc()..add(CampaignDetailEvent.onInit(widget.campaignId)),
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(mainTitle: "캠페인 보기", context: context),
        listener: (context, state) => {},
        builder: (context, bloc, state) {
          if (state.detailCampaign == null) return Container();
          return Column(
            children: [
              _buildSearchStock(context, bloc, state),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildPost()),
                    Expanded(child: ActRoundBasedWidget(child: _buildComments())),
                  ],
                ),
              ),
              if (state.detailCampaign != null) ...[
                _buildButtons(bloc, state.detailCampaign!, state.selectedStock!.stock),
                const SizedBox(height: 16),
              ]
            ],
          );
        });
  }

  Widget _buildSearchStock(BuildContext context, CampaignDetailBloc bloc, CampaignDetailState state) {
    return Row(
      children: [
        Expanded(
          child: ActRoundBasedWidget(
            child: Row(
              children: [
                const Text('종목'),
                const SizedBox(width: 16),
                BlocListener<CampaignDetailBloc, CampaignDetailState>(
                    listenWhen: (previousState, currentState) =>
                        previousState.simpleStockList != currentState.simpleStockList,
                    listener: (context, state) {
                      if (state.simpleStockList.isNotEmpty) {
                        _onCreateOverlayList();
                      } else {
                        _removeOverlay();
                      }
                    },
                    child: Expanded(
                      child: TextField(
                        key: textFieldTargetKey,
                        controller: _controllerSearchStock,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                          ),
                        ),
                        onChanged: (searchText) {
                          bloc.add(CampaignDetailEvent.onSearchStock(searchText));
                        },
                        onTap: _onCreateOverlayList,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPost() {
    return BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
      builder: (context, state) {
        final post = state.detailPost;
        if (post == null) return ActRoundBasedWidget(child: Container());

        return ActDetailPost(
          post: post,
          boardGroupCategoryName: BoardGroupType.action.title,
        );
      },
    );
  }

  Widget _buildComments() {
    return Navigator(
      initialRoute: 'commentEdit',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => BlocBuilder<CampaignDetailBloc, CampaignDetailState>(builder: (context, state) {
            final post = state.detailPost;
            if (post == null) return ActRoundBasedWidget(child: Container());

            return BlocProvider<ActCommentListBloc>(
              create: (context) => ActCommentListBloc(
                stockCode: state.selectedStock?.stock.code ?? '',
                boardGroupCategory: state.detailCampaign?.sourcePost?.boardCategory,
                post: post,
                boardGroupType: state.detailCampaign?.sourcePost?.boardGroup ?? BoardGroupType.action,
              ),
              child: ActCommentsList(
                stockCode: state.selectedStock?.stock.code ?? '',
                stockName: state.selectedStock?.stock.name ?? '',
                boardGroup: (state.detailCampaign?.sourcePost?.boardGroup ?? BoardGroupType.action).title,
                userMe: state.userMe,
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildButtons(CampaignDetailBloc bloc, Campaign campaign, SimpleStock stock) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActDeleteButton(onPressed: () => _onDeleteCampaign(campaignId: campaign.id)),
        const SizedBox(width: 20),
        ElevatedButton(
            onPressed: () {
              context.router
                  .push(
                PostRegisterRoute(
                  boardGroupType: campaign.sourcePost?.boardGroup ?? BoardGroupType.action,
                  updatePost: Post(
                    id: campaign.id,
                    title: campaign.title,
                    createdAt: campaign.createdAt,
                    updatedAt: campaign.updatedAt,
                    status: campaign.sourcePost?.status ?? PostStatusType.active,
                    content: campaign.sourcePost?.content ?? '',
                    userProfile: campaign.sourcePost!.userProfile,
                    boardGroupCategory: campaign.sourcePost?.boardCategory,
                    boardGroupType: campaign.sourcePost?.boardGroup ?? BoardGroupType.action,
                    isActive: campaign.sourcePost?.isActive ?? true,
                    userId: campaign.sourcePost?.userId ?? 0,
                    polls: campaign.sourcePost?.polls,
                    digitalDocument: campaign.sourcePost?.digitalDocument,
                  ),
                  updateStockGroup:
                      SimpleStockGroup(id: campaign.sourceStockGroupId, name: campaign.sourceStockGroupName),
                  campaignTitle: campaign.title,
                ),
              )
                  .then(
                (value) {
                  bloc.add(CampaignDetailEvent.onInit(widget.campaignId));
                },
              );
            },
            child: const Text("수정"))
      ],
    );
  }
}

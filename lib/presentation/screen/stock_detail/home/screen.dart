import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/election_status.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/model/stock_home/dashboard/dashboard.dart';
import 'package:act_web/domain/model/stock_home/dashboard/dashboard_item.dart';
import 'package:act_web/domain/model/stock_home/dashboard/variation.dart';
import 'package:act_web/domain/model/stock_home/section/section_header.dart';
import 'package:act_web/domain/model/stock_home/section/section_item.dart';
import 'package:act_web/domain/model/stock_home/solidarity_leader.dart';
import 'package:act_web/presentation/base/base_bloc_layout.dart';
import 'package:act_web/presentation/screen/stock_detail/home/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_list_title_widget.dart';
import 'package:act_web/presentation/widget/act_logo_widget.dart';
import 'package:act_web/presentation/widget/act_ranking_widget/widget.dart';
import 'package:act_web/presentation/widget/act_search_widget/widget.dart';
import 'package:act_web/presentation/widget/action_post_list_item_widget.dart';
import 'package:act_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:act_web/presentation/widget/post_list_item_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'widget/section_widget.dart';
part 'widget/dashboard_widget.dart';
part 'widget/solidarity_leader_widget.dart';
part 'widget/solidarity_leader_election_notice_widget.dart';
part 'widget/solidarity_leader_message_update_dialog.dart';
part 'widget/post_list_preview_widget.dart';

part 'handler.dart';

@RoutePage()
class StockHomeScreen extends StatefulWidget {
  final String stockCode;

  const StockHomeScreen({
    super.key,
    @pathParam required this.stockCode,
  });

  @override
  State<StockHomeScreen> createState() => _StockHomeScreenState();
}

class _StockHomeScreenState extends State<StockHomeScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (GetIt.I.isRegistered<StockHomeBloc>(instanceName: widget.stockCode) == false) {
      GetIt.I.registerSingleton(StockHomeBloc(stockCode: widget.stockCode), instanceName: widget.stockCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<StockHomeBloc, StockHomeState>(
      appBarbuilder: (context, bloc, state) {
        return DefaultActWebAppBar();
      },
      create: (context) => GetIt.I<StockHomeBloc>(instanceName: widget.stockCode)..add(const StockHomeEvent.init()),
      listener: (context, state) async {},
      builder: (context, bloc, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: AppConfig.leftSectionWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70.0),
                  const SizedBox(
                    width: 550.0,
                    child: ActSearchWidget(),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ActLogoWidget(
                        width: 40,
                        height: 40,
                        stockCode: widget.stockCode,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        state.stockHome?.stock?.name ?? '',
                        style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        widget.stockCode,
                        style: context.textTheme.displaySmall?.copyWith(color: Colors.grey.shade300),
                      ),
                    ],
                  ),
                  if (state.stockHome?.dashboard?.items.isNotEmpty == true) ...[
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: _DashboardWidget(
                                dashboard: state.stockHome!.dashboard!,
                              ),
                            ),
                            Expanded(
                              child: _SolidarityLeaderWidget(
                                bloc: bloc,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (state.stockHome?.leaderElectionDetail?.electionStatus != null &&
                      state.stockHome?.leaderElectionDetail?.electionStatus != ElectionStatus.finished) ...[
                    const SizedBox(
                      height: 24.0,
                    ),
                    const _SolidarityLeaderElectionNoticeWidget(),
                  ],
                  if (state.debatePostList.isNotEmpty) ...[
                    const SizedBox(
                      height: 24.0,
                    ),
                    _PostListPreviewWidget(
                      boardGroupType: BoardGroupType.debate,
                      stockCode: widget.stockCode,
                      postListPreviews: state.debatePostList,
                    ),
                  ],
                  if (state.analysisPostList.isNotEmpty) ...[
                    const SizedBox(
                      height: 24.0,
                    ),
                    _PostListPreviewWidget(
                      boardGroupType: BoardGroupType.analysis,
                      stockCode: widget.stockCode,
                      postListPreviews: state.analysisPostList,
                    ),
                  ],
                  if (state.actionPostList.isNotEmpty) ...[
                    const SizedBox(
                      height: 24.0,
                    ),
                    _PostListPreviewWidget(
                      boardGroupType: BoardGroupType.action,
                      stockCode: widget.stockCode,
                      postListPreviews: state.actionPostList,
                    ),
                  ],
                  const SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  height: 100.0,
                ),
                SizedBox(
                  width: AppConfig.rankingWidgetWidth,
                  child: ActRankingWidget(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<StockHomeBloc>(instanceName: widget.stockCode);
    super.dispose();
  }
}

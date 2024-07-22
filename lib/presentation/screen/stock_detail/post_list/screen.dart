import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/presentation/base/base_bloc_layout.dart';
import 'package:act_web/presentation/screen/stock_detail/home/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_logo_widget.dart';
import 'package:act_web/presentation/widget/act_post_list_widget/widget.dart';
import 'package:act_web/presentation/widget/act_ranking_widget/widget.dart';
import 'package:act_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'section/post_list_title_section.dart';

@RoutePage()
class StockPostListScreen extends StatefulWidget {
  final String stockCode;
  final String boardGroupTypeName;

  const StockPostListScreen({
    super.key,
    @pathParam required this.stockCode,
    @pathParam required this.boardGroupTypeName,
  });

  @override
  State<StockPostListScreen> createState() => _StockPostListScreenState();
}

class _StockPostListScreenState extends State<StockPostListScreen> with SingleTickerProviderStateMixin {
  late final BoardGroupType boardGroupType = BoardGroupType.values.byName(widget.boardGroupTypeName.toLowerCase());

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
                  const SizedBox(height: 100.0),
                  if (widget.stockCode != AppConfig.globalBoardCode)
                    _PostListTitleSection(
                      boardGroupType: boardGroupType,
                      stockCode: widget.stockCode,
                      stockName: state.stockHome?.stock?.name ?? '',
                    ),
                  ActPostListWidget(
                    stockCode: widget.stockCode,
                    boardGroupType: boardGroupType,
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

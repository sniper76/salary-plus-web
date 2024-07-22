import 'package:act_web/config/constants.dart';
import 'package:act_web/config/theme.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/data/response/paging.dart';
import 'package:act_web/domain/model/ranking/search_ranking.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/presentation/base/base_bloc_layout.dart';
import 'package:act_web/presentation/screen/stock/bloc/bloc.dart';
import 'package:act_web/presentation/screen/stock/widget/my_solidarity_list_item_widget.dart';
import 'package:act_web/presentation/screen/stock/widget/my_solidarity_order_item_widget.dart';
import 'package:act_web/presentation/widget/act_list_title_widget.dart';
import 'package:act_web/presentation/widget/act_pagination.dart';
import 'package:act_web/presentation/widget/act_ranking_widget/widget.dart';
import 'package:act_web/presentation/widget/act_search_widget/widget.dart';
import 'package:act_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';

part 'widget/search_ranking_widget.dart';
part 'widget/my_solidarity_list_widget.dart';
part 'widget/my_solidarity_order_update_dialog.dart';

@RoutePage()
class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    if (GetIt.I.isRegistered<StockBloc>() == false) GetIt.I.registerSingleton(StockBloc());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<StockBloc, StockState>(
      appBarbuilder: (context, bloc, state) {
        return DefaultActWebAppBar();
      },
      backgroundColor: Colors.white,
      create: (_) => GetIt.I<StockBloc>()..add(const StockEvent.init()),
      listener: (context, state) async {
        if (state.isWholeMySolidarityListFetched == true) {
          await _MySolidarityOrderUpdateDialog.show(context: context);
        }
      },
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
                    children: state.searchRankingList
                        .mapIndexed((int index, SearchRanking searchRanking) => Expanded(
                              child: Padding(
                                padding: index != state.searchRankingList.length - 1
                                    ? const EdgeInsets.only(right: 30.0)
                                    : const EdgeInsets.all(0.0),
                                child: _SearchRankingWidget(
                                  searchRanking: searchRanking,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 25),
                  _MySolidarityListWidget(
                    mySolidarityList: state.pagedMySolidarityList,
                    mySolidarityPaging: state.mySolidarityPaging,
                    onTapSolidarityOrderUpdateButton: () {
                      if (state.isLoading) return;
                      bloc.add(const StockEvent.fetchMySolidarity(page: 1, isFetchingWhole: true));
                    },
                    onChangePage: (page) {
                      bloc.add(StockEvent.changePage(page: page));
                    },
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
    GetIt.I.unregister<StockBloc>();
    super.dispose();
  }
}

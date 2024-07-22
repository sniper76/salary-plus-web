import 'package:act_web/config/theme.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/domain/enum/ranking_sort_type.dart';
import 'package:act_web/domain/model/ranking/ranking_stock.dart';
import 'package:act_web/presentation/widget/act_ranking_widget/bloc/bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

part 'handler.dart';

part 'widget/ranking_delta_widget.dart';
part 'widget/ranking_sort_widget.dart';
part 'widget/ranking_table_header_widget.dart';
part 'widget/ranking_table_market_value_and_stake_column_widget.dart';
part 'widget/ranking_table_order_column_widget.dart';
part 'widget/ranking_table_stock_name_column_widget.dart';

class ActRankingWidget extends StatefulWidget {
  const ActRankingWidget({super.key});

  @override
  State<ActRankingWidget> createState() => _ActRankingWidgetState();
}

class _ActRankingWidgetState extends State<ActRankingWidget> {
  @override
  void initState() {
    if (GetIt.I.isRegistered<RankingBloc>() == false) {
      GetIt.I.registerSingleton(RankingBloc());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      bloc: GetIt.I<RankingBloc>()..add(const RankingEvent.init()),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/ic_trophy.svg',
                  width: 55,
                ),
                const SizedBox(width: 20),
                Text(
                  '액트 종목 랭킹',
                  style: context.textTheme.displayLarge,
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Wrap(
              spacing: 12.0,
              children: List.generate(
                state.rankingSortTypeList.length,
                (index) {
                  RankingSortType sortType = state.rankingSortTypeList[index];
                  bool isSelectedType = sortType == state.currentSortType;
                  return _RankingSortWidget(
                    isSelectedType: isSelectedType,
                    type: sortType,
                    onChangeRankingSort: () {
                      _onChangeSortType(sortType);
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor[400],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: _RankingTableHeaderWidget(mainString: '순위'),
                        ),
                        const Expanded(flex: 2, child: _RankingTableHeaderWidget(mainString: '종목명')),
                        Expanded(
                          flex: 3,
                          child: _RankingTableHeaderWidget(
                            mainString: state.currentSortType.mainString,
                            subString: '(${state.currentSortType.subString})',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 580,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(state.rankingStockList.length, (index) {
                            final RankingStock rankingStock = state.rankingStockList[index];
                            final String mainString = rankingStock.getMainString(state.currentSortType);
                            final String subString = rankingStock.getSubString(state.currentSortType);

                            return InkWell(
                              onTap: () {
                                context.router.pushNamed('/stock/${rankingStock.stockCode}/home');
                              },
                              child: Container(
                                decoration: BoxDecoration(color: index.isOdd ? Colors.grey.shade100 : Colors.white),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: _RankingTableOrderColumnWidget(
                                        rankingString: '${index + 1}',
                                        subWidget: _RankingDeltaWidget(
                                          sortType: state.currentSortType,
                                          rankingStock: rankingStock,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: _RankingTableStockNameColumnWidget(
                                        stockNameString: rankingStock.stockName,
                                        index: index,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: _RankingTableMarketValueAndStakeColumnWidget(
                                        mainString: mainString,
                                        subString: subString,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        );
      },
    );
  }
}

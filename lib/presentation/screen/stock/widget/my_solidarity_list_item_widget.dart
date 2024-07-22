import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/presentation/widget/act_logo_widget.dart';
import 'package:act_web/presentation/widget/act_ranking_delta_widget.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

class MySolidarityListItemWidget extends StatelessWidget {
  final Solidarity solidarity;

  const MySolidarityListItemWidget({super.key, required this.solidarity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.pushNamed('/stock/${solidarity.code}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ActLogoWidget(stockCode: solidarity.code),
                const SizedBox(width: 8.0),
                SizedBox(
                  width: 240,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          solidarity.name,
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        solidarity.code,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24.0),
                Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Text(
                        '${solidarity.stakeRank ?? '-'}위',
                        style: context.textTheme.bodySmall,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ActRankingDeltaWidget(
                      rankingDelta: solidarity.stakeRankDelta,
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${solidarity.memberCount.toNumberFormat}명',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 24.0),
                SizedBox(
                  width: 60.0,
                  child: Text(
                    '${solidarity.stake.toStringAsFixed(2)}%',
                    style: context.textTheme.headlineSmall,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:act_cms/domain/model/dashboard_statistics_item.dart';
import 'package:act_cms/domain/model/dashboard_statistics_summary.dart';
import 'package:act_cms/domain/model/enum/period_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:act_cms/presentation/widget/charts/common/chart_title.dart' as act;

class LineChart extends StatelessWidget {
  final String? title;
  final String? mainValue;
  final DashboardStatisticsSummary? summary;
  final List<DashboardStatisticsItem> items;
  final PeriodType? periodType;
  final Color mainColor;

  const LineChart({
    super.key,
    this.title,
    this.mainValue,
    this.summary,
    required this.items,
    this.periodType,
    this.mainColor = const Color(0xffFF0000),
  });

  static const Color tickLabelColor = Color(0xff999999);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildValueChange(),
        const SizedBox(height: 24),
        _buildChart(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (mainValue != null) _buildChartMainValue(),
        if (title != null) act.ChartTitle(title: title),
      ],
    );
  }

  DateTime? _setValueMapper(DashboardStatisticsItem dataItem, _) {
    if (periodType == PeriodType.monthly) {
      return DateTime.parse("${dataItem.key}-01");
    } else {
      return DateTime.parse(dataItem.key);
    }
  }

  Widget _buildChartMainValue() {
    return Text(
      mainValue!,
      style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xff333333)),
    );
  }

  Widget _buildValueChange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(summary?.upDown.icon, color: summary?.upDown.color, size: 16.0),
            const SizedBox(width: 2),
            Text(
              summary?.upDownPercent ?? "0%",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: summary?.upDown.color),
            ),
          ],
        ),
        Text(
          summary?.upDownText ?? "",
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xff999999)),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Expanded(
      child: SfCartesianChart(
        margin: EdgeInsets.zero,
        primaryYAxis: NumericAxis(
          desiredIntervals: 4,
          labelStyle: const TextStyle(fontSize: 8, color: tickLabelColor),
          majorTickLines: const MajorTickLines(size: 0),
          axisLine: const AxisLine(width: 0),
          numberFormat: NumberFormat.compact(locale: "ko_KR"),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          AreaSeries<DashboardStatisticsItem, DateTime>(
            dataSource: items,
            enableTooltip: true,
            name: title,
            xValueMapper: _setValueMapper,
            yValueMapper: (DashboardStatisticsItem dataItem, _) => dataItem.value,
            color: mainColor.withAlpha(25),
            borderDrawMode: BorderDrawMode.top,
            borderWidth: 1,
            borderColor: mainColor,
            markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              width: 2,
              height: 2,
              color: mainColor,
            ),
          ),
        ],
        primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          intervalType: DateTimeIntervalType.auto,
          labelStyle: const TextStyle(fontSize: 8, color: tickLabelColor),
          majorTickLines: const MajorTickLines(size: 0),
          axisLine: const AxisLine(width: 0),
        ),
      ),
    );
  }
}

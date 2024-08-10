import 'package:act_cms/domain/model/dashboard_statistics_basic_item.dart';
import 'package:act_cms/presentation/widget/charts/common/chart_title.dart' as act;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChart extends StatelessWidget {
  final String? title;
  final List<DashboardStatisticsBasicItem> items;
  final double? fontSize;
  final double gap;

  const DonutChart({super.key, this.title, required this.items, this.fontSize, this.gap = 8});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [if (title != null) _buildTitle(), _buildChart()],
    );
  }

  Widget _buildTitle() {
    return Align(alignment: Alignment.topCenter, child: act.ChartTitle(title: title));
  }

  Widget _buildChart() {
    return Expanded(
      flex: 1,
      child: SfCircularChart(
        legend: _buildLegend(),
        margin: EdgeInsets.zero,
        series: <CircularSeries>[
          DoughnutSeries<DashboardStatisticsBasicItem, String>(
            dataSource: items,
            xValueMapper: (DashboardStatisticsBasicItem data, _) => data.title,
            yValueMapper: (DashboardStatisticsBasicItem data, _) => data.value,
            pointColorMapper: (DashboardStatisticsBasicItem data, index) => data.color,
          ),
        ],
      ),
    );
  }

  Legend _buildLegend() {
    return Legend(
        isVisible: true,
        legendItemBuilder: (String name, dynamic series, dynamic point, int index) {
          final item = items[index];
          final color = item.color;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLegendIcon(color),
                SizedBox(width: gap),
                Text(item.title, style: TextStyle(fontSize: fontSize)),
                SizedBox(width: gap),
                Text("(${item.percent})", style: TextStyle(color: const Color(0xff999999), fontSize: fontSize)),
                SizedBox(width: gap),
                Icon(item.upDown.icon, color: item.upDown.color, size: 20),
                SizedBox(width: gap),
                Text(item.upDownPercent, style: TextStyle(color: item.upDown.color, fontSize: fontSize))
              ],
            ),
          );
        });
  }

  Widget _buildLegendIcon(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    );
  }
}

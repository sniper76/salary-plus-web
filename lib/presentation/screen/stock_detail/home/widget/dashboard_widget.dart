part of '../screen.dart';

class _DashboardWidget extends StatelessWidget {
  final Dashboard? dashboard;

  const _DashboardWidget({required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return dashboard == null
        ? Center(
            child: Text(
              '집계중입니다.',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...dashboard!.items.map(
                  (DashboardItem dashboardItem) => _DashboardListWidget(
                    dashboardItem: dashboardItem,
                  ),
                ),
                if (dashboard!.descriptionLabel?.isNotEmpty == true) ...[
                  Text(
                    dashboard!.descriptionLabel!,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                ]
              ],
            ),
          );
  }
}

class _DashboardListWidget extends StatelessWidget {
  final DashboardItem dashboardItem;

  const _DashboardListWidget({
    required this.dashboardItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            dashboardItem.title,
            style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade800),
          ),
          const Spacer(),
          Text(
            dashboardItem.value,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              dashboardItem.variation.text,
              style: context.textTheme.bodyMedium?.copyWith(color: dashboardItem.variation.color),
            ),
          ),
        ],
      ),
    );
  }
}

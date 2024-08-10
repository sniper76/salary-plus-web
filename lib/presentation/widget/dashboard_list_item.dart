import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/dashboard_item.dart';
import 'package:act_cms/domain/model/variation.dart';
import 'package:flutter/material.dart';

class DashboardListItem extends StatelessWidget {
  final DashboardItem item;

  const DashboardListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              item.title,
              style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade800, fontWeight: FontWeight.bold),
            ),
          ),
          // const Spacer(),

          Text(
            item.value,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.normal,
            ),
          ),
          if (item.variation != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "( ${item.variation!.text} )",
                style: context.textTheme.bodyMedium?.copyWith(color: item.variation!.color),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/section_header.dart';
import 'package:act_cms/domain/model/section_item.dart';
import 'package:act_cms/presentation/widget/section_list_item.dart';
import 'package:flutter/material.dart';

class SectionListView extends StatelessWidget {
  final SectionHeader? header;
  final List<SectionItem> listItems;

  const SectionListView({
    super.key,
    this.header,
    this.listItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                header?.title ?? '',
                style: context.textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (header?.link.isNotEmpty == true)
                TextButton(
                  onPressed: () => context.openLink(header?.link ?? ''),
                  child: Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '더보기',
                        style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600, height: 1.2),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        const SizedBox(height: 8),
        ...listItems.map(
          (e) => SectionListItem(
            sectionItem: e,
            margin: const EdgeInsets.only(top: 16),
          ),
        ),
        if (listItems.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                '최근 3개월 간 내용이 없습니다',
                style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
              ),
            ),
          ),
      ],
    );
  }
}

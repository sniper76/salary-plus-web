import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/section_item.dart';
import 'package:act_cms/presentation/widget/counter_view.dart';
import 'package:flutter/material.dart';

class SectionListItem extends StatelessWidget {
  final SectionItem sectionItem;
  final EdgeInsets? margin;
  final bool visibleViewCount;

  const SectionListItem({
    super.key,
    required this.sectionItem,
    this.margin,
    this.visibleViewCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (sectionItem.isDeleted) {
          context.showAlertDialog(title: '삭제된 게시글', message: sectionItem.title);
          return;
        }

        if (sectionItem.isReported) {
          context.showAlertDialog(title: '신고된 게시글', message: sectionItem.title);
          return;
        }
        context.openLink(sectionItem.link);
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (sectionItem.boardGroupCategory != null)
                        Row(
                          children: [
                            Text(
                              '[${sectionItem.boardGroupCategory?.displayName}]',
                              style: context.textTheme.headlineSmall?.copyWith(
                                  color: sectionItem.isActive ? context.colorScheme.primary : Colors.grey.shade400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 6),
                          ],
                        ),
                      Expanded(
                        child: Text(
                          sectionItem.title,
                          style: context.textTheme.headlineSmall
                              ?.copyWith(color: sectionItem.isActive ? Colors.grey.shade900 : Colors.grey.shade400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: visibleViewCount ? 14 : 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        sectionItem.createdAt.toFormatString(),
                        style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400),
                      ),
                      CounterView(
                        icon: Icons.favorite,
                        value: sectionItem.likeCount,
                      ),
                      CounterView(
                        icon: Icons.comment,
                        value: sectionItem.commentCount,
                      ),
                      if (visibleViewCount)
                        CounterView(
                          icon: Icons.remove_red_eye_outlined,
                          value: sectionItem.viewCount,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

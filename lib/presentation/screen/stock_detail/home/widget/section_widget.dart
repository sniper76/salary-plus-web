part of '../screen.dart';

class _SectionWidget extends StatelessWidget {
  final String stockCode;
  final List<SectionItem> listItems;
  final BoardGroupType boardGroupType;
  final SectionHeader? header;

  const _SectionWidget({
    required this.stockCode,
    required this.listItems,
    required this.boardGroupType,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          ActListTitleWidget(
            titleSvgAssetPath: boardGroupType.iconPath,
            titleText: header!.title,
            trailingWidget: InkWell(
              onTap: () {
                context.router.pushNamed('/stock/$stockCode/${boardGroupType.value}');
              },
              child: Row(
                children: [
                  Text(
                    '더보기',
                    style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 15.0,
                  ),
                ],
              ),
            ),
          ),
        Container(height: 1, color: Colors.grey.shade300),
        ...List.generate(
          listItems.length,
          (int index) => Column(
            children: [
              PostListItemWidget(
                title: listItems[index].title,
                isUploadedImageExist: listItems[index].thumbnailImageUrl?.isNotEmpty == true,
                nickname: listItems[index].userProfile?.nickname ?? '',
                createdAt: listItems[index].createdAt,
                likeCount: listItems[index].likeCount,
                viewCount: listItems[index].viewCount,
                commentCount: listItems[index].commentCount,
                postDetailpath: listItems[index].link,
              ),
              if (index != listItems.length - 1) Container(height: 1, color: Colors.grey.shade300),
            ],
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

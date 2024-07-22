part of '../widget.dart';

class _PageSizeChangerWidget extends StatelessWidget {
  final int pageSize;
  final bool isCurrentPageSize;

  const _PageSizeChangerWidget({required this.pageSize, required this.isCurrentPageSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ActPostListWidgetBloc>().add(ActPostListWidgetEvent.chagePageSize(size: pageSize));
      },
      child: Text(
        '$pageSize개보기',
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: isCurrentPageSize ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

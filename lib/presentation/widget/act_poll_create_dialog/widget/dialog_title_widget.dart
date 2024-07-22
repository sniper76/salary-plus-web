part of '../widget.dart';

class _DialogTitleWidget extends StatelessWidget {
  final String title;

  const _DialogTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.displaySmall,
        ),
        InkWell(
          onTap: () {
            context.router.maybePop();
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}

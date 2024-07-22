part of '../screen.dart';

class _PostSaveWidget extends StatelessWidget {
  final bool isRegisterPage;
  final void Function()? onTapPostSaveWidget;

  const _PostSaveWidget({required this.isRegisterPage, required this.onTapPostSaveWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextButton(
        onPressed: onTapPostSaveWidget,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          minimumSize: const Size(double.infinity, 42),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          isRegisterPage ? '등록하기' : '수정하기',
          style: context.textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

part of '../widget.dart';

class _WebLoginGuideDialog extends StatelessWidget {
  const _WebLoginGuideDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800.0,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '웹 로그인 안내',
                  style: context.textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    context.router.maybePop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Image.asset(
              'assets/images/login_guide.png',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

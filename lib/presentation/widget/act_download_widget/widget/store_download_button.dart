part of '../widget.dart';

class _StoreDownloadButton extends StatelessWidget {
  final bool isQrCodeVisible;
  final PlatformType platformType;
  final GlobalKey<State<StatefulWidget>> buttonKey;
  final Function() onTapDownloadButton;

  const _StoreDownloadButton({
    required this.isQrCodeVisible,
    required this.platformType,
    required this.buttonKey,
    required this.onTapDownloadButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        TextButton(
          key: buttonKey,
          onPressed: onTapDownloadButton,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
            ),
            alignment: Alignment.center,
            fixedSize: const Size.fromWidth(210),
            backgroundColor: Colors.grey.shade200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                platformType.assetPath,
                width: 30,
              ),
              const SizedBox(width: 8.0),
              Text(
                platformType.buttonString,
                style: context.textTheme.bodyLarge?.copyWith(height: 1),
              ),
            ],
          ),
        ),
        if (isQrCodeVisible)
          _QrCodePopup(
            buttonKey: buttonKey,
            url: platformType.url,
          ),
      ],
    );
  }
}

class _QrCodePopup extends StatelessWidget {
  final GlobalKey buttonKey;
  final String url;
  late final RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;

  _QrCodePopup({
    required this.buttonKey,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: renderBox.size.height + 10,
      child: Material(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: QrImageView(
            data: url,
            version: QrVersions.auto,
            size: 150.0,
          ),
        ),
      ),
    );
  }
}

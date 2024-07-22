import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

part 'handler.dart';
part 'widget/store_download_button.dart';
part 'enum/platform_type.dart';

class ActDownloadWidget extends StatefulWidget {
  const ActDownloadWidget({super.key});

  @override
  State<ActDownloadWidget> createState() => _ActDownloadWidgetState();
}

class _ActDownloadWidgetState extends State<ActDownloadWidget> {
  final GlobalKey _iosKey = GlobalKey();
  final GlobalKey _androidKey = GlobalKey();

  bool _isIosQrCodeVisible = false;
  bool _isAndroidQrCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '앱 다운로드',
          style: context.textTheme.displaySmall,
        ),
        const SizedBox(height: 10.0),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -28,
              child: Text(
                '클릭시 QR코드가 생성됩니다. QR코드를 통해 어플을 간편하게 설치해보세요.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.blueAccent.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StoreDownloadButton(
                  buttonKey: _iosKey,
                  isQrCodeVisible: _isIosQrCodeVisible,
                  onTapDownloadButton: () => _onTapIosDownloadButton(setState),
                  platformType: PlatformType.ios,
                ),
                const SizedBox(width: 20.0),
                _StoreDownloadButton(
                  buttonKey: _androidKey,
                  isQrCodeVisible: _isAndroidQrCodeVisible,
                  onTapDownloadButton: () => _onTapAndroidDownloadButton(setState),
                  platformType: PlatformType.android,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}

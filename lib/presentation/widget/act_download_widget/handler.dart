part of 'widget.dart';

extension _ActDownloadWidgetStateExtension on _ActDownloadWidgetState {
  void _onTapIosDownloadButton(Function(void Function() fn) setState) {
    setState(() {
      _isIosQrCodeVisible = !_isIosQrCodeVisible;
    });
  }

  void _onTapAndroidDownloadButton(Function(void Function() fn) setState) {
    setState(() {
      _isAndroidQrCodeVisible = !_isAndroidQrCodeVisible;
    });
  }
}

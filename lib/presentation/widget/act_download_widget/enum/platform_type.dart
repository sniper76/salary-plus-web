part of '../widget.dart';

enum PlatformType {
  ios(AppConfig.iosDownloadLink, 'assets/images/ic_apple.svg', 'APP STORE'),
  android(AppConfig.androidDownloadLink, 'assets/images/ic_google.svg', 'GOOGLE PLAY'),
  ;

  final String url;
  final String assetPath;
  final String buttonString;

  const PlatformType(
    this.url,
    this.assetPath,
    this.buttonString,
  );
}

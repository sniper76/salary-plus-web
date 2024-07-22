import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_proxy_url.freezed.dart';
part 'digital_proxy_url.g.dart';

@freezed
class DigitalProxyUrl with _$DigitalProxyUrl {
  const factory DigitalProxyUrl({
    required String embeddedUrl,
  }) = _DigitalProxyUrl;

  factory DigitalProxyUrl.fromJson(Map<String, dynamic> json) => _$DigitalProxyUrlFromJson(json);
}

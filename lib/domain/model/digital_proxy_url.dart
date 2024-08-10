import 'package:json_annotation/json_annotation.dart';

part 'digital_proxy_url.g.dart';

@JsonSerializable()
class DigitalProxyUrl {
  final String embeddedUrl;

  const DigitalProxyUrl({required this.embeddedUrl});

  factory DigitalProxyUrl.fromJson(Map<String, dynamic> json) => _$DigitalProxyUrlFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalProxyUrlToJson(this);
}
